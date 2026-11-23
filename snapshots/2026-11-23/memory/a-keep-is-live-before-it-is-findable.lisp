;;; a-keep-is-live-before-it-is-findable — define-memory recorded by session experience-s-YXFQ3K5L-turn-1U84B52-OG1X6ZW3H3, 2026-11-23T06:54:59Z
(in-package :nodecode.evolved)

;; keep it without in-package, which the reflection refuses
(nodecode.evolved:define-memory a-keep-is-live-before-it-is-findable
  "A definition kept mid-turn lives in the image at once, yet the index a session is pinned with, and so (help 'name) and experience:sight, may not name it until the session repins."
  :type :project
  :project "/home/boxes/nodecode"
  ;; 2026-11-23, the same morning: define-memory answered "[memory: kept
  ;; snapshot-the-install-to-a-fork]" and the file was there (2407 bytes at
  ;; ~/.nodecode/cells/cursor-agent-memory/snapshot-the-install-to-a-fork.lisp), while the
  ;; pinned index never showed it. Then operate-the-kernel-not-the-cli was kept and
  ;; (index "operate-the-kernel") answered "nothing kept mentions it", (help '…)
  ;; answered "no help for OPERATE-THE-KERNEL-NOT-THE-CLI", and experience:sight
  ;; refused the name as "no definition named … in the index" - so a reflection cannot
  ;; sight a definition born in the turn it reflects on.
  ;; What to do instead: read the file back where a shell is allowed (the keep names its
  ;; cell, <cells>/cursor-agent-memory/NAME.lisp), and treat "in the index only next
  ;; session" as normal rather than as a failed write.
  )
