;;; osa-new-us-ip-via-warp-endpoint — define-skill recorded by session s-ZEJ9UW9D, 2026-11-23T05:04:04Z
(in-package :nodecode.evolved)

(define-skill osa-new-us-ip-via-warp-endpoint
  "Đổi IP US sạch cho osa-phone17: WARP endpoint quyết định colo, không phải registration mới.
(1) cd /tmp && ./wgcf register --accept-tos && ./wgcf generate; dựng /tmp/wg0.conf từ wgcf-profile.conf (warp-new.sh).
(2) Endpoint [2606:4700:d0::a29f:c001]:2408 => egress US 104.28.201.x (Richland/West Pasco WA) — dùng cái này.
(3) 162.159.192.5:854 => Hà Nội VN 104.28.254.x; 162.159.192.1:2408 và 188.114.96.1:2408 => handshake OK nhưng tunnel câm.
(4) Trong dải US, IP đổi mỗi lần reconnect: wg set peer endpoint + persistent-keepalive 25 rồi set lại.
(5) Chốt bền: sửa dòng Endpoint trong /tmp/wg0.conf.
(6) Kiểm từ CHÍNH máy ảo: am start -a android.intent.action.VIEW -d https://api.ipify.org rồi drv.py texts; nc trên redroid hay im lặng, ipinfo.io hay 429 nên dùng api.ipify.org + ipwho.is.
(7) Sau restart container: adb root lại, bật lại frida-server, kiểm ip rule 'lookup 100' cho IP container (warp-phone.sh osa-phone17).")
