;;; force-an-eval-failure — define-skill recorded by session experience-s-56E7OKXI-turn-1U7V4JQ-K6ESAEEJ73, 2026-11-18T07:52:54Z
(in-package :nodecode.evolved)

;; keep the trap found this turn: (eval :bogus) succeeds, so force a failure with an undefined call
(define-skill force-an-eval-failure
  "In this image a keyword form never fails, so probe an eval failure with a call to an undefined function.")
