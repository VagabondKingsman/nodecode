;;; hub-cell-fixes-are-plain-files — define-memory recorded by session experience-s-YXFQ3K5L-turn-1U848JG-5KQJ8H47LW, 2026-11-23T06:06:31Z
(in-package :nodecode.evolved)

;; keep the general lesson: an installed cell is plain files, not a repo - restart-proof, re-pin-fragile
(define-memory hub-cell-fixes-are-plain-files
    "A cell installed with `nodecode add` lands as plain files in cells/<name>/ with no git history, so a local fix survives every restart but a re-pin or re-add silently restores the hub's text."
  :type :lesson
  ;; Seen here: cells/nodecode-rea/transport.lisp was patched and `git status` said
  ;; "fatal: not a git repository"; (reload-cell) made the fix live, and (restart-cells) kept it.
  ;; So after patching a cell, write down the patch (memory or skill) or send it upstream:
  ;; the folder is the only record, and the next `nodecode add` starts from the hub again.
  :sources ("session" "this box")
  :origin "world")
