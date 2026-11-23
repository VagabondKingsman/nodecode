;;; subagents-cell-installed — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7IOYC-CYT9SCWC11, 2026-11-11T14:45:45Z
(in-package :nodecode.evolved)

;; keep the durable fact: what this home now has, and how to drive it
(define-memory subagents-cell-installed
  "In /home/boxes/nodecode the nc://subagents cell is installed (hub, revision 0cba063) and gives Lisp APIs for parallel detached sessions plus a durable IRC-style board, not provider tools."
  :type :project
  :project "/home/boxes/nodecode"
  ;; (subagents:task '((:name "w1" :task "...") (:name "w2" :task "...")) :await t :timeout-seconds 180)
  ;; starts 1..max_agents sessions and returns a team id and a board channel #agents-…; (subagents:agents "list"|"wait"|"stop"),
  ;; (subagents:irc "join"|"send"|"inbox"|"history"|"wait"|"roster"). Workers inherit this session's model, not its
  ;; conversation; workspaces are shared directories, not worktrees.
  ;; Verified 2026-11-11: (subagents:agents "list") answers "no current subagents team; create one with the task tool"
  ;; before any team exists — that is the design, not a broken install; a one-word task ran 14 s and posted "done" to
  ;; the board. `nodecode doctor` does not exist in build 98dd6dc80; prove a cell by its manual, its fboundp, and the
  ;; {"name":"nodecode-<cell>","kind":"cell","origin":"hub"} row in ~/.nodecode/generations/<n>.json.
  )
