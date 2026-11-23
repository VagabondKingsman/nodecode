;;; keep-the-chrome-profile-for-osa-work — define-memory recorded by session experience-s-MJ1G3NHN-turn-1U7WSXC-3ZE5EYS7BM, 2026-11-19T05:39:42Z
(in-package :nodecode.evolved)

(define-memory keep-the-chrome-profile-for-osa-work
  "Giu ~/.nodecode/chrome-profile tren box nay: no phuc vu viec update & build fix du an bot OSA, khong phai rac cua nodecode."
  :type :feedback
  ;; why: the operator said so in as many words on 2026-11-19 — "giữ chrome profile vì còn làm việc update & build fix dự án bot osa" — right after the audit listed it as 262 MB under ~/.nodecode.
  ;; what it is: a Chrome user-data-dir used by a headless Chrome on --remote-debugging-port=9222 (started 2026-11-16, still running), which the OSA UI checks drive over CDP; unrelated to the nodecode-chrome cell, which drives the operator's real Chrome through the extension on 127.0.0.1:17318.
  ;; so: never propose deleting it as part of a nodecode cleanup, and never count it as nodecode's own state when measuring a home's size.
  )
