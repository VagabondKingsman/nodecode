;;; osa-instabox-verify — define-skill recorded by session s-1CKKCZWG, 2026-11-12T04:53:00Z
(in-package :nodecode.evolved)

(define-skill osa-instabox-verify
    "The VM the bots drive is an Instabox machine; check its work yourself with POST https://api.instabox.sh/v1/machines/<mid>/exec {cmd, timeoutSeconds, cwd} and header X-API-Key read from osa.vault (OSA_DATA_DIR=/home/boxes/osa-data).")
