;;; box-sleep-watchdog — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7TBIN-MARHWH286R, 2026-11-17T08:42:37Z
(in-package :nodecode.evolved)

(define-skill box-sleep-watchdog "Keep a cloud devbox that sleeps when unwatched awake, and bring its processes back when it sleeps anyway."
  ;; when: a hosted VM/devbox suspends itself when no terminal is watched, and long tasks or services must survive; the platform offers a "keep awake" hold API but no systemd suspend hook exists in the user instance
  ;; find the platform's hold verb first (dvb-onbox devboxes keep-awake set --for 30m): it needs an identity env the agent runtime does not set, so keep one fixed id in a state file and export it
  ;; renew from a short timer, but give the hold call its own backoff (60 s doubling to 10 min) so a broken API is not hammered every tick
  ;; detect a sleep by subtracting the monotonic delta from the wall delta since the previous tick: more than ~60 s of slack is a sleep (wall clock only, no hook)
  ;; on detection restart the services that hold network state, not only ones that look dead - a sleep breaks provider and client sockets and leaves a process half-broken
  ;; keep a separate health check that needs 2 consecutive failures, so one slow answer does not thrash
  ;; run it from a systemd user oneshot + timer with Persistent=true so a missed tick fires after wake; give the unit an explicit Environment=PATH (the tool lives outside the default PATH) and start the script with a shebang or systemd reports Exec format error
  ;; set StartLimitIntervalSec=0 plus Restart=always on the kept units and confirm Linger=yes, so neither systemd nor a logout can end them
  ;; test the logic without the network by stubbing the platform CLI, curl and systemctl on PATH, driving three cases: sleep detected, service unhealthy, all healthy
  ;; confidence: high - one planted 400 s gap produced the detection line and had both services back within seconds, and the three stub cases passed; the hold itself stayed unproven because the platform API answered service_unavailable throughout
  )
