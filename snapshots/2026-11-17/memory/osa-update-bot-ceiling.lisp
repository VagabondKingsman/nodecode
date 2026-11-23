;;; osa-update-bot-ceiling — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7K7EW-NNPZ4MWDYH, 2026-11-12T11:09:25Z
(in-package :nodecode.evolved)

;; the ceiling change, as a fact of this project
(define-memory osa-update-bot-ceiling
  "In /home/boxes/osa a bot's instructions may now be up to 8000 characters (bots.MAX_INSTRUCTIONS, shared by bots.save and botadmin._instructions); the old 4000 was overflowed by a role plus an appended mode block."
  :type :project
  :project "/home/boxes/osa")
