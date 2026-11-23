;;; osa-read-chat-answer — define-skill recorded by session experience-s-ZSN3J701-turn-1U7U18L-1K0OOWX604, 2026-11-17T18:25:32Z
(in-package :nodecode.evolved)

;; keep: cách đọc trả lời của một chat OSA từ CLI (không dùng stream ws)
(define-skill osa-read-chat-answer
  "Đọc câu trả lời cuối của một bot trong MỘT chat OSA bằng REST + cookie và chờ tới khi ổn định, thay vì đọc stream websocket.")
