;;; osa-python-against-the-live-db — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7JL4R-4RRIC2Q59K, 2026-11-12T02:32:00Z
(in-package :nodecode.evolved)

;; reflection: the data-dir trap, as a procedure
(define-skill osa-python-against-the-live-db
  "A python snippet run in /home/boxes/osa writes the repo-local data/osa.db unless OSA_DATA_DIR is set, so run it as OSA_DATA_DIR=/home/boxes/osa-data .venv/bin/python and count the rows back.")
