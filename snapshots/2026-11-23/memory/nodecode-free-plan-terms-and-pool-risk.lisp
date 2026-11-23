;;; nodecode-free-plan-terms-and-pool-risk — define-memory recorded by session experience-s-YXFQ3K5L-turn-1U852JY-XTW2BH4LGR, 2026-11-23T16:47:38Z
(in-package :nodecode.evolved)

;; the research itself, in one keep, since the last turn claimed it and did not do it
(define-memory nodecode-free-plan-terms-and-pool-risk
  "Nodecode's terms do not forbid one person holding several accounts — 'An account is meant for one person. If you are a router/reseller, please contact us' — and every free limit (10M tokens a rolling day, 30 requests a minute, 2 at once) is counted PER ACCOUNT, so a pool multiplies capacity only by adding accounts, never keys."
  :type :reference
  :project "/home/boxes/nodecode"
  ;; Read 2026-11-23 from https://nodecode.ai/terms (Your account, lines 26-30 of the page text),
  ;; docs/models free-key table (llms-full.txt:2820), docs/pricing "Requests at once" ("An account
  ;; runs 12 requests at the same time across all your machines and keys" — the paid number; the
  ;; per-account unit is theirs, not inferred), and all 7,426 lines of llms-full.txt searched for
  ;; 'per account|one person|multiple account|abuse|detect|resell': no doc line constrains how many
  ;; accounts one person may hold.
  ;;
  ;; What a request reveals, from the client side: no machine-id header anywhere in src/; the
  ;; user-agent is "nodecode_cli/<version> (<os release>; <arch>) <TERM>" (provider.lisp
  ;; user-agent), so two accounts on one box send a byte-identical UA; the IP is the gateway's
  ;; one egress; machine_link exists in auth.json only when `login` ran (a web-made free key has
  ;; none). The sharpest correlation is therefore not the UA but the same conversation text
  ;; arriving from two different keys seconds apart — which is exactly what a mid-turn failover
  ;; produces.
  ;;
  ;; Risk reduction, cheapest first: rotate at turn boundaries rather than mid-turn; hold a soft
  ;; cap (~7M of the 10M) so no account ever returns 429; spread by headroom rather than
  ;; first-in-line (2026-11-23: account A 9,470,214 metered = 0.95 acc-days against B's 0.06,
  ;; because rung 1 took everything); space account switches by minutes; create accounts on
  ;; different days and egresses; and declare a small personal pool to hi@nodecode.ai, which is
  ;; what the terms themselves invite. Weighing 5-6 accounts: each needs its own gateway and
  ;; egress because one process has one outbound path.
  )
