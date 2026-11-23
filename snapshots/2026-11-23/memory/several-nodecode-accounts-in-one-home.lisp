;;; several-nodecode-accounts-in-one-home — define-memory recorded by session experience-s-YXFQ3K5L-turn-1U84CYE-FVT16ZKIPO, 2026-11-23T07:34:10Z
(in-package :nodecode.evolved)

;; keep: one home can hold several nodecode.ai accounts, and how
(define-memory several-nodecode-accounts-in-one-home
  "nodecode has no accounts, only api_keys.<provider-id>.key, so a second nodecode.ai account is a second provider id pointed at the same base_url, switched by model choice or failover without touching the session."
  :type :reference
  :project "/home/boxes/nodecode"
  ;; Measured on 0.1.16+c78fef6, 2026-11-23. The three routes, best first:
  ;;   1. second provider: config.jsonc providers.<id> {sdk openai-completions, base_url
  ;;      https://api.nodecode.ai/v1} for both ids, each key in auth.json, and both in
  ;;      failover.chain with the same model — a used-up account hands the next turn to the
  ;;      other automatically. The session's log lives in history.db, not in a credential,
  ;;      so context is untouched.
  ;;   2. swap the key between turns: resolve-provider-credential runs inside the
  ;;      per-request path (src/engine/provider.lisp:3968 -> read-auth-file at 3924) with
  ;;      no cache, so /login in another window takes effect on the next model call.
  ;;   3. NOT profiles: `-p NAME' / `/profile use' is another home, and the switch execs a
  ;;      new process after the store is closed (src/cli/entry.lisp:233, "only then is this
  ;;      process replaced"), so the open session there must be resumed by id.
  ;; What /login writes, from src/tui/account-login.lisp:71,81: api_keys["nodecode"] and
  ;; api_keys["nodecode-free"] plus machine_link — it leaves other provider ids alone, so
  ;; copy the first account's key into a distinct id BEFORE logging in the second. logout
  ;; removes that home's key and link; the key still stands on the account until the
  ;; machine is removed at nodecode.ai/account/machines.
  ;; Free keys: a second free account buys quota only — the body stays one system + one
  ;; user, the CLI's own tool set at most, no WebSocket (nodecode-free-lane-is-one-prompt,
  ;; free-key-rejects-cell-tools). /v1/usage answers 200 on a free key, per key.
  )
