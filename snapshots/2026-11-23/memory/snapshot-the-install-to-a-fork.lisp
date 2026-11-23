;;; snapshot-the-install-to-a-fork — define-memory recorded by session s-YXFQ3K5L, 2026-11-23T06:36:24Z
(in-package :nodecode.evolved)

(define-memory snapshot-the-install-to-a-fork
  "This home's install, config and working memory (memories + skills) go to the operator's own fork as a readable text snapshot: snapshots/<date>/ on branch self-snapshot/<date> in /home/boxes/nodecode, which IS the fork (origin VagabondKingsman/nodecode, upstream nodecode-ai/nodecode)."
  :type :project
  :project "/home/boxes/nodecode"
  ;; /home/boxes/nodecode-upstream is a second clone whose remote 'fork' points back at
  ;; /home/boxes/nodecode. The older snapshot is snapshots/2026-11-17 (commit 6654568).
  ;;
  ;; What a snapshot holds, measured on 2026-11-23: memory/ = every .lisp of the knowledge
  ;; cells (antigravity, cursor-agent-memory, nodecode-experience, nodecode) verbatim, 428
  ;; files of which 229 are skills, a name collision prefixed with its cell name;
  ;; memory-cell.asd (the (:knowledge . t) layer); cells.txt = "cell: NAME" per directory
  ;; in ~/.nodecode/cells (36 that day); config.redacted.jsonc = ~/.nodecode/config.jsonc
  ;; with key/token/secret values masked but paths kept; version.txt; taken-at.txt;
  ;; manifest.md with counts and the source commit; README.md in Vietnamese.
  ;;
  ;; What stays behind, on purpose: auth.json, secrets/, gh-token, operator-token,
  ;; history.db, binary snapshots, generations, chrome-profile, and hub cell sources
  ;; (cells.txt reinstalls those). Nothing here is secret, which is the whole point:
  ;; "nodecode snapshot" images are 20-120 MB and carry values.
  ;;
  ;; How, without escaping games: a python script writes the directory into the working
  ;; tree of /home/boxes/nodecode, then
  ;;   git checkout -b self-snapshot/DATE        (from main, which must be clean)
  ;;   git add snapshots/DATE; git -c core.hooksPath=/dev/null commit -m 'snapshots: …'
  ;;   git merge --no-ff self-snapshot/DATE; git push origin main
  ;;   git push origin --delete self-snapshot/DATE; git branch -D self-snapshot/DATE
  ;; On 2026-11-23 the operator asked for merge and clean: main now carries
  ;; snapshots/2026-11-17 and snapshots/2026-11-23 (01cdc70, fast no-op on src —
  ;; `git diff --name-status c78fef6 main | grep -vc '^A\tsnapshots/'` answers 0)
  ;; and both archive branches were deleted, so a snapshot lands on main and its
  ;; branch retires. Merging 2026-11-17 needed two conflict resolutions, both
  ;; 'ours': tools/boxes/README.md (add/add) and src/term/program.lisp, where the
  ;; archive still had the unescaped %defer docstring and main the escaped fix.
  ;;   git checkout main                          (a build must never happen on it)
  ;; Pushing main too is what carries the install's own commits (2026-11-23: 13 upstream
  ;; merges, 8d08e08..c78fef6). Auth is the credential helper reading ~/.nodecode/gh-token
  ;; (devbox-github-git-wiring)); the only noise is an ignored, non-executable
  ;; /home/ubuntu/.cursor hook, which -c core.hooksPath=/dev/null silences.
  )
