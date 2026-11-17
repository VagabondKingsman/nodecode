;;; osa-tools-run-on-the-gateway — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7JUOC-72YAW5W1R, 2026-11-12T06:16:02Z
(in-package :nodecode.evolved)

(define-memory osa-tools-run-on-the-gateway
  "In this project a builtin tool runs inside the gateway process, so a path that lives on the bot's computer must be read with computer.get().read_bytes(path) — open() sees only the gateway's own filesystem."
  :type :project :project "/home/boxes/osa")
