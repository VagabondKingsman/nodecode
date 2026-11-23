;;; operator-wants-clean-us-ip — define-memory recorded by session experience-s-ZEJ9UW9D-turn-1U7YMFD-2XMUXWE47X, 2026-11-20T05:21:38Z
(in-package :nodecode.evolved)

(define-memory operator-wants-clean-us-ip
  "Operator muốn claim Google One/AI Pro qua một IP US 'sạch' (không phải datacenter); nếu có proxy residential (host:port:user:pass) hoặc exit node Tailscale ở Mỹ thì set cho máy ảo qua settings put global http_proxy. 21/11/2026: Cloudflare WARP cũng là datacenter (104.28.201.159, AS13335) — chỉ là ASN khác AWS; muốn residential thật vẫn cần APK Urban VPN thả vào /home/boxes/.local/share/nodecode."
  :type :feedback)
