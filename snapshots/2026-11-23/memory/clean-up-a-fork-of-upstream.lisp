;;; clean-up-a-fork-of-upstream — define-skill recorded by session experience-s-MJ1G3NHN-turn-1U7WQXA-SPTB6831UK, 2026-11-19T04:58:46Z
(in-package :nodecode.evolved)

(define-skill clean-up-a-fork-of-upstream
  "Audit and clean a fork of an upstream repo: merge the one branch that is upstream plus the wanted work, close the other PRs by evidence, and prune so only main and real archives remain."
  ;; when to use: an operator says to audit/clean a fork — close or merge its open PRs, delete stale branches, make sure an experimental or rejected feature is gone — especially right after dropping a patch that broke something.
  ;; step: git fetch --all --prune, then for every remote head print ahead/behind against upstream/<default> (git rev-list --count) and grep it for the dropped feature (git grep -l '<feature>' <ref> -- src test); that list is the work plan.
  ;; step: decide each open PR by content, never by title: git cherry origin/main <branch> | grep -c '^+' answering 0 means every patch is already in main, so close it as superseded; a branch that only adds a snapshot/ or frozen/ folder is an archive, so close its PR and keep the branch.
  ;; step: land the wanted work on its own branch based on upstream/main (git checkout -B <b> upstream/main; git cherry-pick -x <commits...>), never by merging an old long-lived branch; re-run the repo's own gates (just lint, just release) on that branch before opening the PR, then gh pr merge.
  ;; step: after the merge, delete every remote branch whose git cherry count is 0 and their local twins, pinning them first if any commit might be unique (refs/archive/<stamp>/<branch>, see archive-branches-before-deleting); confirm with git ls-remote --heads and git branch -vv.
  ;; step: a fork's CI runs on the parent repo's self-hosted runners, so its runs queue forever — gh run cancel each queued/pending one, then gh api -X PUT repos/OWNER/REPO/actions/permissions -F enabled=false; -f enabled=false sends the string \"false\" and answers 422.
  ;; step: scan the whole history, not just the tree (git log --all -p | grep -E 'sk-|gho_|ghp_|PRIVATE KEY'), and clear every hit by proving the same string is already in upstream (git log upstream/main -S'<string>') rather than assuming it is a fixture.
  ;; evidence: 2026-11-19 on VagabondKingsman/nodecode, git cherry answered 0 for box/keep-awake and four siblings, so PRs #1 #4 #5 #6 were closed as superseded and #2/#3 as archives; PR #8 (upstream/main + 9 cherry-picked tooling commits) merged to 8d08e08 with just lint 328/328 and ./nodecode 0.1.16+8d08e08; the only history hits were 4be1821's sample key in test/organism/scribe-test.lisp and 178da27's test CA, both in upstream; -f enabled=false returned 422 \"not a boolean\" where -F read back {\"enabled\":false}.
  ;; confidence: high — each step was read back in the same turn (main head, lint count, branch list, permissions), not inferred from an exit code.
  )
