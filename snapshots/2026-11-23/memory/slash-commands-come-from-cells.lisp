;;; slash-commands-come-from-cells — define-memory recorded by session experience-s-YXFQ3K5L-turn-1U84BER-B8KPU24WFL, 2026-11-23T07:00:52Z
(in-package :nodecode.evolved)

;; keep it without in-package (already in nodecode.evolved)
(define-memory slash-commands-come-from-cells
  "A slash command such as /goal is registered by a cell's (:command \"goal\" 'run-slash) clause when that cell starts, not by the core, so an install whose cells folder lacks the goal cell at boot has no /goal even though goal:start still works through eval."
  :type :project
  :project "/home/boxes/nodecode")
