#!/usr/bin/env bash
# bootstrap-from-fork.sh --- make a new machine into this home, from this checkout.
#
# Run it from a clone of the fork (see SETUP-FROM-THIS-FORK.md):
#   git clone https://github.com/VagabondKingsman/nodecode.git && cd nodecode
#   bash tools/boxes/bootstrap-from-fork.sh --dry-run     # what it would do
#   bash tools/boxes/bootstrap-from-fork.sh               # do it
#
# Idempotent: every step checks before it writes, so a second run is a report.
# What it cannot do for you: the keys. It says which ones it needs at the end.
#
#   --dry-run      print the plan, change nothing
#   --build        build this checkout with SBCL instead of taking the release
#   --no-gateway   leave the gateway alone (no systemd, or you start it yourself)
#   --check        only verify a home that is already set up
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
HOME_DIR="${NODECODE_HOME:-$HOME/.nodecode}"
SNAP="$HERE/snapshots/$(ls "$HERE/snapshots" 2>/dev/null | sort | tail -1)"

DRY=0 BUILD=0 GATEWAY=1 CHECK=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY=1 ;;
    --build) BUILD=1 ;;
    --no-gateway) GATEWAY=0 ;;
    --check) CHECK=1; DRY=1 ;;
    -h|--help) sed -n '2,20p' "$0"; exit 0 ;;
    *) echo "unknown argument: $arg" >&2; exit 2 ;;
  esac
done

say()  { printf '%s\n' "$*"; }
step() { printf '\n== %s\n' "$*"; }
run()  { if [ "$DRY" -eq 1 ]; then printf '   would: %s\n' "$*"; else eval "$@"; fi }

[ -d "$SNAP" ] || { echo "bootstrap: no snapshots/ directory in $HERE" >&2; exit 1; }
export PATH="$HOME/.local/bin:$PATH"

step "1/7 what this machine already has"
for tool in git curl python3 tar; do
  command -v "$tool" >/dev/null 2>&1 && say "   ok   $tool" || say "   NEED $tool"
done
if command -v nodecode >/dev/null 2>&1; then say "   ok   nodecode $(nodecode --version 2>/dev/null)"
else say "   NEED nodecode (step 2 installs the release)"; fi
say "   home $HOME_DIR · snapshot $(basename "$SNAP")"

if [ "$CHECK" -eq 1 ]; then
  step "check only: what a running home should answer"
  nodecode --version 2>/dev/null || true
  nodecode gateway status 2>/dev/null | head -3 || true
  say "   cells   $(find "$HOME_DIR/cells" -maxdepth 1 -mindepth 1 ! -name '.locks' | wc -l)"
  say "   memory  $(ls "$HOME_DIR"/cells/*-memory/*.lisp 2>/dev/null | wc -l) file(s)"
  [ -x "$HOME_DIR/bin/free-route" ] && "$HOME_DIR/bin/free-route" status || say "   free pool: not installed"
  exit 0
fi

step "2/7 the binary"
if [ "$BUILD" -eq 1 ]; then
  say "   building this checkout (needs SBCL 2.6.0, Quicklisp, just -- see SETUP-FROM-THIS-FORK.md)"
  run "cd '$HERE' && just release"
  H="$(cd "$HERE" && git rev-parse --short=9 HEAD)"
  run "mkdir -p '$HOME/.local/share/nodecode/$H'"
  run "cp '$HERE/nodecode' '$HOME/.local/share/nodecode/$H/nodecode' && chmod 700 '$HOME/.local/share/nodecode/$H/nodecode'"
  run "cp -r '$HERE/src' '$HOME/.local/share/nodecode/$H/'"
  run "ln -sfn '$H' '$HOME/.local/share/nodecode/current'"
elif command -v nodecode >/dev/null 2>&1; then
  say "   keeping $(nodecode --version 2>/dev/null)"
else
  say "   installing the release from nodecode.ai"
  run "curl -fsSL https://nodecode.ai/install.sh | env -u NODECODE_HOME sh"
fi

step "3/7 the home and its config"
run "mkdir -p '$HOME_DIR/cells'"
if [ -f "$HOME_DIR/config.jsonc" ]; then
  say "   keeping the existing config.jsonc"
else
  run "cp '$SNAP/config.redacted.jsonc' '$HOME_DIR/config.jsonc' && chmod 600 '$HOME_DIR/config.jsonc'"
  say "   wrote config.jsonc from the snapshot -- fill its keys, see step 7"
fi

step "4/7 the memory (one file per definition, the index reads them)"
MEM="$HOME_DIR/cells/cursor-agent-memory"
if [ -d "$MEM" ] && [ "$(ls "$MEM"/*.lisp 2>/dev/null | wc -l)" -gt 0 ]; then
  say "   keeping $(ls "$MEM"/*.lisp | wc -l) file(s) already there"
else
  run "mkdir -p '$MEM'"
  run "cp '$SNAP'/memory/*.lisp '$MEM/'"
  run "cp '$SNAP'/memory-cell.asd '$MEM/cursor-agent-memory.asd'"
  say "   copied $(ls "$SNAP"/memory/*.lisp | wc -l) file(s) into $MEM"
fi

step "5/7 the cells"
shipped="$(python3 - "$HERE/cells/bundle.json" <<'PY'
import json, sys, os
d = json.load(open(sys.argv[1]))
print(" ".join(sorted(os.path.basename(v) for v in d["cells"].values())))
PY
)"
local_cells="antigravity cursor-agent cursor-agent-memory nodecode"
hub=""
if [ -f "$SNAP/cells.txt" ]; then
  hub="$(awk '{print $2}' "$SNAP/cells.txt" | grep -v '^\.' | sed 's/^nodecode-//' | sort -u | while read -r c; do
           case " $shipped " in *" nodecode-$c "*) continue ;; esac
           case " $shipped " in *" $c "*) continue ;; esac
           case " $local_cells " in *" $c "*) continue ;; esac
           echo "$c"
         done | tr '\n' ' ')"
fi
say "   shipped with the release: $(echo $shipped | wc -w)"
say "   from the hub: ${hub:-none}"
for c in $hub; do
  [ -d "$HOME_DIR/cells/nodecode-$c" ] || run "nodecode add 'nc://$c' --yes"
done

step "6/7 the free-account pool"
run "mkdir -p '$HOME_DIR/bin' '$HOME/.config/systemd/user'"
run "cp '$HERE'/tools/free-accounts/free-route '$HERE'/tools/free-accounts/free-route-a '$HERE'/tools/free-accounts/free-route-b '$HERE'/tools/free-accounts/free-rungs '$HERE'/tools/free-accounts/free-watch '$HOME_DIR/bin/'"
run "chmod 755 '$HOME_DIR/bin/'free-*"
if [ -f "$HOME_DIR/free-accounts.json" ]; then
  say "   keeping the existing pool"
else
  run "printf '%s' '{\"version\": 2, \"policy\": {}, \"accounts\": []}' > '$HOME_DIR/free-accounts.json' && chmod 600 '$HOME_DIR/free-accounts.json'"
fi
run "'$HOME_DIR/bin/free-rungs' 3"
if [ "$GATEWAY" -eq 1 ] && command -v systemctl >/dev/null 2>&1; then
  run "cp '$HERE'/tools/free-accounts/free-watch.service '$HERE'/tools/free-accounts/free-watch.timer '$HOME/.config/systemd/user/'"
  run "systemctl --user daemon-reload && systemctl --user enable --now free-watch.timer"
fi

step "7/7 the gateway, and what is left to you"
if [ "$GATEWAY" -eq 1 ]; then
  run "nodecode gateway on"
  run "nodecode gateway status | head -3"
fi
cat <<'EOF'

Left to you (the script cannot hold your secrets):
  1. the nodecode.ai keys      nodecode login            (account + its free key)
     or paste free keys        ~/.nodecode/bin/free-route add a < /tmp/a.key
  2. a provider key, if you bring one   ~/.nodecode/auth.json -> api_keys.<id>.key
  3. a GitHub token for the prs cell    ~/.nodecode/gh-token (0600, scope repo)
  4. a model to run on          /models, or general.default_model in config.jsonc
  5. then check                 bash tools/boxes/bootstrap-from-fork.sh --check

Docs: SETUP-FROM-THIS-FORK.md (every step by hand), FREE-ACCOUNTS.md (the pool).
EOF
