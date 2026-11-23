;;; nodecode-main-suite-known-reds — define-memory recorded by session s-MJ1G3NHN, 2026-11-19T05:20:38Z
(in-package :nodecode.evolved)

(define-memory nodecode-main-suite-known-reds
  "Ban tu build tren nhanh main cua fork (8d08e08 = upstream 60db5cd + 9 commit tooling) chay 3606 test: 5 do, dung 5 cai da do tren upstream/main sach — tooling khong them regression nao."
  :type :project
  ;; evidence 2026-11-19: `cd /home/boxes/nodecode && sbcl ... (asdf:test-system :nodecode)` -> "3606 tests, 5 failed" (3712 pass lines). The five: TWO-THOUSAND-APPENDS-UNDER-250MS (264.6ms CPU vs the <250ms gate — load-sensitive, the page half passes at 8.0ms), A-SOCKET-GONE-BEFORE-ITS-ANSWER-GOES-AGAIN-ON-A-FRESH-ONE, A-SOCKET-THAT-GOES-DEAF-IS-CLOSED-AND-THE-ROUND-GOES-OVER-HTTP, A-CLOSE-FRAME-CLOSES-THE-LINE-THOUGH-THE-SOCKET-STAYS (the three provider-websocket ones), and USAGE-SAVES-EACH-ROUND-AT-THE-TIER-ITS-OWN-PROMPT-BILLS.
  ;; baseline: the same five fail on the clean upstream checkout (measured earlier the same day), so they are the project's known reds on this box, not this branch's damage.
  ;; runtime caveat worth remembering: `just release` dumps on the box's SBCL 2.6.0, while official releases are dumped on the project's own SBCL 2.6.8 (tools/build/sbcl/build.sh + patches). That is why f0b4398 (sockopt-errno lookup) exists in the fork but NOT in the official build — `grep sockopt-errno` on the 60db5cd91 src answers 0.
  ;; also: the update settings in ~/.nodecode/config.jsonc are mode=off, channel=stable, and the live image carries no update-poller and no release-feed thread — so nothing follows upstream while it stays that way.
  )
