;;; nodecode-free-lane-is-one-prompt — define-memory recorded by session s-NNQ8PVPU, 2026-11-18T05:51:06Z
(in-package :nodecode.evolved)

(define-memory nodecode-free-lane-is-one-prompt
  "api.nodecode.ai answers a nodecode-free key only for one prompt: a chat body of at most one system message and exactly one user message, no assistant message and no tools array; anything else is 403 free_needs_nodecode, and the WebSocket is refused to a free key outright (websocket_paid_only), so nodecode's chat lane folds the turn into one prompt and passes tools as text."
  :type :reference
  ;; Probed 2026-11-18 against https://api.nodecode.ai/v1/chat/completions on build 0.1.16+baa1f03,
  ;; one free key, its own UA:
  ;;   {system,user} 200 | {user} 200 | {system(4k),user} 200
  ;;   {user,user} 403 | {user,assistant} 403 | {system,user,assistant} 403 | {system,user,system} 403
  ;;   any body with "tools" (even one bare function) 403 | {"tools":null} 200
  ;; CORRECTED 2026-11-18 on 0.1.16+60db5cd: a tools array holding the CLI's own tool
  ;; (["eval"]) answers 200; any EXTRA function - {"name":"foo"} with a plain schema, or
  ;; ["sh"], or a cell's pulse - answers 403. The gate is the tool set, not the tools key;
  ;; see free-key-rejects-cell-tools.
  ;;   /v1/responses with one turn 403 (the free lane is chat-completions only)
  ;;   WS upgrade wss://api.nodecode.ai/v1/ws with a free key 403 {"code":"websocket_paid_only",
  ;;     "message":"The WebSocket API takes paid keys; a free key uses HTTP with SSE."}
  ;;   same tools body on the paid key 200
;;   /v1/models and /v1/usage on the same free key answer 200 - the 403 is about the body's
;;   shape, never about the key, the network or the config.
  ;; So "A free key works only from the Nodecode CLI" means: single-prompt bodies only. The first
  ;; rounds of any agent turn carry tools and history, hence the 403 on every real turn.
  ;; The fix in /home/boxes/nodecode (commit 76c5296): free-lane-request-body flattens the
  ;; conversation into one user message and writes the tool schemas plus a ```tool protocol into the
  ;; system prompt; free-lane-answer turns the model's fenced block back into tool_calls. Verified
  ;; live: eval ran on the free lane, the result came back, turn.completed, cache read on round 2.
  ;; Test it: (let ((k (getf (resolve-provider-credential "nodecode-free") :key))) ...) with a body
  ;; holding system+user only; add "tools" and it 403s.
  )
