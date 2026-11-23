;;; osa-split-tunnel-breaks-google-one — define-skill recorded by session s-ZEJ9UW9D, 2026-11-23T05:04:15Z
(in-package :nodecode.evolved)

(define-skill osa-split-tunnel-breaks-google-one
  "Sau mỗi restart container osa-phone17, split-google.sh cho 4 app Google đi thẳng eth0 (IP datacenter AWS) khiến Google One báo 'Can't reach Google One' và Play trả 0 offer.
(1) adb -s 127.0.0.1:5563 root (sau restart adbd mất root, không root thì iptables 'Permission denied').
(2) adb shell 'iptables -t mangle -F OUTPUT' => Google One vào được ngay, billing trả offer lại.
(3) mv /tmp/split-google.sh /tmp/split-google.sh.off (pro.py chỉ dựng lại khi thấy file đó).
(4) Kiểm: mở Google One phải hiện 'Current plan ... Google AI Pro (5 TB)'; còn spinner/Can't reach là mark chưa sạch.
(5) Đừng tin dấu ✅ 'đã dựng lại split-tunnel' của pro.py — nó chỉ chạy script, không kiểm app có truy cập được.")
