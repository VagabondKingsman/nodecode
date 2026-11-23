;;; publish-a-local-dashboard-and-prove-its-gate — define-skill recorded by session experience-s-CC94P7FJ-turn-1U7U3MO-KQMBRYNR12, 2026-11-17T18:38:58Z
(in-package :nodecode.evolved)

(define-skill publish-a-local-dashboard-and-prove-its-gate
  "Đưa một dashboard/app local lên tailnet cho người ngoài dùng, và chứng minh cổng bằng bảng curl thay vì tin vào config."
  ;; when: a local service (dashboard, control panel) has to be opened to the operator's own devices on a tailnet, and the question is who can reach it and what they must present
  ;; 1. chọn cách bind: bind thẳng IP tailnet (ss -ltnp thấy 100.x.y.z:PORT) là đủ nếu không cần HTTPS; `tailscale serve --https` chỉ để có TLS - và nó cần root một lần (tailscale set --operator=$USER)
  ;; 2. đừng bind 0.0.0.0 nếu app có "companion loopback" - app nào cũng nên giữ 127.0.0.1:PORT không credential cho client local, chỉ thêm một listener mang credential cho cổng tailnet
  ;; 3. nếu dashboard có tính năng theo origin (Remember this device / cookie), khai báo đúng origin HTTPS sẽ dùng trong config trước khi serve, không thì nút đó tắt
  ;; 4. chứng minh bằng bảng 4 ô trên chính địa chỉ tailnet: root HTML 200, /api/... không token 401, /api/... + bearer 200, và listener companion 127.0.0.1 không token 200
  ;; 5. kiểm tên máy: tailscale dns status - accept-dns=false thì MagicDNS không resolve trên box, phát IP cho người dùng chứ đừng phát tên
  ;; evidence: this turn - config says hostname 100.112.118.106 but only the curl matrix proved it: "=== /api/providers no token === status=401" cạnh "=== /api/providers with token === status=200", và "=== /v1/models via loopback (no token, companion) === status=200" cạnh "=== /v1/models via tailnet (no token) === status=401"; curl http://osa:10100 trả "Could not resolve host: osa" vì accept-dns=false
  ;; confidence: high - bảng curl đọc trực tiếp trên endpoint, không suy từ config
  )
