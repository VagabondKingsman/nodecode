;;; osa-instabox-android-gapps — define-skill recorded by session experience-s-ZSN3J701-turn-1U7TQUW-XJ3KA8CTL7, 2026-11-17T14:32:15Z
(in-package :nodecode.evolved)

;; viết lại skill cho đúng khuôn: khi nào dùng / bằng chứng / độ tin
(define-skill osa-instabox-android-gapps
  "Dựng Android có Google Play trên máy ảo Instabox để chạy việc cần Play Billing, và giữ máy khỏi bị suspend.
;; when: sau khi dựng xong phải đăng nhập Google trên chính máy đó
;; Đăng nhập qua GMS WebView: gõ email bằng `input text` hay để lại dấu chấm cuối ô và Google trả “Couldn't find this account” (câu lỗi còn nằm lại sau khi đã sửa) — gõ từng khúc, đọc lại ô bằng uiautomator cho đúng chữ rồi mới bấm NEXT; email đúng thì NEXT sang tran
; ghim frida 16.7.19 cho cả máy tính lẫn frida-server: frida 17 bỏ bridge Java khỏi runtime, script Java.use chết im lặng trong setInterval (pip install frida==16.7.19; tải frida-server-16.7.19-android-x86_64.xz)
; UI treo sau khi GApps/Play cập nhật (mCurrentFocus=null, screencap ghi lỗi): docker kill rồi docker start, đừng docker restart vì chờ tắt êm quá 190s
; mỗi lần reboot phải svc power stayon true; màn hình tắt thì input tap không ăn dù mWakefulness=Awake
; script có cổng chờ người đọc stdin: cho stdin là FIFO (mkfifo; sleep 3600 > fifo &) rồi echo > fifo để bấm tiếp, đừng để EOF vì hàm chờ bỏ qua ngayg mật khẩu. Tài khoản bật 2FA sẽ đứng ở “Check your <tên máy>”, phải có người bấm trên máy thật hoặc TRY ANOTHER WAY lấy mã SMS/email.
;; evidence: lần gõ đầu ô hiện “tuyetcamluongthi@gmail.com.” và báo Couldn't find this account; xoá sạch, gõ “tuyetcamluongthi” rồi “@” rồi “gmail.com” thì ô đúng chữ và NEXT mở trang “Welcome” — nhưng vì đọc lại ngay sau khi gõ, câu lỗi cũ vẫn hiện nên phải bấm NEXT mới biết đúng sai.
;; confidence: medium — một lần trên redroid 13, chưa lặp lại.")
