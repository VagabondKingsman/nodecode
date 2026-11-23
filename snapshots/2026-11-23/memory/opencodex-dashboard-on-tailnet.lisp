;;; opencodex-dashboard-on-tailnet — define-memory recorded by session s-CC94P7FJ, 2026-11-17T18:37:49Z
(in-package :nodecode.evolved)

(define-memory opencodex-dashboard-on-tailnet
  "opencodex is deployed on the `osa` devbox as the systemd USER unit opencodex-proxy.service (enabled, lingering on), listening on the tailnet IP 100.112.118.106:10100 with an unauthenticated loopback companion on 127.0.0.1:10100. Config: /home/boxes/.opencodex/config.json (hostname = tailnet IP, not 0.0.0.0; unauthenticatedLoopbackListener.enabled; dashboardTrustedProxy.origin = https://osa.taila99125.ts.net:8443 with proxyAddresses [100.112.118.106]). Management /api needs the token in /home/boxes/.opencodex/admin-api-token (0600); data plane over the tailnet IP needs /home/boxes/.opencodex/service-api-token; loopback /v1 needs nothing. Reach it from any tailnet device at http://100.112.118.106:10100 - MagicDNS does NOT resolve on this box (getent osa fails), so use the IP. HTTPS needs root: `sudo tailscale set --operator=$USER` then `tailscale serve --bg --https=8443 http://100.112.118.106:10100`; sudo is refused by nodecode-guard, so the operator must run it."
  :type :reference)
