;;; prune-osa-prompt-dumps — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7O02J-VS83NQWWRH, 2026-11-14T11:54:12Z
(in-package :nodecode.evolved)

;; keep the pruning procedure: the dump folder has no ceiling of its own
(define-skill prune-osa-prompt-dumps
  "Cap an OSA prompt-dump folder when it has grown unbounded: keep the newest N and delete the rest by mtime, inside the live data dir."
  ;; when to use: an OSA box's <OSA_DATA_DIR>/prompts holds thousands of per-request dumps and hundreds of MB, while osa-data/prompt-dump still carries its N-seconds value so the folder refills.
  ;; 1. size + count first: du -sm <dir> and ls <dir> | wc -l, so the delta can be reported.
  ;; 2. delete the oldest only: ls -t <dir> | tail -n +<N+1> | while read -r f; do rm -f "<dir>/$f"; done — N ~500 keeps a recent window for debugging.
  ;; 3. never delete the folder or the prompt-dump marker, and check the dir is under OSA_DATA_DIR, not the repo.
  ;; evidence: 2026-11-14 the live folder had 2381 files / 300MB; the same three lines took it to 500 files / 76MB and the service kept running.
  ;; confidence: high — plain mtime pruning, nothing else touched.
  )
