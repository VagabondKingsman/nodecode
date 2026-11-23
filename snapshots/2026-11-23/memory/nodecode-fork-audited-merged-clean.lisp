;;; nodecode-fork-audited-merged-clean — define-memory recorded by session s-MJ1G3NHN, 2026-11-19T04:57:27Z
(in-package :nodecode.evolved)

(define-memory nodecode-fork-audited-merged-clean
  "Fork VagabondKingsman/nodecode da duoc audit sach (2026-11-19): main = upstream/main + 9 commit tooling, khong free-lane, khong PR mo, khong nhanh rac, Actions tat."
  :type :project
  ;; main: 8d08e08 "boxes tooling on upstream/main, without the free-lane patch" (merge cua PR #8, parent 60db5cd = upstream/main). 17 files +681/-2. build `./nodecode --version` -> 0.1.16+8d08e08, `just lint` 328/328.
  ;; PRs: #8 MERGED; #1 #4 #5 #6 closed (moi commit cua chung da nam trong main — `git cherry origin/main <branch>` tra 0); #2 (frozen/2026-11-10) va #3 (snapshots/2026-11-17) closed vi la ARCHIVE, khong phai thay doi cho main. Con 0 PR mo.
  ;; branches: remote con main, image/freeze-2026-11-10, self-snapshot/2026-11-17 (hai cai sau la archive, moi cai 1 commit rieng). Da xoa box/clean-tooling, box/keep-awake, box/watchdog, cursor/boxes-nodecode-setup-c9d7, self-snapshot-base-upstream (remote) va box/clean, box/clean-tooling, box/keep-awake, box/watchdog, cursor/... (local).
  ;; secret scan (git log --all -p + git grep tren moi ref): chi 2 hit, ca hai la fixture co san trong upstream — test/organism/scribe-test.lisp chua chuoi sk-nc- mau (commit 4be1821) va test/engine/loopback-ca-key.pem la CA test (commit 178da27 'init'). Khong co auth.json, .env, credential nao tung vao git.
  ;; Actions: da TAT tren fork (`gh api -X PUT repos/.../actions/permissions -F enabled=false`) vi CI cua repo can self-hosted runner cua nodecode-ai, nen moi push chi sinh run treo; da cancel cac run queued/pending truoc do.
  ;; luu y: `gh api ... -f enabled=false` gui chuoi va 422; `-F enabled=false` moi gui boolean.
  )
