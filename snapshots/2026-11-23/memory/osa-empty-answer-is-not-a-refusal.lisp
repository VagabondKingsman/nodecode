;;; osa-empty-answer-is-not-a-refusal — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7RXCR-2E46X5380B, 2026-11-16T15:07:44Z
(in-package :nodecode.evolved)

(define-skill osa-empty-answer-is-not-a-refusal
  "In /home/boxes/osa an empty model answer is NOT a refusal to the code, so it needs its own rescue path on the Router and the Worker."
  ;; when - một lượt chat hoặc một task kết thúc bằng \"Không có câu trả lời\" / \"Mô hình không đưa ra câu trả lời\", hoặc một model chỉ trả reasoning_content rỗng
  ;; trước hết đọc llm_calls: content rỗng hay bị cắt (finish_reason length)? Cắt là còn nội dung, để IncompleteAnswer như cũ
  ;; rỗng thì gọi freedom.repair(msgs, shown, goal) — nhớ truyền goal, đừng để nó lấy câu user cuối (có thể là CONTINUE_PROMPT)
  ;; ghi traces.note(bot_id, asked, shown, bool(fixed), chat_id) để vòng tự duyệt thấy
  ;; router: câu cũ là lời báo trạng thái thì GIỮ rồi nối câu trả lời thật vào sau, đừng nuốt; xong phát reset rồi delta
  ;; kiểm bằng một provider giả phát rỗng vài lượt (tests/test_router_empty_rescue.py, tests/test_worker_empty_rescue.py) trước khi tin
  ;; evidence - lượt 16/11: router=claude-opus-5 trả rỗng 3 lượt, cả lượt hết bằng \"Không có câu trả lời\" vì is_refusal(\"\") là False nên C31/C35 không chạy; sau khi vá, cùng model đó: lượt về 5 978 ký tự code, task về 8 083 ký tự kèm output chạy thật, traces rescued=1
  ;; confidence - high: có test đỏ trước và hai lần đo live, không phải suy luận
  )
