;;; osa-watchdog-measures-silence-not-liveness — define-memory recorded by session experience-s-MJ1G3NHN-turn-1U7VMYW-GE9M47XFE0, 2026-11-18T14:51:00Z
(in-package :nodecode.evolved)

(define-memory osa-watchdog-measures-silence-not-liveness "In /home/boxes/osa the watchdog cancels a task when now minus task.last_progress passes limits.no_progress_s (900 s), and last_progress only advances between tool calls, so a step legitimately waiting looks exactly like a hung one; Task.tool_name and Task.tool_started, set in worker._run_calls.one and cleared at log.finish, are the seam for teaching it the difference." :type :lesson)
