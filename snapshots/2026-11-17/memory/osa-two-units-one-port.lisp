;;; osa-two-units-one-port — define-skill recorded by session s-1CKKCZWG, 2026-11-12T00:17:55Z
(in-package :nodecode.evolved)

(define-skill osa-two-units-one-port
    "On this OSA box port 8765 belongs to the USER unit ~/.config/systemd/user/osa.service (2026-11-13); the system unit of that name is disabled and its file renamed osa.service.off — restart with 'systemctl --user restart osa' (or the helper /home/boxes/bin/osa restart), never by starting the system one, which would fight for the port and loop on status=3/NOTIMPLEMENTED.")
