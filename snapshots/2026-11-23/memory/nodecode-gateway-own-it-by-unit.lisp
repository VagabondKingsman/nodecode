;;; nodecode-gateway-own-it-by-unit — define-skill recorded by session s-K4GS25EE, 2026-11-13T05:52:25Z
(in-package :nodecode.evolved)

(define-skill nodecode-gateway-own-it-by-unit
  "The gateway belongs to the systemd user unit, never to a nohup copy: a duplicate makes the TUI look permanently hung."
  ;; when a TUI hangs or gateway.log or the journal says "waiting: pid N owns ~/.nodecode/history.db"
  ;; on this devbox a systemd --user session DOES exist and nodecode-gateway.service is enabled, Type=notify, WatchdogSec=30s, Restart=always: a hung gateway is rebuilt in 5s by itself
  ;; a unit copy that WAITS behind a duplicate does not ping the watchdog, so it is killed at 30s and restarted (Restart=always, counter climbing) until the duplicate is gone — that loop is the real damage
  ;; keep only the unit: TERM the serving gateway, the unit takes the store in about a second; never start a second gateway beside it
  ;; find the DB and lock holders with a /proc/*/fd scan; `fuser` is not installed; a 0-byte history.db.lock is normal while serving, so do not rm it blindly
  ;; killing the gateway ends the live turn (its result never returns): run the kill sequence detached with setsid, logged to a file, and print no answer in that turn, then verify from the next turn
  ;; verify with the /proc scan, `ss -ltnp | grep 37177` and `systemctl --user is-active nodecode-gateway.service`, which needs XDG_RUNTIME_DIR=/run/user/$(id -u) or it says "Failed to connect to bus: No medium found"
)
