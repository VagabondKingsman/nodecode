;;; reopen-a-dead-nodecode-session — define-skill recorded by session experience-s-WIAL20RG-turn-1U7RSGO-M4YFNQHRXS, 2026-11-16T12:42:51Z
(in-package :nodecode.evolved)

(define-skill reopen-a-dead-nodecode-session "Mở lại một phiên nodecode đã mất client và cho nó chạy tiếp, không dựng TUI chen vào terminal của người."
  ;; when to use: a session's turn died with its CLI (kill, crash, reboot), the process is gone but the session and its history are intact, and the operator wants it continued rather than restarted
  ;; (1) prove it is a dead client and not a hang: ps the pid from the journal, read /proc/PID/task/*/wchan, and check that the session's last turn ended with turn.completed — a completed turn means nothing was mid-flight.
  ;; (2) find the store and the session id from the events (turn_id -> session_directory row), never from a guess.
  ;; (3) write the next prompt to a file, then drive with the gateway's own rpc: a client that pipes one {"type":"start_turn","request":{"prompt":...}} line into `nodecode rpc SESSION` and then holds stdin open with a sleep loop, logging stdout — that log is the only view, so tail it.
  ;; (4) confirm admission by the gateway_turn_command_result frame before reporting anything as running; frames after it (tool_call_started, tool_result) are the proof work resumed.
  ;; (5) tell the operator they can also attach a TUI with `nodecode resume SESSION` — two clients may watch one session; the driver keeps it alive if they would rather not.
  ;; evidence: 16/11, session s-GKPN8NDI: a kill script -9'd the gateway and the only CLI holding it, leaving a respawned CLI attached to no session; the turn had already completed at the journal's end, so nothing was lost. Driving it with rpc over turn-1U7RSK1 got it to pull, dry-run a new script, read the keepalive journal and merge four PRs, while no TUI was spawned into the operator's pty.
  ;; confidence: high — the gateway accepted the turn and every later frame showed real work
)
