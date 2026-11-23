;;; osa-phone-5558-ready — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U7YVTN-526WCHHIJN, 2026-11-20T08:45:23Z
(in-package :nodecode.evolved)

(define-skill osa-phone-5558-ready
  "Máy ảo thứ hai `osa-phone13m` (adb 127.0.0.1:5558, Android 13 + Magisk) đang ở trạng thái 'chờ account': reset 20/11/2026 thành serial 6a2d9f13, android_id c4b8e52a7d1f9063, 0 account; Magisk 30.6 + 4 module (zygisksu, tricky_store, playintegrityfix, Yurikey) + keybox vẫn còn sau restart, frida-server đã chạy. Khi dùng lại: chỉ cần push module_521.apk (/data/local/tmp/module_521.apk) và frida-server trước khi probe, rồi đăng nhập account **cùng country với IP máy (US)** — account VN sẽ bị Play chặn ở bước xác nhận với lỗi 'selected Play country matches your country of residence'.")
