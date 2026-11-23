;;; devbox-github-git-wiring — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7IQPC-BFLMLSLXWL, 2026-11-11T15:24:07Z
(in-package :nodecode.evolved)

;; keep what the next session would otherwise rediscover: the devbox git wiring
(define-memory devbox-github-git-wiring
  "On this devbox a github push goes through a credential helper that reads ~/.nodecode/gh-token; the boxes integration's url.*.insteadOf rewrite and its helper are the two things that break, and both are refreshed only by reconnecting GitHub in Integrations."
  :type :project
  :project "/home/boxes/nodecode"
  ;; Measured 2026-11-11 15:23. `git push` said "remote: Invalid username or token. Password authentication is not
  ;; supported" while the token itself was fine: curl -u x-access-token:<token> on .../info/refs?service=git-receive-pack
  ;; answered 200 and `gh api user` answered VagabondKingsman. Two causes, both of the devbox, neither of the repo:
  ;;   1. ~/.gitconfig had [url "https://x-access-token:ghs_…@github.com/"] with six insteadOf values, so every https
  ;;      github URL became a URL carrying a GitHub App installation token that lives one hour (ghs_, exp inside its JWT).
  ;;      `git remote -v` prints the rewritten URL, which makes a plain `git remote set-url` look ignored.
  ;;   2. ~/.config/boxes/github-project-git.conf registers /opt/devbox-tools/bin/boxes-github-credential, which answered
  ;;      "GitHub access is temporarily unavailable; try again later" with quit=1 — the integration itself is disconnected.
  ;; What works now: the [url] block is gone (backup at ~/.gitconfig.bak-20261111) and the credential chain is
  ;;   git config --global --add credential.https://github.com.helper ''   # the empty entry resets inherited helpers
  ;;   git config --global --add credential.https://github.com.helper '!f() { echo username=x-access-token; echo password=$(cat /home/boxes/.nodecode/gh-token); }; f'
  ;; so rotating the token is one write to that file (0600) and no URL changes. The token in it is a gho_ from
  ;; `gh auth login` (client id 178c6fc778ccc68e1d6a, scopes gist, read:org, repo, workflow, no expiry header).
  ;; Re-checked 15:26 the same day, when the operator asked whether a new token was due: repo permissions read back as
  ;; admin/maintain/pull/push/triage and the rate limit was 4,983/5,000 — so no rotation is due. The only reasons to
  ;; mint another: a revoke, or deliberately narrowing to a fine-grained PAT (Contents RW, Pull requests RW, Metadata
  ;; R). Whatever token it holds, every push and PR is attributed to VagabondKingsman, never to a separate bot.
  )
