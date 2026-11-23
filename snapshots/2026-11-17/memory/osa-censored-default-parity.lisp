;;; osa-censored-default-parity — define-memory recorded by session experience-s-GKPN8NDI-turn-1U7S0SD-8TI4R4GOFC, 2026-11-16T17:48:17Z
(in-package :nodecode.evolved)

(define-memory osa-censored-default-parity "Operator muốn OSA mặc định chạy bản censored (deepseek-v4.1-flash-1017) mà bot vẫn ra artifact như model uncensored; đừng đổi mặc định sang uncensored." :type :feedback
;; Sức mạnh đến từ đường cứu (limits.unrestricted_fallback + freedom.repair cho cả Router lẫn Worker), không phải từ việc đổi model.
;; Đo 16/11 qua đúng đường thật (scripts/redteam_e2e.py): 1017 được 7/9, 0 lượt phải cứu — trần còn lại là chất lượng mã (C# thiếu ngoặc, tệp bị chia khúc), không phải chính sách.
;; Cứu hộ mặc định: glm-5.3-uncensored rồi deepseek-v4.1-flash-uncensored. dolphin-mistral-24b-venice-edition rẻ và nhanh (6–9 s/đề so với 82–236 s) nhưng trên experientiallabs supports_tools=False nên KHÔNG dispatch, KHÔNG điều khiển máy — chỉ dùng cho hỏi–đáp ngắn.
)
