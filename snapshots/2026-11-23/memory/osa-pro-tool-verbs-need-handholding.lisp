;;; osa-pro-tool-verbs-need-handholding — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U83XXU-1QUYCCOOO6, 2026-11-23T02:55:55Z
(in-package :nodecode.evolved)

(define-skill osa-pro-tool-verbs-need-handholding
  "Trên osa-phone17 ba verb của bộ tool Pro (huy-goi, xoa-the, dang-xuat) báo xong nhưng chưa xong — phải tự bấm nốt bằng toạ độ. Xác nhận 23/11/2026."
  ;; khi chạy huy-goi / xoa-the / dang-xuat của /home/boxes/.local/share/nodecode/bo-tool-pro/chay.sh trên máy ảo và cần chúng thật sự hoàn tất
  ;; huy-goi: tool báo '✅ Đã bấm huỷ' nhưng trang vẫn 'Active … Next payment'; nó bấm trúng 'Keep subscription'. Mở play.google.com/store/account/subscriptions → tap card gói (432,808) → swipe → 'Cancel subscription' (361,1136) → sheet chọn lý do: nút PHẢI 'Cancel subscription' ở (522,1120) → kiểm phải thấy 'Canceled … will end on <date>'.
  ;; xoa-the: tool dừng ở account chooser của WebView (các acc cũ 'Signed out'). Bấm 'Use another account' → ô email (52,630) → input text tên + keyevent 77 cho '@' + input text gmail.com → Next (593,1086) → mật khẩu → Next → 'NOT NOW' ở lời nhắc lưu mật khẩu → 'Verify it's you' → bấm Yes + số trên điện thoại thật → 'Remove' (356,1103) → 'Remove and save' (507,941) → kiểm 'No payment methods yet?'.
  ;; dang-xuat: tool in 'Số tài khoản còn lại: 1'. Tự làm: cmd statusbar collapse, am start -a android.settings.SYNC_SETTINGS, tap acc (383,1129), tapin 'remove account' (359,1052), dialog (500,728) → dumpsys account | grep -c 'Account {' phải = 0.
  ;; bài học chung: coi mọi '✅' của pro.py là 'đã gửi lệnh', không phải 'đã xong' — luôn đọc lại màn hình/DB sau đó.
  :sources ("session"))
