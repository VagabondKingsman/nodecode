;;; bot-pass-table-needs-a-task-step — define-skill recorded by session experience-s-ZSN3J701-turn-1U7U3RG-9T5K26N7ZP, 2026-11-17T18:50:41Z
(in-package :nodecode.evolved)

(define-skill bot-pass-table-needs-a-task-step
  "Trước khi tin bảng PASS/FAIL bot tự trình bày, đọc task_steps của chính task đó: worker lỗi (402/timeout) thì bảng đó là bịa."
  ;; when: bot trả về bảng PASS kèm 'output thật' mà không có tool call tương ứng trong lượt, hoặc câu trả lời xuất hiện ngay sau một dispatch
  ;; mở SQLite của OSA, đọc task_steps theo task_id: kind='note' status='error' là dấu hiệu worker chết (ví dụ 'Hết hạn mức (402 -)')
  ;; coi mọi bảng PASS không có dòng tool/answer thật là BLOCKED, không phải PASS — không chuyển tiếp cho operator
  ;; kiểm chéo bằng một lệnh tự chạy, so với con số bot đưa
  ;; evidence: khi xai 402, bot vẫn in bảng PASS với 'mid=1234567890abcdef1234567890abcdef12345678', 'key_len=32', '(8 dòng cuối của setup-machine.sh) exit=0'; task_steps cùng lúc ghi 'Tác vụ thất bại: Hết hạn mức (402 -)'
  ;; confidence: high — có cả bảng giả và dòng lỗi worker trong cùng lượt
)
