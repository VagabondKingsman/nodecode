;;; pool-many-free-accounts — define-skill recorded by session experience-s-YXFQ3K5L-turn-1U851Y8-GD48E9L3S5, 2026-11-23T16:34:59Z
(in-package :nodecode.evolved)

;; the pool procedure the next session will execute; it has not been run yet, and says so
(nodecode.evolved:define-skill pool-many-free-accounts
  "Turn the two-account free-key setup into a pool of N nodecode.ai free accounts that rotate by themselves when one runs out of its 10M tokens a day."
  ;; when the operator has more than two free keys to use in one home, or asks to add C, D, E…,
  ;; and the current setup is the two-slot one: free-route-a/b wrappers, an a/b map in
  ;; free-watch, two rungs in failover.chain.
  ;;
  ;; Evidence it rests on (2026-11-23): the per-call hook exists -- providers.<id>.api_key of
  ;; the form "!command" is run sh -lc on EVERY credential resolution, 10 s bound, never
  ;; memoized (provider.lisp:3893) -- so a router file decides the account per model call with
  ;; no restart and no lost session; a second provider id was accepted by the API in a real
  ;; turn; and demand was measured at 2.2 account-days a day, 6.9 at peak. NOT yet executed:
  ;; no pool has run, so treat every step as a plan to verify, not a receipt.
  ;;
  ;; 1. free-route migrate: rewrite ~/.nodecode/free-accounts.json from {a,b} to
  ;;    {"version":2,"policy":{...},"accounts":[{id,label,key,down_until,last_code,marked_at}]},
  ;;    keeping a .v1 backup; the two-slot router keeps working from the migrated file.
  ;; 2. Order accounts least-recently-served first, down-marked ones last by reset time; rung N
  ;;    (free-route --rung N) skips any account served in the last 60 s (free-route.log), so
  ;;    rung 2 does not repeat the account that just 429'd.
  ;; 3. free-rungs N writes wrappers free-route-1..N and patches config.jsonc: providers
  ;;    nodecode-free (rung 1, the id /models badges) plus nodecode-free-2..N, each with
  ;;    request_max_retries 0 and api_key "!.../free-route-k"; failover.chain = rungs then a
  ;;    paid provider as the last resort; back up and re-parse the config afterwards.
  ;; 4. Add keys with `free-route add < key` (stdin, never argv); never `nodecode login` on the
  ;;    live home, which overwrites both api_keys.nodecode and api_keys.nodecode-free.
  ;; 5. Generalise free-watch: provider id -> rung -> account via free-route.log, mark
  ;;    down_until with the "(at ... UTC)" reset from the turn.provider_retry/fallback detail,
  ;;    and clear a mark when a turn.usage for that account follows it.
  ;; 6. Accept only when: each rung prints a different key; a down-marked account is skipped
  ;;    by every rung; a real turn on the last rung answers; a garbage key fails over within
  ;;    the same turn; free-watch --dry-run writes nothing when nothing is down.
  ;;
  ;; Sizing: 3-4 accounts for a normal day, 7 for the worst measured (free-lane-demand-here).
  )
