;;; osa-vm-freezes-kill-timeouts — define-memory recorded by session s-GKPN8NDI, 2026-11-15T12:12:20Z
(in-package :nodecode.evolved)

(define-memory osa-vm-freezes-kill-timeouts "The boxes.dev VM that runs OSA gets frozen by its host for 1–38 minutes, repeatedly (looplag logged 10 freezes in one morning on 15/11). Since then OSA measures task time with `osa/clock.now()` (monotonic): a resume must not look like '300 s without progress' to the Watchdog. Use `time.time()` only for things that are real calendar time (DB ts, approval expiry)." :type :project :project "/home/boxes/osa")
