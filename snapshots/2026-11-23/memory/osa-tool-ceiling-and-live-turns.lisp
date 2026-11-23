;;; osa-tool-ceiling-and-live-turns — define-memory recorded 2026-11-18
(in-package :nodecode.evolved)

(define-memory osa-tool-ceiling-and-live-turns
  "In /home/boxes/osa a tool step is bounded on its own silence, and a tool that keeps reporting progress keeps the task alive: a hung step costs that step, not the task."
  :type :lesson
  ;; Why: 2026-11-18 a computer_shell step (PIL image read on the Instabox machine) ran 926 s with
  ;; no progress signal. task.last_progress only moved AFTER a tool returned, so the watchdog's
  ;; "900 s without progress" test could not tell a live step from a dead one and cancelled the
  ;; whole task - twice (#8 at 08:33, #9 at 09:03) - and the chat turn behind it then held the
  ;; bot's lock for 2.5 h (see osa-turn-lock-hangs-a-bot).
  ;; What changed (commit 36cd473, PR #174, branch fix/turn-timeout-lock):
  ;;   worker.py: Task.tool_name / Task.tool_started record the step in flight; tool_timeout_s()
  ;;   reads limits.tool_timeout_s (config.yaml, default 600, 0 = off); _run_with_ceiling() waits
  ;;   in 15 s slices and gives up only when clock.now() - task.last_progress > ceiling, cancelling
  ;;   the coroutine and raising TimeoutError; one() turns that into an error result for the model
  ;;   and the task goes on. progress_for() sets task.last_progress on every progress report, so a
  ;;   long build, a desk handed to the user or a thinking model is waited out.
  ;;   watchdog.py names the tool in the reason: "{n} 秒没有进展（工具 {tool} 还在跑）".
  ;;   Task.public() exposes "tool" and "tool_s", so /api/bootstrap shows what a RUNNING task is
  ;;   inside and for how long. /api/tasks reads the historical log and has no such fields.
  ;; Tests: tests/test_tool_ceiling.py, 5 cases (silent tool abandoned; talking one waited out;
  ;; 0 = no ceiling; ceiling reads config; a progress report counts as life). `uv run python -m
  ;; pytest tests/test_tool_ceiling.py tests/test_turn_timeout.py -q` -> 7 passed; wider set
  ;; (background loops, stream stall, clock) -> 51 passed. System python3 has no yaml.
  ;; Deployed by systemctl --user restart osa.service; live proof: osa-send to chat 1 answered.
  ;; confidence: high - every number is this session's own output.
