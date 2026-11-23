;;; grow-the-free-key-pool — define-skill recorded by session experience-s-YXFQ3K5L-turn-1U8534D-YFUWZ3MXX, 2026-11-23T17:10:44Z
(in-package :nodecode.evolved)

;; the same, with the name unqualified
(nodecode.evolved:define-skill grow-the-free-key-pool
  "Add a nodecode.ai free account to this home's pool and prove it serves turns, without touching the running gateway."
  ;; when the operator brings another free account's key (a spare account, a new box), and the pool on this home must take it — the shape is: a key in hand, a pool file, a config that names rungs.
  ;; 1. ~/.nodecode/bin/free-route status — read the pool first; never assume two ids.
  ;; 2. Put the key in without argv or history: write it to a 0600 temp file, then
  ;;    ~/.nodecode/bin/free-route add c < /tmp/c.key ; shred -u /tmp/c.key.
  ;;    (`rotate c` replaces one, `remove c` takes it out; `export PATH`/`import PATH --yes` move a pool.)
  ;; 3. ~/.nodecode/bin/free-rungs N with N the pool size (or the chain length you want): it writes
  ;;    free-route-1..N, rewrites config.jsonc (backup beside it) so each rung names its wrapper with
  ;;    request_max_retries 0, and reorders failover.chain to the rungs, then the non-free providers.
  ;; 4. Prove it without restarting anything: free-route doctor must say 'pool: fine'; then one cheap
  ;;    real turn on the new rung — nodecode --model nodecode-free-3/nodecode-cyber-v1 -- '<prompt>' —
  ;;    must answer. A 429 there means that account's day is gone.
  ;; 5. Never claim a pool works from the file alone: the free gate refuses every non-CLI client
  ;;    (403 free_needs_nodecode), so history.db and a real turn are the only evidence.
  ;; evidence (2026-11-23): the v2 build passed exactly these — doctor 'pool: fine', a turn on nodecode-free-2 answering PONG-R2, a bogus key failing over inside one turn — after free-rungs wrote the config while the gateway kept running.
  ;; confidence: high for a two-account home; the rung-skip rule is untested past two accounts.
  )
