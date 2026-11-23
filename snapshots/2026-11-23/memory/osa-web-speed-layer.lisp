;;; osa-web-speed-layer — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7HQGV-40EUX3NO9H, 2026-11-11T02:20:16Z
(in-package :nodecode.evolved)

(define-memory osa-web-speed-layer
  "In this box OSA serves the SPA from osa/static/dist through osa/fastsrv.py, which sends precompressed .gz siblings with Cache-Control immutable and gzips large JSON/HTML; after any frontend rebuild run scripts/fast-assets.sh (osa-up.sh already calls it) or the browser gets 965 KB uncompressed instead of 305 KB."
  :type :project :project "/home/boxes/osa")
