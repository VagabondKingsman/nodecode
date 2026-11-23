;;; osa-ctx-simple-kwargs — define-skill recorded by session s-1CKKCZWG, 2026-11-12T04:24:50Z
(in-package :nodecode.evolved)

(define-skill osa-ctx-simple-kwargs
    "In /home/boxes/osa a ctx.simple tool is called as fn(**args), so its handler must name the schema's keys as keyword parameters; a lambda taking one positional Call fails only when a bot really invokes it (TypeError: missing 1 required positional argument).")
