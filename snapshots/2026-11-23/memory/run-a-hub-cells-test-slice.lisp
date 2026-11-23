;;; run-a-hub-cells-test-slice — define-skill recorded by session experience-s-YXFQ3K5L-turn-1U849AV-SYX5C1V0O9, 2026-11-23T06:18:00Z
(in-package :nodecode.evolved)

;; reflection: canonise the scratch-sbcl test-slice procedure as a skill
(define-skill run-a-hub-cells-test-slice
  "Run a hub-installed Nodecode cell's own test slice in a scratch sbcl, with the cell's own asdf directory on the registry."
  ;; when: a cell arrived from the hub into ~/.nodecode/cells (hub repo, no justfile target) and its slice must be proven green, distinct from the live image's own suite
  ;; 1. cd to the nodecode checkout (in this folder: /home/boxes/nodecode) and use its sbcl flags plus the justfile's cell_registry eval; do not use the live image
  ;; 2. also push #p"/home/boxes/.nodecode/cells/nodecode-<name>/" into asdf:*central-registry* — ~/.nodecode is outside the repo's cells/**/*.asd, and without it asdf says 'Component :nodecode-<name>/test not found'
  ;; 3. (asdf:load-system :nodecode-<name>/test), then (funcall (uiop:find-symbol* :run-<name>-tests :nodecode.test))
  ;; 4. never asdf:test-system inside the live image: it pulls nodecode/test in and dies with 'Lock on package NODECODE.KERNEL violated' in store/events-test.lisp
  ;; evidence: 2026-11-23, pstack — after the load-system/run-<name>-tests route failed in-image, the scratch sbcl with the extra registry entry printed '17 pstack tests, 0 failed'
  ;; confidence: high on the route (it ran), medium on generality (one cell, one checkout)
  )
