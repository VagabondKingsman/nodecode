;;; nodecode-reasoner-empty-message — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7KUQA-SXFQL0VNVV, 2026-11-12T18:46:58Z
(in-package :nodecode.evolved)

(define-skill nodecode-reasoner-empty-message "A small max-tokens on a reasoning model comes back as an empty assistant message, not as content."
  ;; when a provider call on a reasoning-capable model errors 'provider returned an empty assistant message' or returns NIL
  ;; raise max-tokens to about 600 (reasoning tokens are spent before any content) and retry before blaming the key or the provider
  ;; evidence: nodecode-cyber-v1 at max-tokens 20 and 30 returned 'provider request failed: provider returned an empty assistant message'; the same call at 600 answered 'Use systemd with `Restart=always`'
  ;; confidence: high - reproduced twice and cured by budget alone
  )
