;;; audit-what-updates-this-nodecode-box — define-skill recorded by session experience-s-MJ1G3NHN-turn-1U7WRIB-K14U9RJN8G, 2026-11-19T05:07:55Z
(in-package :nodecode.evolved)

(define-skill audit-what-updates-this-nodecode-box
  "Answer what auto-updates this Nodecode home and whether it was on, from the unit, the script and the script's own log rather than from memory."
  ;; when to use: asked whether this box updates itself from upstream, what an auto-update did or when, or asked to explain why an install did not stick.
  ;; 1. the unit: systemctl --user cat nodecode-advance.timer and .service; the timer's OnUnitActiveSec is the cadence (5min here), ExecStart names the script.
  ;; 2. the script: read ~/.local/bin/nodecode-advance.sh end to end. Its steps are fetch upstream+origin, merge upstream/main into the CHECKED-OUT branch, `just release` at the machine, install to ~/.local/share/nodecode/<hash>, repoint `current`, then restart the gateway at most once per build.
  ;; 3. the gate on restart: it reads history.db open_turns and treats a turn silent past STALE_S (900) as dead; a failed read counts as busy. So it can cut a live turn.
  ;; 4. the durable record: ~/.nodecode/self-update/log, lines that start with a timestamp and say dựng/cài/restart/đang chạy; ~/.nodecode/self-update/{built,served} hold the commit it built and the build it knows is serving.
  ;; 5. the journal is short-lived: journalctl --user -u nodecode-advance.service may hold only today; only the log spans weeks. Count `grep -cE '^2026-'` for how many things it did.
  ;; 6. enabled state now: systemctl --user is-enabled / is-active; the timer's own file dates under ~/.config/systemd/user bound when it was installed.
  ;; evidence: 2026-11-19 the operator asked what the auto-update does and whether it had been on; the unit (created 11-18 06:27/06:34) plus 37 timestamped log lines from 2026-11-18T06:27:44Z to 2026-11-19T04:13:44Z, nine installed builds, and five journal Starting lines (04:13 04:18 04:23 04:28 04:33) proved it had been on and had overwritten an official install at 04:13:44; `systemctl --user is-enabled` then read `disabled`, after the stop at 04:34:20.
  ;; confidence: high — every claim above came from a file read this turn, not from recollection.
  )
