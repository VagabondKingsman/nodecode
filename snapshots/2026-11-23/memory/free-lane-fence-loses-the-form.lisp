;;; free-lane-fence-loses-the-form — define-memory recorded by session experience-s-2FELXWKM-turn-1U7UZRJ-5M46UDWQ0E, 2026-11-18T06:18:30Z
(in-package :nodecode.evolved)

(define-memory free-lane-fence-loses-the-form
  "A tool call can arrive with empty arguments on either lane: on nodecode-free, free-lane-split-tool-text yields \"{}\" whenever the fenced object has no top-level \"arguments\" or an empty one, and on the paid nodecode lane the model itself sometimes emits arguments \"{}\"; both draw missing_required_argument {tool: eval, expected: [\"form\"], received: []} from preflight, and unless the raw call is quoted back the turn re-sends the same empty block."
  :type :reference :cell "nodecode")
