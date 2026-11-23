;;; osa-android12-gapps-signin — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U7ZFBQ-S2TUO1YSNR, 2026-11-20T15:57:51Z
(in-package :nodecode.evolved)

(define-skill osa-android12-gapps-signin
  "Đăng nhập Google trên máy redroid 12 có MindTheGapps — lối đúng khi Settings không liệt kê tài khoản."
  ;; khi: cần thêm tài khoản Google trên container redroid Android 12 hoặc 13 (kể cả máy vừa dựng lại sạch: 'Settings → Add account' bấm không phản ứng, ADD_ACCOUNT_SETTINGS và PreAddAccountActivity cũng không hiện — đi qua Play Store 'Sign in' thì wizard mở đúng), GApps đã cài nhưng 'Settings → Add account' trống hoặc MinuteMaidActivity crash
  ;; 1. `pm disable-user --user 0 com.google.android.setupwizard` (setupwizard của GApps 12 hay crash và chặn luồng)
  ;; 2. Mở Play Store: `am start -n com.android.vending/.AssetBrowserActivity`
  ;; 3. Bấm nút 'Sign in' trên màn hình Play — đường này cấp đủ extras cho MinuteMaidActivity
  ;; 4. Nhập email (ô ở [50,576][670,686] khi chưa có bàn phím), gõ '@' bằng `input keyevent 77`
  ;; 5. Sau email bàn phím đẩy layout lên: nút NEXT nằm ở [504,569][680,665] chứ không phải 1112
  ;; 6. Trang Terms: nút 'I agree' ở [484,1054][672,1128], bấm (578,1091)
  ;; 7. Kiểm bằng `dumpsys account | grep -c 'Account {'` = 1
  ;; evidence: turn 20/11/2026 — trên 5562, `Settings → Add account` chỉ hiện 'Add an account' rỗng và logcat ghi 'MinuteMaidActivity: java.lang.IllegalArgumentException: Required value was null'; sau khi disable setupwizard + vào Play → Sign in thì form hiện 'NEXT' và đăng nhập xong `Account {name=ngocthoahothi123@gmail.com, type=com.google}`
  ;; confidence: high — lặp lại được trên cả 5557 (Android 12) và 5562
  )
