;;; free-key-rejects-cell-tools — define-memory recorded 2026-11-18
(in-package :nodecode.evolved)

(define-memory free-key-rejects-cell-tools
  "A nodecode-free turn answers 403 free_needs_nodecode ('A free key works only from the Nodecode CLI ... Use a paid key for other tools') as soon as the request's tools array carries any tool beyond the CLI's own: one extra function, whatever its name or schema, is enough, and the same body with that entry removed answers 200."
  :type :reference
  ;; Proved 2026-11-18 on the upstream build 0.1.16+60db5cd, free key, replaying the CLI's own
  ;; captured bodies to https://api.nodecode.ai/v1/chat/completions with the CLI's user agent:
  ;;   tools [eval] -> 200 | tools [eval, pulse] -> 403 | [eval, pulse] minus pulse -> 200
  ;;   [eval, foo(simple)] -> 403 | [eval, sh] -> 403
  ;; So the gate is the tool SET, not the body shape alone: the docs' "CLI alone" means the CLI's
  ;; own tools. On a home whose cells define tools - heartbeat's pulse, live-time's current_time,
  ;; telemetry, ports' win_port_owners, toolaria, doc-markdown, qa's report_issue - every free turn
  ;; dies on round 0, and a turn that dies on round 0 keeps no request body, so request_bodies is
  ;; empty and the body must be captured another way: point the provider at a local mock server
  ;; (base_url http://127.0.0.1:PORT/v1), run one probe, and replay the captured POST.
  ;; The false lead: bisecting cells by copying them into a temp home said nodecode-heartbeat, which
  ;; is only the first tool-bearing cell in the alphabet - all seven break it equally.
  ;; NOT the fix any more (2026-11-19: the operator dropped this patch because a nodecode-free turn failed with it, and stock upstream answered PONG-FREE; see nodecode-runs-official-upstream-no-free-lane). What this file proved stands for bodies that DO carry a tool array: the fork's free lane (commits 76c5296, 0b1a77d, 68dade6, 1e13d1d) sends no
  ;; tools array at all, folding the tool list into the prompt as text. Cherry-picked onto upstream
  ;; 60db5cd as box/free-lane in /home/boxes/nodecode-upstream they apply cleanly.
  ;; confidence: high - each status above is that replay's own answer.
  )
