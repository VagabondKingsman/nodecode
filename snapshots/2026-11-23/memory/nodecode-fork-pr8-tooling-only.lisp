;;; nodecode-fork-pr8-tooling-only — define-memory recorded by session s-MJ1G3NHN, 2026-11-19T04:51:25Z
(in-package :nodecode.evolved)

(define-memory nodecode-fork-pr8-tooling-only
  "Repo fork VagabondKingsman/nodecode: PR #8 (box/clean-tooling -> main) la ban sach free-lane — upstream/main 60db5cd + 9 commit tooling, khong commit free-lane nao."
  :type :project
  ;; why: 2026-11-19 the operator asked to drop every free-lane install from the fork and land a PR that keeps the fork equal to what the box runs now.
  ;; what PR #8 carries (cherry-picked onto upstream/main, -x): 5c743bf boxes.dev bootstrap; a3b10f7 tui deferred post; f0b4398 lib/dial SO_ERROR by lookup; 1167f7f keep-awake+resume-heal; 31ebb5f watchdog 30s units; f8c3b10 watchdog under systemd; 0dd9b08 short-sleep-no-restart; baa1f03 wake never kills; and the term %defer docstring quote fix. 17 files, +681/-2, MERGEABLE.
  ;; deliberately NOT carried: 76c5296 (the free-lane provider itself) and the three follow-ups 0b1a77d 68dade6 1e13d1d plus test/engine/free-lane-test.lisp — `gh pr diff 8 | grep -c free-lane` is 0.
  ;; cleaned up on the way: PR nodecode-ai/nodecode#520 (the free-lane patch to upstream) CLOSED with the reason; fork PR #7 (box/short-sleep) CLOSED as superseded; remote branches box/free-lane, box/free-lane-tests, box/short-sleep deleted; local box/free-lane-tests, box/short-sleep, box/unified deleted. `main` still equals upstream/main (60db5cd), untouched.
  ;; verify: cd /home/boxes/nodecode && just lint (328 files, 0 failed) and just release (./nodecode answers 0.1.16+535ccc6). The box still RUNS the official install, not this build: ~/.local/share/nodecode/current -> 60db5cd91.
  )
