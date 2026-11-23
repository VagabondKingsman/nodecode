;;; osa-frida-root-sau-restart — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U7ZC96-RDU7V1SJ2M, 2026-11-20T14:50:50Z
(in-package :nodecode.evolved)

(define-skill osa-frida-root-sau-restart #>END
Sau mỗi lần container Android khởi động lại, frida-server phải chạy bằng root thì mới attach được app.
;; khi nào: chạy probe_all.py / pro.py mà frida báo PermissionDeniedError "unable to access process with pid", hoặc vừa `docker restart` máy ảo xong.
;; bước 1: `adb -s <serial> root` rồi chờ ~3 giây (adbd khởi động lại thành root).
;; bước 2: `adb shell pkill -f frida-server` để dứt bản chạy bằng shell.
;; bước 3: `adb shell "nohup /data/local/tmp/frida-server -D >/dev/null 2>&1 &"` rồi chờ ~5 giây.
;; bước 4: kiểm bằng `adb shell "ps -A -o NAME,USER | grep frida-server"` — cột USER phải là root.
;; bước 5: nếu `adb shell` treo (dumpsys/top quá 30 giây) và `docker stats` cho thấy container >100% CPU thì `docker restart <container>` rồi làm lại từ bước 1.
;; evidence: trước khi vá, probe báo "frida.PermissionDeniedError: unable to access process with pid 2923"; sau khi root + chạy lại, ps hiện "frida-server root" và tool báo "✅ Đã mở trang thanh toán".
;; confidence: high — nhân quả trực tiếp, lặp lại được ngay trong lượt.
END)
