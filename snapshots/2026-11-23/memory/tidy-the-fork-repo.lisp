;;; tidy-the-fork-repo — define-skill recorded by session experience-s-YXFQ3K5L-turn-1U84AHK-4YTRAPTP7E, 2026-11-23T06:42:32Z
(in-package :nodecode.evolved)

;; keep the procedure that worked: tidy a fork by merging archives and pruning the rest
(nodecode.evolved:define-skill tidy-the-fork-repo
  "Make a fork's branch list mean something: merge what belongs on main, keep side work as its own branch, delete the rest, and prove the merge touched nothing else."
  ;; when: an operator asks to clean, merge or "push everything" to their own fork and
  ;; wants no branch left hanging; distinct from opening a review PR, which is a branch.
  ;; steps:
  ;; 1. Inventory both ends before touching anything: `git ls-remote --heads origin`
  ;;    for what really exists, `git for-each-ref refs/remotes` for stale refs, and
  ;;    the API for PRs (`pulls?state=open`, and search by author for the upstream
  ;;    repo). Closed PRs whose commits are in main are history, not work.
  ;; 2. Fetch --prune in every clone involved; a tracking ref of a deleted branch
  ;;    otherwise masquerades as a live one.
  ;; 3. Decide each branch by content, not by name: `git cherry origin/main <branch>`
  ;;    lists commits not upstream (a bare 0 means merged), and `git diff --stat
  ;;    <branch> main` shows whether it is an archive (adds files) or a divergent tree.
  ;;    Archives merge into main; side work that main must not carry stays a branch;
  ;;    a whole exported tree stays a branch, because merging it is noise.
  ;; 4. Merge with `--no-ff` so the archive keeps its own commit. Conflicts in shared
  ;;    tooling files resolve to main's side when main is the copy that runs.
  ;; 5. Prove the merge was additive: `git diff --name-status <old> main | grep -vc
  ;;    '^A\tsnapshots/'` must answer 0 — a receipt is not proof, a diff is.
  ;; 6. Push main, delete the merged branches (`git push origin --delete`, then
  ;;    `git branch -D`), `git fetch --prune`, and read `git ls-remote --heads origin`
  ;;    again for the final list. Confirm CI is off if the repo's Actions need their
  ;;    own runner, so no push leaves a queue hanging.
  ;; evidence: 2026-11-23 on VagabondKingsman/nodecode — main went 8d08e08 -> c78fef6
  ;; (13 upstream merges) -> 01cdc70 (+ snapshots/2026-11-17, + snapshots/2026-11-23),
  ;; ending with heads main, box/free-lane, image/freeze-2026-11-10 and 0 open PRs.
  ;; Step 5 is what made the merge safe to call done; before it, the two conflicts
  ;; (tools/boxes/README.md add/add, src/term/program.lisp docstring) looked like
  ;; source changes that weren't meant to be there at all.
  ;; confidence: high — every step ran and its answer is quoted in the same turn.
  )
