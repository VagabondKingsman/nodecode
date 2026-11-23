;;; bisect-a-refused-provider-request-with-its-own-body — define-skill recorded by session experience-s-NNQ8PVPU-turn-1U7UXVS-AEJU21BVKN, 2026-11-18T05:35:58Z
(in-package :nodecode.evolved)

;; keep: the reusable procedure this turn worked out (replay the CLI's own body, then toggle one field)
(define-skill bisect-a-refused-provider-request-with-its-own-body
  "When a provider refuses a request with a policy-ish 400/403 while the same key still answers trivial calls, replay the exact body the CLI sent and toggle one field at a time until the status flips."
  ;; when: a turn fails with a provider status whose message says the caller looks like another
  ;; client or lacks a permission (403 free_needs_nodecode, "only from the CLI", "denied access"),
  ;; while /v1/models, /v1/usage or a one-line chat on the SAME key answers 200 — so key, host,
  ;; build and network are already out as suspects and only the request shape is left
  ;; 1. read the failure fact, not the log prose: select occurred_at,kind,payload from events
  ;;    where kind='turn.failed' order by log_position desc — it carries provider, model,
  ;;    status, response-body and request-sha256
  ;; 2. take the body the CLI really sent: sqlite -readonly ~/.nodecode/history.db
  ;;    "select id,session_id,turn_id,round,size,base,bytes from request_bodies order by id desc";
  ;;    a turn that died on its first round kept nothing, so use the nearest turn of the same
  ;;    session; (kept-request-body SESSION TURN ROUND) rebuilds the octets, nlk:body-text reads them
  ;; 3. replay it verbatim with nlk:http :post to the same URL and the same UA/auth: the same
  ;;    status proves the BODY is what the gate reads, not the environment
  ;; 4. bisect by deletion, not by reading server code: build a minimal body and add one
  ;;    top-level key at a time (tools, tool_choice, stream, prompt_cache_key); the single field
  ;;    whose presence flips 200<->403 is the tell
  ;; 5. cross the other axis to close it: the same body on a second key or provider; a 200 there
  ;;    rules the account in and the body in, and the pair is the finding
  ;; evidence: 2026-11-18, build 0.1.16+baa1f03 — "CLI's own tools + free key -> 403" against
  ;; "paid key + tools -> 200", with tools:null and tool-less+prompt_cache_key both 200; before the
  ;; bisect the 403 read as a broken key, and delta bodies had already been wrongly suspected
  ;; (the endpoint answers them 400 invalid_json, not 403)
  ;; confidence: high — three independent axes (stored real body, one field toggled, second key) agreed
  )
