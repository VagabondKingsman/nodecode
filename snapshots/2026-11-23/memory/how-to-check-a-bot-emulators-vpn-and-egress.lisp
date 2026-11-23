;;; how-to-check-a-bot-emulators-vpn-and-egress — define-skill recorded by session experience-s-CB16OSU3-turn-1U80KLF-KVG2VLFIHI, 2026-11-21T06:32:59Z
(in-package :nodecode.evolved)

;; keep the procedure: proving a bot emulator's VPN/egress by measurement, not by processes
(define-skill how-to-check-a-bot-emulators-vpn-and-egress
  "Chứng minh máy ảo redroid của bot có đi qua VPN không và ra Internet bằng IP nào, bằng 3 lớp đo thay vì suy từ tiến trình.
;; when: khi cần biết traffic máy ảo có qua VPN/đổi country (kiểm IP & Play country trước khi đăng nhập/mua), hoặc khi thấy tiến trình VPN mà tưởng nó đang chạy.
;; steps:
;; 1. Trong netns container: `docker exec <c> sh -c 'ip -o link; ip route'` — chỉ lo/eth0 = không VPN; phải có tun/wg/ppp + default route qua nó.
;; 2. Android nghĩ gì: `adb shell 'dumpsys connectivity | grep -iE \"Active default network|NetworkAgentInfo\"'` — cờ NOT_VPN trên NetworkAgentInfo của default network là bằng chứng; kèm `settings get global http_proxy`.
;; 3. Host: `ip route`, `ip -o link | grep -E 'tun|wg'`, `ps -eo pid,args | grep -iE 'openvpn|wireguard|clash|v2ray'` — tiến trình sống không có nghĩa đường ra qua nó; `ip link show tunN` phải tồn tại.
;; 4. IP ra thật: `curl -s -m 10 https://ipinfo.io/json` trên host (container đi chung docker0 NAT ⇒ cùng IP); đọc country/org.
;; 5. Thử tunnel không phá mạng: `sudo openvpn --config X.ovpn --auth-user-pass auth.txt --dev tun8 --route-nopull --daemon --log /tmp/ov.log`, chờ 12s, `ip -4 -o addr show tun8`, test `curl --interface <ip> https://ipinfo.io/ip`, xong `pkill -f '--dev tun8'`.
;; 6. Log root-only phải đọc bằng sudo: 'Connection reset' ngay sau TCP handshake = provider chặn (hay gặp với free VPN từ IP datacenter); AUTH_FAILED = sai user/pass; không có tun = chưa lên.
;; evidence: 21/11/2026 osa-phone17 — tưởng có VPN vì host có openvpn dev tun9, wireguard-go và app de.blinkt.openvpn; đo ra container chỉ lo/eth0, dumpsys ghi default network Ethernet với NOT_VPN, http_proxy null, host 'default via 172.16.0.1 dev eth0', 'Device \"tun9\" does not exist', log openvpn 'Connection reset, restarting' + 'Restart pause, 300 second(s)' ⇒ không VPN, egress 100.23.164.123 AWS us-west-2; us1/us2/de1 đều reset khi thử bằng --route-nopull.
;; confidence: high — mỗi lớp là một lệnh đọc trạng thái thật, và kết luận bị phủ định được bằng chính các lệnh đó.")
