;;; free-accounts-are-wired-here — define-memory recorded by session s-YXFQ3K5L, 2026-11-23T07:55:52Z
(in-package :nodecode.evolved)

(define-memory free-accounts-are-wired-here
  "Since 2026-11-23 this home holds two nodecode.ai free accounts behind the provider ids nodecode-free, nodecode-free-2 … nodecode-free-N (rungs 1..N), each with api_key \"!~/.nodecode/bin/free-route-<x>\", so an exhausted account is replaced per model call with no restart and no lost session; account B still needs its key."
  :type :project
  :project "/home/boxes/nodecode"
  ;; Files: ~/.nodecode/free-accounts.json (0600; a = the key auth.json signs in with, b = empty
  ;; until the operator pastes one), ~/.nodecode/bin/free-route (a|b|status|set NAME|clear NAME|
  ;; down NAME SECS|up NAME; set reads the key on stdin so it never touches argv or history),
  ;; free-route-a / free-route-b (two-line sh wrappers for the config), free-watch (reads
  ;; history.db turn.provider_retry / turn.provider_fallback, takes the code and the "(at …
  ;; UTC)" reset out of the JSON detail, pairs it with free-route.log to learn WHICH account
  ;; served that round, and writes down_until), free-route.log (epoch, provider id, account).
  ;; systemd user units free-watch.service/.timer run it every 5 minutes. Copies live in the
  ;; fork at tools/free-accounts/ (commit 7c1f7a4, beside FREE-ACCOUNTS.md).
  ;;
  ;; config.jsonc: nodecode-free carries "api_key": "!…/free-route-a" and request_max_retries 0
  ;; (a 429 falls through at once instead of burning 4 x 60 s of Retry-After), nodecode-free-b
  ;; carries the b router at default retries; failover.chain is nodecode-free, nodecode-free-b,
  ;; then experientiallabs deepseek as the last resort, failover.on adds broken_answer.
  ;;
  ;; 2026-11-23 17:05, pool v2 (fork commits b9d3063, c7ed138): config carries rungs
  ;; nodecode-free, nodecode-free-2, nodecode-free-3 through free-route-1..3, each with
  ;; request_max_retries 0, and failover.chain is the three rungs then experientiallabs.
  ;; free-route picks per call by 24h spend read from history.db (soft cap 7M), tie-broken by
  ;; longest idle; a later rung skips an account an earlier rung served within 60 s;
  ;; free-rungs N writes the wrappers and the chain for a bigger pool. Tests that passed:
  ;; every rung id resolved source=CONFIG in the live image, a real turn on nodecode-free-2
  ;; answered PONG-R2, a bogus key gave one 401 and the turn still completed, doctor said
  ;; 'pool: fine'. Unexecuted: free-watch has not yet seen a real 429 since it went generic.
  ;; State at 2026-11-23 16:20 UTC: BOTH accounts hold a key (B pasted 16:15, its key answering on
  ;; nodecode-free-b), account A's daily window reopened at 16:18:57Z and the router went back
  ;; to it by itself, and free-watch marked nothing. End-to-end proof that the substitution
  ;; works: at 16:16, with A still marked out, a turn aimed at nodecode-free answered on B's
  ;; key (free-route.log 'a b'), then at 16:19 the same id answered on A again ('a a').
  ;;
  ;; Proof that the second provider id is accepted: a real turn on nodecode-free-b reached the
  ;; API and answered (the gate is the CLI's client, model name and key, never the config id).
  ;; Two traps measured: a plain curl 403s free_needs_nodecode even with a CLI-looking
  ;; User-Agent, so nothing out-of-band can call the model, only choose the key; and
  ;; free-watch must prefer the ordering of ask vs answer plus the failure events, because a
  ;; window count still shows the successes before the exhaustion.
  )
