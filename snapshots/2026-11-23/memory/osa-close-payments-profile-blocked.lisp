;;; osa-close-payments-profile-blocked — define-skill recorded by session s-ZEJ9UW9D, 2026-11-23T05:04:15Z
(in-package :nodecode.evolved)

(define-skill osa-close-payments-profile-blocked
  "Đóng payments profile: luồng wipeout cần popup reauth thật rồi iframe payments/u/0/wipeout; WebView máy ảo chết ở popup, Chrome/Xvfb mở popup thành tab 404.
(1) payments.google.com/gp/w/home/settings -> link 'Close payments profile' (~175,565 sau scroll) -> cửa sổ popup reauth -> rồi trang payments/u/0/wipeout chứa nút 'Close payments profile' và ô chọn lý do.
(2) WebView trên osa-phone17: popup tới ô mật khẩu thì được, nhập xong ra trang trắng (gp/w/rl) không postMessage -> kẹt. Stub window.open thì Google báo 'Couldn't reauthenticate you. Please close any popup blockers'.
(3) Headless chrome bị chặn từ bước email ('This browser or app may not be secure'); Chrome headed trong Xvfb (Xvfb :103 + google-chrome --user-data-dir riêng --remote-debugging-port=9334, lái bằng CDP) đăng nhập được nhưng popup mở thành tab URL cụt (chỉ tc=...) -> 404; tự dựng iframe đúng params -> [OR-ORCRI-01].
(4) Google cảnh báo: đóng profile KẾT THÚC NGAY mọi free trial Play (mất phần Pro còn lại).
(5) Cách chắc ăn: Chrome thật trên điện thoại của chủ account -> payments.google.com -> Settings -> Close payments profile -> chọn 'I no longer need this profile' -> Next/Confirm.
(6) Đã làm được bằng tay: xoá thẻ (Remove 356,1103 -> Remove and save 507,941 -> 'No payment methods yet?'); huỷ gói (Cancel subscription -> nút PHẢI 522,1120 -> 'Canceled ... will end on ...'); gỡ account (REMOVE ACCOUNT -> confirm). pro.py huy-goi/dang-xuat hay bấm nhầm nút trái nên phải làm tay.")
