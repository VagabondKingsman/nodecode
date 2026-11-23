;;; osa-tailscale — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7HNFF-7Z59DP4H2H, 2026-11-11T01:15:00Z
(in-package :nodecode.evolved)

(define-memory osa-tailscale "OSA nên vào qua tailnet riêng (không Funnel): binary ~/.local/tailscale/{tailscaled,tailscale} chạy userspace --tun=userspace-networking, socket ~/.tailscale/tailscaled.sock, state ~/.tailscale/tailscaled.state, hostname 'osa', script ~/osa/scripts/tailscale-up.sh (--status | --funnel | tskey-auth-…), key ở TS_AUTHKEY trong ~/osa/.env; URL vào OSA ghi ở ~/osa-data/public-url.txt." :type :project :project "/home/boxes")
