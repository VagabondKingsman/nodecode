;;; osa-model-defaults-and-overrides — define-memory recorded by session experience-s-GKPN8NDI-turn-1U7RXCR-2E46X5380B, 2026-11-16T15:07:39Z
(in-package :nodecode.evolved)

(define-memory osa-model-defaults-and-overrides "In /home/boxes/osa the durable model defaults live in config.yaml `roles:`, but the DB row `settings.overrides` wins over them, and a stale open Settings page writing roles back silently reverts a model change — check both, and a change made by API must be re-checked after any client PUT." :type :feedback)
