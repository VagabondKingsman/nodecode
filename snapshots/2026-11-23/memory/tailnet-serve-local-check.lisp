;;; tailnet-serve-local-check — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7HQGV-40EUX3NO9H, 2026-11-11T02:20:16Z
(in-package :nodecode.evolved)

;; keep the local-check procedure and the speed-layer fact
(define-skill tailnet-serve-local-check "Kiểm tra một app sau `tailscale serve` ngay trên máy bằng curl, nhớ Host header."
  ;; when: verifying a tailscale-serve front for an app on the same box; a bare tailnet-IP curl answers 404 in under a millisecond and that 404 is tailscaled, not your app
  ;; steps
  ;; 1. lấy FQDN: tailscale status --json | grep -o '"DNSName":"[^"]*"', hoặc tailscale serve status — dòng "http://<node> (tailnet only)" là tên cần dùng
  ;; 2. curl -sS -D- -o /dev/null -H 'Host: <node>.<tailnet>.ts.net' http://100.x.y.z/<path>
  ;; 3. thiếu Host header thì tailscaled trả 404 Content-Length: 19 tức thì; có Host đúng thì mới thấy header thật của app (Cache-Control, Content-Encoding)
  ;; evidence: this turn — "HTTP/1.1 404 Not Found / Content-Length: 19" cho http://100.112.118.106/assets/index-D4uSUeuW.css, rồi "HTTP/1.1 200 OK ... Content-Encoding: gzip ... 16760" khi thêm -H "Host: osa.taila99125.ts.net"
  ;; confidence: high — nhân-quả rõ, cùng một URL, chỉ đổi một header
  )
