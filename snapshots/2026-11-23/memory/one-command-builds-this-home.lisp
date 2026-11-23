;;; one-command-builds-this-home — define-memory recorded by session s-YXFQ3K5L, 2026-11-23T17:14:32Z
(in-package :nodecode.evolved)

(define-memory one-command-builds-this-home
  "A fresh machine becomes this home with one idempotent command from the fork checkout — bash tools/boxes/bootstrap-from-fork.sh (add --dry-run to see the plan, --check to verify an existing home, --build to compile the checkout instead of taking the release) — which installs, writes config from the snapshot, copies the memory, adds the 13 hub cells, installs the free-account pool and turns the gateway on, then names the four secrets it cannot hold."
  :type :project
  :project "/home/boxes/nodecode")
