;;; prove-model-rotate — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7KVCR-86WIJGZKZX, 2026-11-12T18:58:55Z
(in-package :nodecode.evolved)

(define-skill prove-model-rotate #>END
Prove a provider/model switch inside a live session cost no context.
;; when a live session's model or provider is about to change and someone needs it shown, not assumed, that the session rides through
;; read the session's message count and pin, and the current general.default_model
;; select-model to the new target, then read pin and count again
;; select-model back, read pin and count again, and read general.default_model to confirm it returned
;; report the counts across all three reads plus the restored default; a count that moved is the finding
;; evidence - 2026-11-12 the rotate experientiallabs -> nodecode/nodecode-cyber-v1 -> experientiallabs held msgs=3646 at every read and default read back at deepseek-v4.1-flash-uncensored/high, while select-model's receipt alone proved nothing; confidence high
;; note - select-model rewrites the new-session default too, so restoring it is part of the check
END)
