;;; osa-user-says-not-deployed — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7T4OI-O59F7WCY82, 2026-11-17T06:03:02Z
(in-package :nodecode.evolved)

(define-skill osa-user-says-not-deployed "Khi người dùng nói không thấy một thay đổi giao diện đã merge, chứng minh bản ĐANG PHỤC VỤ có thay đổi đó trước khi kết luận gì."
  ;; khi nào: một PR giao diện đã merge mà người dùng báo vẫn thấy bản cũ, hoặc nói chưa deploy
  ;; 1. Đừng build lại vội. Lấy HTML thật bằng cookie: curl -s -b <cookie> -D- http://127.0.0.1:8765/ — ghi lại asset hash và cache-control của index.html.
  ;; 2. Tải chính asset đó, grep dấu của thay đổi (chuỗi mới trong bản dịch, tên class). Không thấy dấu tức là chưa deploy: quay lại skill osa-serve-merged-branch (checkout, build, restart).
  ;; 3. Có dấu tức là deploy đã có, thiếu là phía trình duyệt: mở trang MỚI trong CDP với Network.setCacheDisabled, đếm phần tử mới, bấm thử và đọc state (localStorage).
  ;; 4. Soi cổng thứ hai: ss -ltnp và tailscale serve status; nếu một instance khác (vd 8799) cùng phục vụ thì kiểm nó trả cùng bundle, tránh việc người dùng đang mở đúng cổng cũ.
  ;; 5. Trả lời bằng việc phía người dùng: Ctrl+Shift+R, hoặc đóng rồi mở lại app/PWA (service worker chỉ network-first cho navigation, không tự nạp lại JS của tab đang mở).
  ;; evidence: 2026-11-17 — người dùng hỏi vẫn chưa thấy nút chuyển ctr enter; curl kèm cookie trả index-DfSNK1vi.js, grep sendmode và Ctrl+Enter trong asset đều ra 1, trang CDP mới với cache tắt thấy đủ 2 nút và bấm đổi localStorage.osa.send sang ctrl ⇒ deploy có thật, chỉ tab kia đứng. Build lại mù thì mất dấu vết và vẫn phải xin người dùng tải lại.
  ;; confidence: high — mỗi bước có đầu ra riêng trong lượt, kết luận đúng ở cả 8765 và 8799.
  )
