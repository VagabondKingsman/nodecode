#!/usr/bin/env bash
# Paste the body (or call this file) into boxes.dev:
#   Project settings → Devbox lifecycle → Startup script
#
# Keeps ~/.local/bin on PATH and refreshes the release binary when missing.
# Keep this under the boxes.dev startup timeout (default 60s; max 120s).
set -euo pipefail

export PATH="${HOME}/.local/bin:${PATH}"

if ! command -v nodecode >/dev/null 2>&1; then
  curl -fsSL https://nodecode.ai/install.sh | env -u NODECODE_HOME sh
fi

# Optional: ensure headless organism is up on every awake box.
# Uncomment if you want bots/cron/link without an interactive shell.
# if ! pgrep -f '[n]odecode serve' >/dev/null 2>&1; then
#   nohup nodecode serve >"${HOME}/.nodecode/serve.log" 2>&1 &
# fi
