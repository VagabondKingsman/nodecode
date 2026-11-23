;;; osa-finish-a-round-b-item — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7HX1B-S0AZKKSE5, 2026-11-11T05:23:14Z
(in-package :nodecode.evolved)

(define-skill osa-finish-a-round-b-item
  "Finish one vòng-B item in /home/boxes/osa: code, focused tests, then the whole suite, then a commit of its own."
  ;; When: starting or closing one numbered item (B1..B9) of docs/ke-hoach-super-bot.md — the work
  ;; touches computer/, approvals, server or a channel adapter and must not break the rest.
  ;; 1. read the plan row (anchors give the file:line) and the current code before writing anything.
  ;; 2. reproduce the gap with a focused test first; run only the touched files
  ;;    (.venv/bin/python -m pytest tests/test_x.py -q) while iterating.
  ;; 3. any test that drives computer_shell through computer.tools.call must call
  ;;    (approvals.shell_confirmed TASK_ID) first, or the approval card waits forever and pytest hangs.
  ;; 4. gate: ./scripts/test.sh (it wraps xvfb-run when DISPLAY is empty; web: cd web && npm test,
  ;;    npx tsc --noEmit) — 940+ tests, about 95 s.
  ;; 5. commit that one item with `git commit -F -` and a heredoc message: what, why, the tests added.
  ;; 6. đổi tên một hàm trong osa/ mà chỗ khác gọi: grep lời gọi + tests trước, và giữ tên cũ làm alias mỏng.
  ;;    `delete_group` → `delete_chat` (chat riêng) làm 3 test đỏ với "module 'osa.bots' has no attribute
  ;;    'delete_group'" (test_botadmin x2, test_threads), sửa bằng một `delete_group` gọi lại `_delete_chat` cho group.
  ;; Evidence: B1 and B2 each ended in "938 passed" / "942 passed" before their commits (28a418b, 8eabdca);
  ;; the first B1 test run hung because the card was never answered — step 3 is that failure, fixed.
  ;; Confidence: high for the loop, medium for step 4's timing on a loaded box.
  )
