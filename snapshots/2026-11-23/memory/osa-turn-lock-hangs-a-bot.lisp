;;; osa-turn-lock-hangs-a-bot — define-memory recorded 2026-11-18
(in-package :nodecode.evolved)

(define-memory osa-turn-lock-hangs-a-bot
  "On this box a bot that answers nothing while OSA is up is holding its own turn lock: the store shows user messages arriving for that bot, zero llm_calls for it, tasks and approvals empty, and other bots still calling models. Restarting the user unit osa.service clears it."
  :type :lesson
  ;; Evidence 2026-11-18, Nova (bot 1): last llm_calls 08:47:23/30/38, then user messages
  ;; 09:01:44, 09:05:48, 09:06:33, 09:26:11 (chat 1), 09:26:21 (chat 13), 11:01:32 with no
  ;; llm_call after them; meanwhile bot 3 called models until 09:30:32, and GET /api/bootstrap
  ;; answered tasks=0 approvals=0. osa/router.py keeps one asyncio.Lock per Router
  ;; (self.lock at line 407) taken in respond() (line 464) and in _publish (line 1526); a turn
  ;; that never leaves respond() keeps it, so every later message queues behind it silently.
  ;; What started it: task 9 began at 08:47 and its computer_shell step (a PIL image read on the
  ;; Instabox machine) ran 926 s; the watchdog cancelled the task at 09:03:04, but the chat turn
  ;; stayed stuck.
  ;; Diagnose from the store, never from the UI: OSA_DATA_DIR is /home/boxes/osa-data
  ;; (tr '\0' '\n' < /proc/<pid>/environ), store osa-data/osa.db. Compare max(ts) in llm_calls
  ;; per bot_id against messages whose role is user and that nothing followed; look at
  ;; task_steps for that bot's task ids and their dur/status.
  ;; Fix: export XDG_RUNTIME_DIR=/run/user/1002; systemctl --user restart osa.service; then prove
  ;; it with a real message: osa-send (cells/cursor-agent/osa-send.lisp) posts over
  ;; ws://127.0.0.1:8765/ws with OSA_PASSWORD from /home/boxes/osa/.env. After the restart Nova
  ;; answered at 13:14:58 (llm_calls 5190 and 5191 on deepseek-v4.1-flash-1017).
  ;; Gotcha that cost the most time: osa.log timestamps are UTC+7 while the box runs UTC, so a
  ;; window picked from local time reads the wrong lines — subtract seven hours from the log stamp
  ;; (or shift local +7). CLOSE-WAIT sockets to 443 for long periods are the other visual sign.
  ;; ROOT FIX 2026-11-18 (same day), in /home/boxes/osa: Router.respond now bounds the turn.
  ;; _turn_timeout_seconds() reads limits.turn_timeout_s (config.yaml, default 1800, 0 = off) and
  ;; the turn runs under asyncio.wait_for; TimeoutError logs a warning, posts a kind=turn-timeout
  ;; task line and returns, so the finally still releases the lock.
  ;; The first patch attempt deleted the module line that names the logger; the new test caught it
  ;; with NameError, which is why that test exists.
  ;; tests/test_turn_timeout.py: 2 tests. Run with uv run python -m pytest
  ;; tests/test_turn_timeout.py -q (the system python3 has no yaml here). The 18 router tests in
  ;; test_router_midstream / dispatch_claim / empty_rescue / self_check still pass.
  ;; Deployed by systemctl --user restart osa.service (MainPID 904943); osa-send to chat 1 then
  ;; answered OK - Nova, the same call that had been silent for 2.5 hours.
  ;; SECOND FIX the same day, same repo, commit 36cd473 on fix/turn-timeout-lock: a tool step that
  ;; goes silent must cost that step, not the task. worker.py gained Task.tool_name/tool_started,
  ;; _run_with_ceiling() and tool_timeout_s() (config.yaml tool_timeout_s, 600 default, 0 off);
  ;; one() runs each tool under it, and on TimeoutError the model gets 'this tool did not return in
  ;; N s, the step is given up, the task continues' with status error - the task goes on.
  ;; progress_for() now refreshes task.last_progress, so a tool that keeps reporting progress is
  ;; waited out however long it runs (a long build, the user holding the desk, a model thinking);
  ;; only silence trips the ceiling. watchdog.py names the live tool in its reason. Task.public()
  ;; carries tool and tool_s. tests/test_tool_ceiling.py: 5 tests; with test_turn_timeout and the
  ;; watchdog/stream/clock suites 51 passed. Deployed by restart (MainPID 1982916); osa-send
  ;; answered OK - Nova.
  ;; Open: a running task's public() was never read over HTTP - /api/tasks folds tasklog history
  ;; and has no tool field; GET /api/bootstrap is where public() shows up. Check it there.
  ;; confidence: high — the diagnosis below and the fix above are this turn's own output.
  )
