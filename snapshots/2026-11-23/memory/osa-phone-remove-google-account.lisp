;;; osa-phone-remove-google-account — define-skill recorded by session experience-s-ZSN3J701-turn-1U7TYOD-AXETWPMTZG, 2026-11-17T17:00:27Z
(in-package :nodecode.evolved)

;; giữ lại: mẹo xoá tài khoản đúng cách trên redroid 13
(define-skill osa-phone-remove-google-account
  "Xoá một tài khoản Google khỏi container osa-phone và dọn dấu vết: không có lệnh CLI, phải qua UI rồi pm clear"
  ;; khi nào: cần đăng xuất/đổi tài khoản Google trên máy Android của bot, hoặc giao máy cho người khác dùng
  ;; 1. `cmd account` trên redroid 13 chỉ có help/get-bind-instant -> đừng mất thời gian, đi đường UI
  ;; 2. am start -a android.settings.SYNC_SETTINGS -> tap vào email -> tap REMOVE ACCOUNT -> tap REMOVE ACCOUNT ở hộp thoại (nút thứ hai cùng nhãn, dùng `find "^REMOVE ACCOUNT$" | tail -1`)
  ;; 3. pm clear: com.android.vending, com.google.android.apps.subscriptions.red, com.google.android.gms, com.google.android.gsf, com.google.android.partnersetup, com.google.android.setupwizard, com.google.android.googlequicksearchbox, com.android.providers.contacts
  ;; 4. rm -rf /data/system/syncmanager-log/* và rm -f /sdcard/ui.xml /sdcard/u.xml /sdcard/*.png
  ;; 5. kiểm bằng ba phép: dumpsys account | grep -c 'Account {' = 0; grep -rl <email> /data /sdcard rỗng; mở Play và Google One thấy "Sign in"
  ;; evidence: lượt 2026-11-17 bỏ tài khoản tuyetcamluongthi: `cmd account remove <mail> com.google` in ra rỗng và tài khoản vẫn còn (grep -c = 1); chuyển sang UI thì `dumpsys account` về 0 rồi grep /data chỉ còn contacts + syncmanager-log, dọn nốt thì rỗng hoàn toàn
  ;; confidence: high — cùng một phép đo trước/sau, và bước UI là bước duy nhất làm con số về 0
  )
