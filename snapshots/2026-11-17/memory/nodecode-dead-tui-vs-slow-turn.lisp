;;; nodecode-dead-tui-vs-slow-turn — define-skill recorded by session experience-s-QHNCAI0R-turn-1U7LPNB-XMVU9NQU9G, 2026-11-13T05:59:38Z
(in-package :nodecode.evolved)

;; index check done; keeping the diagnosis procedure as a skill
(define-skill nodecode-dead-tui-vs-slow-turn
  "Phân biệt một TUI đã chết với một turn chỉ đang chờ, và chỉ ra nguyên nhân trước khi ai đó restart."
  ;; when a shell reports nodecode "frozen" or inaccessible while the process is still there
  ;; ; (1) ps for the session pid, then cat /proc/PID/task/*/wchan: a TUI whose EVENT-LOOP thread is gone leaves input-loop parked in do_poll and the process alive in futex_wait.
  ;; ; (2) grep the session's stdio log (~/.nodecode/<store>.stdio.log) for "Recursive lock attempt" and "stdio severed": each sever line is a start, and the backtrace under it names the thread that died.
  ;; ; (3) count the open turn's tool calls and how many carried a sleep, with the event log; a turn polling an external service with (sh "sleep 90") looks hung and is not.
  ;; ; (4) check the thing it polls actually answered before blaming nodecode, and say which of the two it is.
;; (5) when the stall is hours long, settle machine-vs-nodecode before anything else: count the host's own
;; suspension lines (in /home/boxes/osa-data/logs/osa.log*: `被暂停了 N 秒` = the whole box was paused and the
;; monotonic clock froze with it) and the gaps between the turn's journal events. A gap that opens inside a
;; turn.tool_call_started and closes on a suspension line is the host, not the event loop.
;; (6) a respawned gateway is not a repair. `kill -9` aimed at every exe whose path holds "nodecode" also takes
;; the one CLI that holds the operator's session; the daemon's fresh CLI attaches to no session, so the pane
;; renders nothing and no later turn can start. Prove a client is attached (`ss -tnp | grep <gateway port>`),
;; then reattach with `nodecode resume <session-id>`.
;; (7) hours can be self-inflicted without a hang: a merge-wait loop the model wrote itself
;; (`for i in $(seq 1 40); do gh pr view N --json mergeStateStatus; sleep 10; done`) spends a minute of nothing
;; per iteration and is invisible in the log; the merge it waited on, #131, landed 18 s after the gateway resumed.
  ;; evidence 2026-11-13 turn: turn-1U7LATL had 150 calls from 00:32 to 05:57 with 26 sleeps (waiting on an OSA train), while nlt-signal had died at 04:45:51 with "Recursive lock attempt"; the operator read both as one freeze.
  ;; confidence high
  :sources ("session"))
