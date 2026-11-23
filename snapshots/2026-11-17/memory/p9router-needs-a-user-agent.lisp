;;; p9router-needs-a-user-agent — define-memory recorded by session experience-s-83IFGT1L-turn-1U7M9VY-QBT6NBZXAT, 2026-11-13T14:18:37Z
(in-package :nodecode.evolved)

(define-memory p9router-needs-a-user-agent
  "The p9router tunnel (rpckldk.abc-tunnel.us) answers 403 to python/httpx's default User-Agent and 200 to a curl UA, so a missing UA looks like a dead key; osa/providers.py now sends default_headers User-Agent (C49)."
  :type :reference)
