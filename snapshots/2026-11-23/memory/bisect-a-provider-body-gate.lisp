;;; bisect-a-provider-body-gate — define-skill recorded by session experience-s-NNQ8PVPU-turn-1U7UYBM-FMJVOY9SA8, 2026-11-18T05:57:36Z
(in-package :nodecode.evolved)

(define-skill bisect-a-provider-body-gate
 "Find which part of a request a provider's gate objects to, then reshape the client's body to the shape that lane accepts."
 ;; when-to-use: an agent-shaped request comes back 4xx with words that blame the client (only from the CLI, paid keys only, use a paid key for tools) while a one-line chat on the same key answers 200 - the gate is about the body's shape, not the key, network or config.
 ;; 1. Send exactly what the real client sends (same UA, same auth) and first find the smallest body that answers 200: one user message, max_tokens, prompt_cache_key.
 ;; 2. Add ONE dimension per call and record the status: a second user message, an assistant message, a system message, system+assistant, tools with one bare function, tools null, streaming, a websocket upgrade.
 ;; 3. The crossing point is the rule; write it as a memory before touching code, so the next session does not re-bisect.
 ;; 4. Reshape the client to the accepted shape instead of arguing with the server: fold the transcript into one user message, write the tool schemas and a fenced-call protocol into the system prompt, and parse the model's fenced block back into tool_calls.
 ;; 5. Prove it twice - once in the live image by a turn that runs a tool, once in the BUILT image by an ephemeral rpc turn, reading turn.tool_result and turn.completed out of the event log.
 ;; evidence (2026-11-18, /home/boxes/nodecode): every free-lane turn died on round 0 with 403 free_needs_nodecode; shape-by-shape probing found the lane takes at most one system plus exactly one user message and no tools array, and after flattening, eval ran on the free lane and the built image completed a turn on it (commit 76c5296).
 ;; confidence: medium - one provider, but each dimension moved alone and the rebuilt lane was proved end to end in both images.
 )
