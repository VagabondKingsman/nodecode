;;; nodecode-rea-and-team-cells — define-memory recorded by session s-YXFQ3K5L, 2026-11-23T06:05:45Z
(in-package :nodecode.evolved)

;; deepen both keepers: the first pair recorded names without the steps that mattered
(define-memory nodecode-rea-and-team-cells
    "REA (207-tool MCP reverse-engineering) and team (parallel full-tool sessions) are installed and proven on this home; REA needed config rea.server plus one transport fix, and the fix lives in the cell's own folder."
  :type :project
  ;; HOME /home/boxes/.nodecode, build 0.1.16+c78fef6. Installed 2026-11-23 with
  ;; (sh "nodecode add nc://rea --yes --wait 300") from hub pin 69b91fd; team was already on.
  ;; Two gaps the add did NOT close, both needed before (rea:tools) answers:
  ;;  1. config: (config-set '("rea" "server") "rea-agents@6.7.0") and
  ;;     (config-set '("rea" "pwntools-python") "/home/boxes/.local/venvs/rea/bin/python").
  ;;  2. cells/nodecode-rea/transport.lisp merged-environment passed each "NAME=VALUE"
  ;;     environment string to (car pair) and signalled "not of type LIST"; the fix is
  ;;     (uiop:string-prefix-p pair entry) over the string, then (reload-cell "nodecode-rea").
  ;;     A hub re-pin restores the bug: reapply it, then (reload-cell "nodecode-rea").
  ;; Real launch is `npx -y rea-agents@6.7.0 mcp` and needs Node 22.19+/24.11+/26+ on PATH;
  ;; (rea:status) then (rea:tools) = 207 tools is the proof, and it survives (restart-cells "nodecode-rea").
  ;; team is proved by one unscored (team:open "..." :dir ...) with 3 nodes: LOG and work-K fill
  ;; within ~2 min and (team:best ...) reports "not solved; the files are the product".
  ;; Smoke dirs go under the home, never the operator's folder; (team:stop DIR) then rm -rf.
  :sources ("session" "this box")
  :origin "world")
