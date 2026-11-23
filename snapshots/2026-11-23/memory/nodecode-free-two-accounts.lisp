;;; nodecode-free-two-accounts — define-memory recorded by session s-YXFQ3K5L, 2026-11-23T07:41:41Z
(in-package :nodecode.evolved)

(define-memory nodecode-free-two-accounts
  "A nodecode.ai free key is one account's free lane to Cyber v1 alone: 10M tokens in any 24 hours (3M for 14 days after the first card top-up), 30 requests a minute, 2 at once, and past the day it answers 429 free_daily_used with Retry-After -- so two accounts fit one home as two provider ids on https://api.nodecode.ai/v1 in failover.chain, and a !command api_key can pick the key per call."
  :type :reference
  :project "/home/boxes/nodecode"
  ;; Measured 2026-11-23 on 0.1.16+c78fef6, docs/models.mdx 'Free key' (lines 122-155) plus the code:
  ;;   free key needs a >=$2 top-up once; login saves TWO keys, api_keys.nodecode and
  ;;   api_keys.nodecode-free, writes providers.nodecode-free {sdk openai-completions, base_url
  ;;   https://api.nodecode.ai/v1}, makes free Cyber v1 the default, and stores machine_link.
  ;;   /logout forgets both keys and the link. A /login for another account OVERWRITES both
  ;;   entries (account-login.lisp:71,81), so a key you mean to keep must live elsewhere.
  ;;
  ;; Limits (docs/models.mdx table): model nodecode-cyber-v1 only (403 model_not_free); the
  ;; Nodecode CLI only (403 free_needs_nodecode -- a plain curl with a matching User-Agent still
  ;; 403s, so out-of-band inference is refused and only key CHOICE can be automated); 1M
  ;; context; 2 at once; 10M tokens/rolling 24h (3M for 14 days after the first card top-up),
  ;; past it 429 free_daily_used + Retry-After saying when the account may send again; 30
  ;; requests/minute, past it 429 free_rate_limited + Retry-After; 503 free_capacity_busy after
  ;; 30 s when paid calls have the machines.
  ;;
  ;; What the code does with that: retry delay is min(Retry-After, 60) (provider.lisp:2513), and
  ;; *max-request-retries* is 4 unless providers.<id>.request_max_retries says otherwise
  ;; (3983) -- so an exhausted account can burn up to ~4 minutes before the chain moves.
  ;; Failover triggers (4057): 429 -> rate_limit, everything else -> outage, so a 402/403/503
  ;; also walks the chain when 'on' names those. Config is memoized on (path,size,mtime)
  ;; (read-shared-config, 2546), so failover.chain/on edits are live; auth.json is re-read at
  ;; every credential resolution (3924) and a providers.<id>.api_key of the form "!command" is
  ;; run sh -lc on EVERY resolution, bounded 10 s, never memoized (runner at 3893-3918) -- the
  ;; hook a quota-aware key router rides, with no restart and no in-image code.
  ;;
  ;; Design that follows: providers nodecode-free (account A) and nodecode-free-b (account B),
  ;; both base_url https://api.nodecode.ai/v1, each api_key "!~/.nodecode/bin/free-route-a|b";
  ;; request_max_retries 0 on A so a 429 falls through at once, default on B as the last
  ;; resort; failover.chain [[A,nodecode-cyber-v1],[B,nodecode-cyber-v1]] with on rate_limit,
  ;; outage, slow_start, broken_answer. The router reads ~/.nodecode/free-accounts.json (0600)
  ;; and a down-marker per account; a cron cell flips the marker when history.db shows a
  ;; provider-fallback off that provider, and clears it after the Retry-After or a day.
  ;; /v1/usage answers for a free key but carries no daily-token counter (plan null, pays
  ;; "free"), so the 429 itself is the only honest signal.
  )
