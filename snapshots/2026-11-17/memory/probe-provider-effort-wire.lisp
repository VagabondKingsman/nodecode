;;; probe-provider-effort-wire — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7KV24-T6HMUVCWBN, 2026-11-12T18:53:22Z
(in-package :nodecode.evolved)

(define-skill probe-provider-effort-wire #>END
Trước khi tin ladder effort của image cho một provider, đo thẳng wire xem provider nhận những rung nào và rung tắt tên gì.
;; khi nào: model/provider mới, hoặc nghi rung "off" của image bị lane dịch sai/nuốt mất
;; đọc ladder của image trước: (effort-choices provider model) và (resolve-model-capability ...)
;; lấy key từ /home/boxes/.nodecode/auth.json, gửi từng rung bằng curl tới /v1/chat/completions với max_tokens ~400
;; ghi lại mã HTTP và usage.completion_tokens_details.reasoning_tokens của từng rung: 0 nghĩa là đã tắt thật
;; rung nào 400 thì đọc nguyên văn thông báo lỗi — đó là danh sách rung thật của provider
;; đối chiếu: rung provider có mà image thiếu, và rung image gửi mà provider không nhận
;; Bằng chứng: rung "off" của image -> provider 400 "expected one of 'none', ... 'max'", còn "none" -> 200 với rtok 0; và image bỏ hẳn field khi "off" (openai-completions.lisp:109-111) nên off lặng lẽ để model nghĩ. Độ tin: cao — mỗi rung một request, kết quả đọc được.
END)
