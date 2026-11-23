;;; osa-phone-full-cycle-one-script — define-skill recorded by session s-ZEJ9UW9D, 2026-11-23T05:04:15Z
(in-package :nodecode.evolved)

(define-skill osa-phone-full-cycle-one-script
  "Chu trình dọn-đổi máy một lệnh: /tmp/wipe.sh trên máy bot; đăng xuất acc bằng tay TRƯỚC (pm clear không xoá account).
(0) Settings → Passwords & accounts → account → REMOVE ACCOUNT → confirm; dumpsys account | grep -c 'Account {' phải = 0.
(1) sh /tmp/push.sh /tmp/wipe.sh rồi sh /tmp/ib.sh bg 'bash /tmp/wipe.sh'; đọc /tmp/gu/bg.log. Script làm: force-stop + pm clear vending/subscriptions.red/gms/gsf/partnersetup/setupwizard/googlequicksearchbox/contacts/docs/photos/wellbeing, rm syncmanager-log, đổi ro.serialno ở /system+/vendor build.prop, settings put secure android_id, rm settings_ssaid.xml, docker restart osa-phone17, chờ sys.boot_completed, bật lại /data/local/tmp/frida-server, warp-new + warp-phone, in bảng kiểm tra.
(2) Dọn vết backup: pm clear com.google.android.syncadapters.calendar + com.android.localtransport; rm /data/data/com.android.localtransport/files/*; grep -rl <email> /data/system /data/data /sdcard phải rỗng.
(3) Sau restart: adb root lại, iptables -t mangle -F OUTPUT (bỏ split tunnel), mv /tmp/split-google.sh /tmp/split-google.sh.off.
(4) Chốt egress US: endpoint [2606:4700:d0::a29f:c001]:2408; kiểm từ máy ảo bằng api.ipify.org trong WebView.
(5) Kết quả 23/11/2026: serial 010594af, android_id 13e6c7a309e2e7f8, model Pixel 7a, Play mở lên 'Sign in', frida pid sống.")
