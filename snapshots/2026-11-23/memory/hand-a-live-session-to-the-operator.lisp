;;; hand-a-live-session-to-the-operator — define-skill recorded by session experience-s-WIAL20RG-turn-1U7RU8L-8G4ARBX6XW, 2026-11-16T13:18:22Z
(in-package :nodecode.evolved)

(define-skill hand-a-live-session-to-the-operator "Đưa một phiên đang chạy cho người dùng bàn phím mà không làm đứt lượt đang chạy, và để client điều khiển sống lâu hơn CLI đã khởi động nó."
;; when một phiên phải tiếp tục chạy trong lúc người dùng nhận bàn phím ở đúng phiên đó, hoặc một lượt chạy nền phải sống lâu hơn CLI đã gọi nó
;; ;; điều khiển bằng `nodecode rpc SESSION`: một dòng start_turn, rồi giữ client đó sống trong session riêng (setsid) — client là con của CLI thì CLI chết là mất
;; ;; steer sau đó bằng một kết nối rpc ngắn riêng, đừng kill tiến trình đang lái để "làm mới"
;; ;; chứng minh bền: so `ps -o sid=` của driver, của CLI và của gateway — sid khác nhau là sống sót, trùng sid nghĩa là sẽ chết theo
;; ;; chứng minh steer đã tới: grep những chữ đầu của steer trong log driver; get_state không trả lời nổi vì replay hàng chục MB
;; ;; giao lại đúng câu lệnh `nodecode resume ID` và nói rõ client nào đang giữ lượt, log ở đâu
;; evidence: lượt 16/11 phiên s-GKPN8NDI chạy 14h22m rồi mất màn hình vì một script kill giết luôn CLI đang giữ nó; mở lại bằng rpc rồi kiểm "1062940 sid=1062937 … 354597 sid=94085" (driver ở session riêng, CLI thì không) và log driver còn ghi sau đó; steer gửi đi thì chưa chứng minh được, get_state im lặng 6 giây vì replay 20 MB
;; confidence medium — bền và chạy được thì đã chứng minh, còn đường steer mới chỉ một lần và chưa đọc lại được
)
