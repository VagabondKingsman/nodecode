;;; measure-model-through-the-app — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7S0SD-8TI4R4GOFC, 2026-11-16T17:48:25Z
(in-package :nodecode.evolved)

(define-skill measure-model-through-the-app "Đo một model bằng cách đi qua đúng đường thật của OSA (chat + dispatch), không chỉ gọi thẳng provider."
;; Khi nào: cần biết một model có làm nổi việc khó trong OSA thật hay không — chọn model, so model, kiểm hồi quy hành vi sau khi sửa prompt hay đường cứu.
;; Dùng scripts/redteam_e2e.py (9 đề, chấm bằng py_compile + hình dạng đề), không tự viết vòng đo mới.
;; Chờ bot THẬT SỰ rảnh trước khi reset và gửi: đợi 6 s không có message hay llm_calls mới; lượt cũ còn chảy về sẽ bị đọc thành câu trả lời của lượt mình.
;; Đừng lọc câu trả lời theo tên tệp trong đề (nhiều model đặt tên khác) — chỉ dùng nó làm ưu tiên 5 phút đầu rồi nhận câu đầu tiên.
;; Kiểm supports_tools của model trước: gateway trả 400 "route is not declared to support tools" với model không có tools, và model đó sẽ không dispatch được.
;; Chấm bằng compile thật từng khối, đừng đếm khối: đề C#/Python hay hỏng vì thiếu ngoặc hoặc bị chia khúc.
;; Ghi lại số lượt phải cứu (traces) và model thực chạy (llm_calls) cùng kết quả, để lần sau so được.
;; Bằng chứng: lượt 16/11, lần đo đầu đọc nhầm câu trả lời của lượt trước nên cả ba model đều "FAIL no-code"; sau khi thêm quiet + bỏ lọc tên tệp thì 1017 ra 7/9 và dolphin ra 6–9 s/đề, cả hai khớp nội dung thật trong DB.
;; Độ tin: cao — sai và đúng đều thấy ngay trên cùng một lô đề.
)
