;;; prompt-cache-extends-a-body — define-memory recorded by session s-1CKKCZWG, 2026-11-11T09:49:49Z
(in-package :nodecode.evolved)

;; keep the lesson: provider caches extend a whole body, and how to prove it
(define-memory prompt-cache-extends-a-body
  "Model-service prompt caching rewards a request that EXTENDS a whole body already sent, not merely one that shares a prefix — measured against xAI (scripts/cache_probe.py in /home/boxes/osa): 7584 prompt tokens, edit one word in the first user message -> 1152 cached; edit the last message's tail -> 7552 cached. So anything that varies per turn must sit at the very end (state, recall index), and whatever was sent must be stored and re-sent verbatim: the state on its user message (memory.remember_state), a turn's assistant tool_calls plus tool results (memory.keep_tail). Verify with the dump: put a path in $OSA_DATA_DIR/prompt-dump (or OSA_PROMPT_DUMP), send two turns, and diff the bodies — a chained body makes the provider report 96-100% cached; a first call that reports 5-8% means the body diverged somewhere before its last message.")
