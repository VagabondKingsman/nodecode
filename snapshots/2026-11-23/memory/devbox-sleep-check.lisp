;;; devbox-sleep-check — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7TDNM-QSGRAGUCXH, 2026-11-17T09:24:02Z
(in-package :nodecode.evolved)

(define-skill devbox-sleep-check
  "Read whether this box has been sleeping and what the watchdog did about it, without disturbing a running turn."
  ;; when (box boxes.dev, a turn died mid-way, suspic* that the host slept, or asked whether the box stays awake)
  ;; (tail -20 ~/.nodecode/box-watchdog/log) — a line "máy vừa ngủ Ns" is a real sleep; no line since start means it has not slept
  ;; (tail -3 ~/.nodecode/box-keepawake/log) — a "đã giữ box" means a hold is set; repeated service_unavailable means the boxes.dev keep-awake API is down, so nothing prevents the next sleep
  ;; (dvb-onbox devboxes keep-awake get) with BOXES_CLIENT_THREAD_ID=$(cat ~/.nodecode/box-keepawake/thread-id) — the id is required, the daemon rejects the call without it
  ;; (systemctl --user list-timers box-watchdog.timer) — a unit that stopped firing is why a sleep went unhealed
  ;; do not restart osa or the gateway yourself just because a sleep happened: the watchdog already decided, and a restart kills the running turn
  ;; evidence — 17/11: log showed 398 s, 197 s, 100 s sleeps ~10 min apart while the API returned service_unavailable; the watchdog healed each one, and the old always-restart rule cut two live turns before the short-sleep branch was added
  ;; confidence — high for reading; medium for the "do not restart" line, which rests on that same morning
)
