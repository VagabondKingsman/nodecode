;;; archive-branches-before-deleting — define-skill recorded by session experience-s-MJ1G3NHN-turn-1U7VRMZ-EHZNBRTWY2, 2026-11-18T16:13:59Z
(in-package :nodecode.evolved)

(define-skill archive-branches-before-deleting
  "Before deleting old local git branches, pin each one to a refs/archive/<UTC-stamp>/<branch> ref and read the refs back, so no unpushed commit is lost"
  ;; when to use: an operator says to delete unused/old local branches or clean up rác in a repo where a branch may still hold commits that never reached origin
  ;; step: from the default branch, count what each branch holds that origin does not - git rev-list --count origin/<default>..<branch>; a nonzero count means deletion loses work unless the branch is pinned
  ;; step: pin them all (cheap, covers the zero ones too): D=$(date -u +%Y%m%dT%H%M%SZ); for b in $(git for-each-ref --format='%(refname:short)' refs/heads/); do git update-ref refs/archive/$D/$b refs/heads/$b; done
  ;; step: only then delete - git branch -D each - and print the archive back: git for-each-ref --format='%(refname:short)' refs/archive/ | grep "/<branch>"
  ;; step: sweep what else pins commits - git worktree list, then git worktree remove --force <path> and git worktree prune for an orphan under /tmp
  ;; step: close on the state the operator cares about - git branch shows only the default, git status --porcelain empty, the service's PID and HTTP answer unchanged
  ;; evidence: 2026-11-18 in /home/boxes/osa, 54 local branches were deleted after pinning to refs/archive/20261118T161149Z; the three that held commits not on origin (fix/task-ids-own-space 4, selfbuild/repair-chain 1, tmp-parity 2) still resolved from the archive refs at seq 95776, while 47 unpinned siblings would have been gone for good
  ;; confidence: high - the refs were listed back after the delete in the same turn
  )
