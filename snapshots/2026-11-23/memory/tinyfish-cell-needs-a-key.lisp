;;; tinyfish-cell-needs-a-key — define-memory recorded by session s-YXFQ3K5L, 2026-11-23T06:10:53Z
(in-package :nodecode.evolved)

;; record what a next session must not re-derive about tinyfish
(define-memory tinyfish-cell-needs-a-key
    "The tinyfish cell is installed and loaded on this home, but every verb refuses until a TinyFish API key is set; the key is account-bound and must come from the operator."
  :type :project
  ;; Installed 2026-11-23 from hub pin 260b9a6 (nodecode add nc://tinyfish --yes); cell state LOADED.
  ;; It gives five tools - tinyfish_search, tinyfish_fetch, tinyfish_agent, list/create_profile -
  ;; and Lisp verbs: (tinyfish:search-text QUERY &optional LIMIT) - positional, :limit is refused -,
  ;; (tinyfish:fetch-text URLS FORMAT), (tinyfish:agent-text URL GOAL), (tinyfish:profiles-text),
  ;; (tinyfish:status-text) for the key/hosts report. run-command takes (ARGS SESSION-ID).
  ;; Key goes to config tinyfish.api_key - (config-set '("tinyfish" "api_key") "tf-...") - or
  ;; TINYFISH_API_KEY. Free at https://agent.tinyfish.ai/api-keys; search and fetch are free,
  ;; only tinyfish_agent spends credits. No key exists anywhere on the box (grepped 2026-11-23).
  ;; The sign-in is Clerk and offers AgentID/GitHub/Google/Microsoft/X; the Google path landed on
  ;; accounts.google.com's identifier page, so the operator's Chrome has no Google session there -
  ;; they must sign in themselves or paste the key.
  :sources ("session" "this box")
  :origin "world")
