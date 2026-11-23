;;; osa-connect-ceiling — define-memory recorded by session s-GKPN8NDI, 2026-11-14T15:55:07Z
(in-package :nodecode.evolved)

(define-memory osa-connect-ceiling "In /home/boxes/osa a hung dial must fail in seconds: limits.provider_connect_s (15) is its own ceiling via httpx.Timeout(connect=...), and openai.APIConnectionError retries with backoff like a 5xx." :type :project :project "/home/boxes/osa"
;; provider_head_s (120) covers only "connected, no headers"; before this a stalled tunnel cost 120 s per attempt (task 1632, twice on 14/11).
)
