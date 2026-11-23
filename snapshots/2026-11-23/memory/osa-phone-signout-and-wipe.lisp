;;; osa-phone-signout-and-wipe — define-skill recorded by session s-ZSN3J701, 2026-11-17T16:52:07Z
(in-package :nodecode.evolved)

(define-skill osa-phone-signout-and-wipe
   "Xem osa-phone-remove-google-account (bản đầy đủ). Đăng xuất + xoá sạch tài khoản Google khỏi container `osa-phone`: Settings > Passwords & accounts > tài khoản > REMOVE ACCOUNT (cmd account không có lệnh remove trên redroid 13), rồi `pm clear` com.android.vending, com.google.android.apps.subscriptions.red, com.google.android.gms, gsf, partnersetup, setupwizard, googlequicksearchbox, com.android.providers.contacts; xoá /data/system/syncmanager-log/* và các file dump /sdcard. Kiểm: `dumpsys account | grep -c 'Account {'` = 0, `grep -rl <email> /data /sdcard` rỗng, Play và Google One mở lên đòi Sign in. GMS/Play vẫn còn cài để dùng号 sau; thẻ nằm ở phía tài khoản Google nên không lưu trên máy.")
