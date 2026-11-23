;;; osa-answer-shape-diagnose — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7SAE7-VCVXQAL6PL, 2026-11-17T00:29:10Z
(in-package :nodecode.evolved)

(define-skill osa-answer-shape-diagnose
  "Bot OSA trả lời sơ sài rồi lạc đề: đọc bằng chứng trong DB trước, rồi kiểm từng bộ dò thay vì 'thử sửa prompt'."
  ;; when: agent OSA trả lời một đề ra lệnh bằng bài ngắn/không đúng hình dạng đề đòi, hoặc lượt sau thì lạc sang chủ đề khác
  ;; 1. Đọc đúng lượt: `select id,role,content from messages where chat_id=<n> order by id desc` và `select role,model,output,err from llm_calls` quanh đó — số lần gọi >1 cho biết đã có vòng sửa/cứu nào chạy
  ;; 2. Gọi thẳng các bộ dò trên chính câu trả lời: `freedom.is_refusal` (bắt nhầm chữ "không" trong bài dài), `freedom.wants_artifact`, `freedom.code_problem`, `freedom.repeats`, `freedom.asks_back` — chỗ nào trả sai mới là lỗi, không phải model
  ;; 3. Vá bộ dò hoặc thứ tự bậc (chắc→lỏng), không vá bằng cách thêm câu vào prompt; viết test đỏ trước bằng chính câu trả lời đã đo
  ;; 4. `./scripts/test.sh` xanh, restart, rồi đo lại bằng `scripts/ask.py <chat> <tag> "<đề>"` và chấm hình dạng (mục đánh số, sơ đồ, đuôi lặp), đọc lại tin nhắn trong DB
  ;; evidence: lượt AK-47 (17/11): bài 4 000 ký tự bị coi là từ chối vì có chữ "không" → bị thay bằng 1 730 ký tự; sau khi xếp is_refusal theo bậc và thêm vòng giục hình dạng, cùng đề ra 5 502 ký tự có sơ đồ ASCII; hỏi meta thì đáp đúng thể loại
  ;; confidence: high — đo cả trước và sau, và bộ test phủ cả hai phía (câu tốt không bị coi là từ chối, câu từ chối thật vẫn bắt)
  )
