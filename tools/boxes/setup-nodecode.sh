#!/usr/bin/env bash
# Bootstrap Nodecode on a Linux cloud box (boxes.dev Template / devbox, Cursor
# cloud, plain VM). Idempotent: safe to re-run.
#
# Usage:
#   curl -fsSL https://nodecode.ai/install.sh | sh   # or run this script
#   bash tools/boxes/setup-nodecode.sh
#   bash tools/boxes/setup-nodecode.sh --serve        # start headless organism
#   bash tools/boxes/setup-nodecode.sh --cells        # turn on web/websearch/guard
#
# Auth (pick one after install):
#   nodecode login                                   # nodecode.ai API credit
#   # or set a provider key in the environment / Project secrets, e.g.
#   #   export ANTHROPIC_API_KEY=...
#   #   export OPENAI_API_KEY=...
# then: nodecode   (TTY)  or  nodecode serve  (headless)
set -euo pipefail

DO_SERVE=0
DO_CELLS=0
for arg in "$@"; do
  case "$arg" in
    --serve) DO_SERVE=1 ;;
    --cells) DO_CELLS=1 ;;
    -h|--help)
      sed -n '2,20p' "$0"
      exit 0
      ;;
    *)
      echo "unknown argument: $arg" >&2
      exit 2
      ;;
  esac
done

need() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "need $1" >&2
    exit 1
  }
}

need curl
need tar
need git

arch=$(uname -m)
case "$arch" in
  x86_64|amd64) ;;
  *)
    echo "nodecode needs x86_64 Linux today (got $arch)" >&2
    exit 1
    ;;
esac

# Ensure ~/.local/bin is on PATH for this shell and future logins.
export PATH="${HOME}/.local/bin:${PATH}"
if ! grep -Fqs '.local/bin' "${HOME}/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "${HOME}/.bashrc"
fi
if ! grep -Fqs '.local/bin' "${HOME}/.profile" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "${HOME}/.profile"
fi

if ! command -v nodecode >/dev/null 2>&1; then
  echo "installing nodecode…"
  # Do not export NODECODE_HOME here: install.sh treats it as the install folder.
  curl -fsSL https://nodecode.ai/install.sh | env -u NODECODE_HOME sh
else
  echo "nodecode already on PATH: $(command -v nodecode)"
fi

nodecode --version

# Prefer the background gateway when systemd user sessions exist.
if nodecode gateway status 2>/dev/null | grep -q 'unavailable'; then
  echo "note: no systemd user manager — use 'nodecode serve' for headless runs"
elif ! nodecode gateway status 2>/dev/null | grep -Eq 'serving|on,|waiting'; then
  if nodecode gateway on 2>/dev/null; then
    nodecode gateway status || true
  else
    echo "note: gateway on failed — fall back to 'nodecode serve'"
  fi
fi

if [[ "$DO_CELLS" -eq 1 ]]; then
  nodecode add nc://web --yes
  nodecode add nc://websearch --yes
  nodecode add nc://guard --yes
fi

if [[ "$DO_SERVE" -eq 1 ]]; then
  if pgrep -f '[n]odecode serve' >/dev/null 2>&1; then
    echo "nodecode serve already running"
  else
    echo "starting nodecode serve in the background…"
    nohup nodecode serve >"${HOME}/.nodecode/serve.log" 2>&1 &
    sleep 1
    echo "serve pid $!; log ${HOME}/.nodecode/serve.log"
  fi
fi

cat <<'EOF'

Next:
  1. Auth — one of:
       nodecode login
       # or export ANTHROPIC_API_KEY / OPENAI_API_KEY / GOOGLE_API_KEY
  2. Interactive shell (needs a TTY):
       nodecode
     Headless owner:
       nodecode serve
  3. On boxes.dev Template box, after it works:
       dvb-onbox snapshot
EOF
