;;; blame-a-red-suite-on-the-clean-base — define-skill recorded by session experience-s-MJ1G3NHN-turn-1U7W14I-3U6EPF5ZRO, 2026-11-18T19:39:38Z
(in-package :nodecode.evolved)

(define-skill blame-a-red-suite-on-the-clean-base
  "A suite's red belongs to your change only if the same tests are green on the base commit: run them there before saying so."
  ;; when to use — a test suite run on your branch, or on a merged tree, comes back with failures and you must say whether the change caused them, or hand the branch over as green-modulo-pre-existing.
  ;; 1. Pin the base in its own worktree: `git worktree prune` first (a registered-but-deleted path fails with 'missing but already registered'), then `git worktree add -f /tmp/base <base-ref>`.
  ;; 2. Run a named slice from any checkout with one script: `NC_DIR=/tmp/base sbcl --non-interactive --load runner.lisp`, where the script pushes `(pathname (concatenate 'string (sb-ext:posix-getenv \"NC_DIR\") \"/\"))` onto `asdf:*central-registry*`, loads `:nodecode/test`, keeps the `*tests*` entries whose names come from the red log, and calls `run-suite` — which prints `N tests, M failed`.
  ;; 3. Take the names from `grep '^FAIL ' log`, run that same list against the base worktree, and compare the two sets: identical names mean pre-existing, and the PR body then names the base commit and the five (or however many) failing tests.
  ;; 4. A timing gate — a name like `*-UNDER-*MS` over a CPU or wall budget — is load-sensitive: run it alone on an idle machine, never beside a suite still compiling in another worktree.
  ;; 5. Land it as a PR: push the branch, `gh pr create --fill`, then read it back with `gh pr view --json state,mergeable,changedFiles`; `--fill` gives a skeletal body, so a real body goes in with `--body-file` written by `write-file`, not typed inside a shell string.
  ;; evidence — the merged tree ran 3727 pass / 5 fail and the clean `upstream/main` worktree at 60db5cd ran the same five names ("5 tests, 5 failed") with none of our commits applied, which is what made them safe to call pre-existing in PR #520.
  ;; confidence — high: the comparison reproduced exactly in both trees, and the same five reds had first looked like our regression.
  )
