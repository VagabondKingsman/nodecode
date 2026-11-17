;;; osa-role-overrides-win — define-skill recorded by session s-1CKKCZWG, 2026-11-12T00:31:56Z
(in-package :nodecode.evolved)

;; a trap worth keeping: the UI's saved overrides beat config.yaml, so editing the file alone changes nothing
(define-skill osa-role-overrides-win
  "In /home/boxes/osa a role's model and flags come from the DB row settings key='overrides' (what the UI saved), applied over config.yaml by osa/settings.apply(); editing config.yaml alone changes nothing while an override exists, and GET /api/settings shows the effective values.")
