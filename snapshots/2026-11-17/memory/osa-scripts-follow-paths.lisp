;;; osa-scripts-follow-paths — define-memory recorded by session s-GKPN8NDI, 2026-11-14T13:47:22Z
(in-package :nodecode.evolved)

(define-memory osa-scripts-follow-paths
  "Scripts under /home/boxes/osa/scripts get the data dir and password from scripts/_paths.py (OSA_DATA_DIR, then .env, then the machine fallback), never a hardcoded /home/boxes/osa-data."
  :project "/home/boxes/osa"
  :type :lesson)
