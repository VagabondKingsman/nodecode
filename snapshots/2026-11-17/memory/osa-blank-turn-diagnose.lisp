;;; osa-blank-turn-diagnose — define-skill recorded by session experience-s-83IFGT1L-turn-1U7NI03-Z279P6XVDM, 2026-11-14T06:11:43Z
(in-package :nodecode.evolved)

;; keep the diagnostic procedure this turn worked out
(define-skill osa-blank-turn-diagnose "Khi một lượt bot trả về rỗng hoặc vài chục ký tự, tìm nguyên nhân trong log thay vì đoán theo model." ;; when-to-use: một lượt OSA trả về 'Không có câu trả lời' / <50 字 / không có code cho đề đáng lẽ phải có, và cần biết vì sao trước khi sửa gì
;; 1. grep '对话 <chat_id> 出错' trong osa-data/logs/osa.log, đọc traceback ngay dưới dòng đó
;; 2. 404 Model not found → provider đổi model dưới chân: kiểm CFG['roles'][...]['model'] so với model có thật trên provider, rồi sửa role hoặc để chuỗi cứu hộ bắt (C55)
;; 3. StreamStalled → model chậm/bị cắt; kiểm max_tokens và vòng viết tiếp (C52)
;; 4. Không có traceback mà vẫn rỗng → nghi bộ dò từ chối / nhánh cứu, không nghi model
;; evidence: lượt phishing trả 20 字, traceback ghi 'openai.NotFoundError: Error code: 404 - Model not found'; sau khi thêm nhánh lùi 404→model cứu hộ, cùng đề ra 'phish2: id=1537 len=12713 code=True'
;; confidence: high - nguyên nhân đọc được nguyên văn trong log, và phép đo trước/sau cùng một đề
)
