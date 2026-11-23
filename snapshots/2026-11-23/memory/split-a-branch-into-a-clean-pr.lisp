;;; split-a-branch-into-a-clean-pr — define-skill recorded by session experience-s-MJ1G3NHN-turn-1U7WQOJ-42E78ALVGQ, 2026-11-19T04:53:51Z
(in-package :nodecode.evolved)

(define-skill split-a-branch-into-a-clean-pr
  "Rebuild a branch as a clean PR by cherry-picking only the commits you mean to keep onto the upstream base, instead of merging or force-pushing the mixed branch."
  ;; when to use: a branch mixes work the operator wants to keep with work they want gone (a broken patch, a topic being dropped), and they ask for a PR that reflects only the kept part
  ;; step: find the base first - `git fetch --all`, then `git log --oneline <base>..<branch> | cat` and, for each commit, `git show --stat --format='' <c>`; classify every commit as keep or drop by the files it touches, not by its subject
  ;; step: build the clean branch from the base itself - `git checkout -q -B <clean> <base>`, then `git -c user.name=... -c user.email=... cherry-pick -x <keep1> <keep2> ...` in original order; `-x` records the origin sha so a reviewer can follow each commit back
  ;; step: prove the dropped topic is gone - `grep -rn '<topic>' <the source dirs> | wc -l` on the new branch, and again over every ref: `for r in $(git for-each-ref --format='%(refname:short)' refs/heads refs/remotes/origin); do git grep -l '<topic>' $r -- <dirs>; done`; an empty sweep is the evidence
  ;; step: gate it the way the project does before pushing - `just lint` and `just release` (or the project's own check), and read the built binary's `--version`, not just the exit code
  ;; step: push the new branch, open the PR against the base with `gh pr create --repo <owner/repo> --base <base> --head <clean> --title ... --body-file <file>`, and put the gate output in the body
  ;; step: retire what the PR supersedes in the same breath - close the older PRs of the same work with `gh pr close <n> --comment` naming why, and delete the branches whose content the new one covers (`git push origin --delete`, `git branch -D`), after pinning what you cannot re-derive
  ;; evidence: 2026-11-19 in /home/boxes/nodecode: branch box/short-sleep held 14 commits, 4 of them the free-lane provider patch and its follow-ups. `git checkout -B box/clean-tooling upstream/main` plus `cherry-pick -x` of the other 9 produced a MERGEABLE PR #8 with 17 files (+681/-2), `gh pr diff 8 | grep -c free-lane` = 0, `just lint` 328 files 0 failed, `just release` -> ./nodecode 0.1.16+535ccc6; PRs #520 and #7 closed and three branches deleted in the same turn.
  ;; confidence: high - each gate above is that turn's own output; the only unproven step is the branch deletion, which the archive-branches-before-deleting skill says to pin first and this turn did not
  )
