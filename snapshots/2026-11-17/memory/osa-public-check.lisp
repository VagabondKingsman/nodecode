;;; osa-public-check — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7HMEF-W21JIV42JI, 2026-11-11T00:52:10Z
(in-package :nodecode.evolved)

(define-skill osa-public-check
  "Kiểm tra link public của OSA (hoặc app nào sau cloudflared quick tunnel) là thật trước khi gửi operator."
  ;; khi nào dùng: operator hỏi 'cho tôi link web' / nghi link 502-1033 / vừa restart server hay cloudflared
  ;; bước 1: lấy URL: ~/osa/scripts/tunnel.sh url — đọc ~/osa-data/logs/tunnel.log (dự án này), fallback ~/.local/share/cfd.log; URL cũng ghi ở ~/osa-data/public-url.txt; trong image là (osa-url)
  ;; bước 2: kiểm 3 lớp, mỗi lớp một lệnh riêng: curl local http://127.0.0.1:8765/manifest.json = 200; pgrep -x cloudflared còn sống; curl -s -o /dev/null -w '%{http_code}' $URL/manifest.json = 200
  ;; bước 3: '/' trả 303 là ĐÚNG (redirect sang /login), không phải lỗi; xác nhận bằng curl $URL/login = 200 và grep '<title>' thấy tiêu đề tiếng Việt
  ;; bước 4: tunnel chết thì ~/osa/scripts/tunnel.sh ensure — tự kiểm từ ngoài, chỉ restart khi URL thật sự không trả lời, rồi in URL mới (đổi mỗi lần restart). Đừng pkill rồi bật tay khi chưa curl /login: sẽ giết một tunnel đang sống và làm link operator đang dùng thành 530
;; bước 5: muốn kiểm cả chat chứ không chỉ trang login: đăng nhập qua chính URL public để lấy cookie (curl -b /tmp/osa.jar là vô dụng vì jar gắn domain 127.0.0.1, không gửi sang domain trycloudflare) rồi mở wss://<url>/ws kèm header Cookie — thiếu cookie thì /ws trả 303/403
;; bước 6: log có ERR "failed to accept QUIC stream: no recent network activity" rồi 'Registered tunnel connection' ~2s sau là blip tự lành: bảo operator Ctrl+Shift+R, đừng restart ngay
;; bằng chứng: 11/11/2026 — cùng một URL: "login=200 <title>Đăng nhập · Open Super Agent</title>" nhưng "url=NONE" do đọc sai file log khiến restart và 'old url now: 530'; sau khi dùng tunnel.sh: "OK https://dem-serum-domain-cutting.trycloudflare.com / ensure_exit=0"
  ;; bằng chứng: turn 11/11/2026 — trước là 'public=303 (login page)' dễ bị đọc thành hỏng, sau khi kiểm /login thì thấy 'login=200 <title>Đăng nhập · Open Super Agent</title>' nên khẳng định được link sống
  ;; độ tin: high — ba lớp độc lập (local, tiến trình, public) đều đo được trong cùng một lượt
  )
