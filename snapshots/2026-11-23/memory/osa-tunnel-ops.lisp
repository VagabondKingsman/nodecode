;;; osa-tunnel-ops — define-memory recorded by session s-1CKKCZWG, 2026-11-11T01:06:23Z
(in-package :nodecode.evolved)

(define-memory osa-tunnel-ops
    #>END
OSA tunnel: cloudflare quick tunnel (cloudflared --url http://127.0.0.1:8765), quick tunnel ĐỔI URL mỗi lần restart. Vận hành bằng ~/osa/scripts/tunnel.sh (url | ensure | restart); URL hiện tại: ~/osa-data/public-url.txt và ~/osa-data/logs/tunnel.log; helper trong image: (osa-url), (osa-tunnel-ensure). Heartbeat "osa-tunnel-public-url" chạy ensure mỗi 3m, fire-on change → tự restart + báo URL mới. Lỗi hay gặp: log ERR "failed to accept QUIC stream: no recent network activity" rồi tự reconnect ~2s (browser thấy 1033/530) — chỉ cần refresh; nếu process chết thì ensure lo. Named tunnel (URL cố định) cần domain trên Cloudflare, ~/.cloudflared chưa có.
END
    :type :project :project "/home/boxes")
