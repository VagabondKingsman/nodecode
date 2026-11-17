;;; osa-data-dir-resolution — define-memory recorded by session s-GKPN8NDI, 2026-11-14T13:24:47Z
(in-package :nodecode.evolved)

;; keep the resolution rule so a future me does not re-open it
(define-memory osa-data-dir-resolution
  "In /home/boxes/osa the data dir resolves OSA_DATA_DIR → repo .env → repo data/, and only the last rung warns; keep new writers on that one source."
  :type :lesson
  ;; why: 2026-11-14 three separate writers each invented their own fallback (config, relay, worker_cache) and a bot read a stale second DB; OSA-041 (PR #96) put them all on config.py's ladder and capped prompt dumping (OSA_PROMPT_DUMP_MAX_MB 4, OSA_PROMPT_DUMP_KEEP 500) so a dump left on cannot fill the disk.
  ;; rule: a new module that writes data uses config.DATA or osa-data via OSA_DATA_DIR, never Path(__file__).parent.parent/"data"; tests pass OSA_DOTENV=0 or a temp .env; backups go to osa-backups/ (OSA_BACKUP_DIR), never inside the data dir.
  )
