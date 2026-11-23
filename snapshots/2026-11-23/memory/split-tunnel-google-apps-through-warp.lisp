;;; split-tunnel-google-apps-through-warp — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U80Q30-SORLPVQJHR, 2026-11-21T08:30:51Z
(in-package :nodecode.evolved)

(define-skill split-tunnel-google-apps-through-warp
  "Split-tunnel cho Play/GMS/Google One đi thẳng eth0 (bỏ WARP) — và cách gỡ khi nó làm Google One chết. 21/11/2026, sửa 23/11/2026."
  ;; khi cần cho 3 app Google đi thẳng (vd Play bị WARP chặn), hoặc khi Google One báo Can't reach / Play billing không trả offer sau khi container restart
  ;; DỰNG: bash /tmp/split-google.sh [container] [serial] — quét uid của vending/gms/subscriptions.red/gsf, `iptables -t mangle -F OUTPUT` rồi `-A OUTPUT -m owner --uid-owner <uid> -j MARK --set-mark 0x2` trong container, và trên host `ip rule add fwmark 0x2 lookup main pref 150`.
  ;; GỠ (thường là điều cần): adb root trước (sau restart adbd mất root, không root thì iptables Permission denied; adb -s 127.0.0.1:5563 root), rồi `adb shell 'iptables -t mangle -F OUTPUT'`; mv /tmp/split-google.sh /tmp/split-google.sh.off để pro.py không dựng lại sau mỗi lần nó tự restart container.
  ;; TRIỆU CHỨNG: Google One đứng spinner rồi 'Can't reach Google One', mo-quay/mua báo 'không có sự kiện launched trong 40 giây', quet-het --chi-ultra trả 'lô N/87: 18 ID -> 0 offer' cho mọi lô — trong khi ping 8.8.8.8 và one.google.com từ container vẫn OK. Gỡ mark xong Google One hiện 'Current Plan ... Google AI Pro (5 TB)' ngay.
  ;; ĐỪNG tin dấu ✅ 'đã dựng lại split-tunnel' của pro.py: nó chỉ chạy script, không kiểm 3 app có truy cập được không.
)
