;;; prove-boot-autostart — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7HOIT-JZZGTHY3F2, 2026-11-11T01:42:43Z
(in-package :nodecode.evolved)

;; keep the boot-safety proof procedure as a skill (it is what actually proved task 1)
(define-skill prove-boot-autostart
  #>END
Chứng minh một dịch vụ tự lên sau reboot mà không cần reboot thật: stop sạch → start đúng target mà boot dùng → đọc lại trạng thái + số lần restart.
;; Khi nào: vừa dựng systemd unit (nhất là user unit, oneshot, hoặc có Restart=always) và phải trả lời "reboot xong nó có tự lên không?" — nhất là khi máy không được reboot ngay.
;; 1. Xác nhận unit thuộc đường boot: systemctl --user is-enabled <unit> (phải là enabled) và loginctl show-user $USER -p Linger (user unit chỉ chạy lúc boot khi Linger=yes).
;; 2. Gỡ sạch trạng thái cũ: systemctl --user stop <các unit> theo thứ tự ngược phụ thuộc (cái phụ thuộc trước), rồi kiểm không còn process mồ côi giữ socket/port (pgrep -x <tên>; ss -ltnp).
;; 3. Mô phỏng boot: systemctl --user start default.target — đây đúng là thứ boot chạy, nên nó khác hẳn "systemctl start <một unit>".
;; 4. Đọc lại bằng chứng, không tin receipt: is-active cả nhóm, systemctl --user show -p NRestarts (0 = không restart-loop), log lần khởi động mới nhất, và một request thật qua cổng dịch vụ (curl -sS -o /dev/null -w '%{http_code}').
;; 5. Chạy lại bước 2–4 lần thứ hai: lần đầu còn sót state cũ, lần hai mới giống reboot thật.
;; 6. Nếu dịch vụ còn một lớp mạng/tunnel (tailscale serve, cloudflared…) mà máy này không tự gọi được, ghi rõ "phần đó chờ <client> xác nhận" — đừng claim đã thông.
;; bằng chứng: lượt 11/11 dựng 3 unit OSA, mô phỏng boot 2 lần → is-active 3/3 active, NRestarts=0, local 200, serve=http://osa.taila99125.ts.net. Trước đó cách làm sai đã gặp: tailscaled mồ côi giữ ~/.tailscale/tailscaled.sock làm unit chết "address already in use" rồi restart-loop — nên bước 2 (kiểm process mồ côi) là bắt buộc, không phải hình thức.
;; độ tin: cao — quy trình có bằng chứng đọc lại từ systemd, và cạm bẫy đã thực sự xảy ra trong chính lượt này.
END
  :project "/home/boxes")
