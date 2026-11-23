;;; read-a-sessions-live-model — define-skill recorded by session experience-s-LRZO1F6H-turn-1U7UZ1M-806UH8JWDD, 2026-11-18T05:54:08Z
(in-package :nodecode.evolved)

;; keep the procedure for answering which model a session is really on
(define-skill read-a-sessions-live-model
  "A Nodecode session's real provider and model are the newest row of ~/.nodecode/history.db's model_history - read it as `select provider,model,session_id from model_history order by log_position desc limit 3` (the table is WITHOUT ROWID, so rowid ordering errors) - not general.default_model in config.jsonc, whose lane may differ from the one actually serving (e.g. default nodecode-free while the live turns run on nodecode).")
