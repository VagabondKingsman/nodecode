;;; checkout-cleanup-demo-and-osa-report — define-memory recorded by session s-MJ1G3NHN, 2026-11-19T05:03:00Z
(in-package :nodecode.evolved)

(define-memory checkout-cleanup-demo-and-osa-report
  "/home/boxes/nodecode sach: thu muc demo/ (nhap thu verb edit + so do kien truc) da xoa, va tool-schema-report.md (khao sat ve OSA) da chuyen sang /home/boxes/osa/worklog/."
  :type :project
  ;; why: 2026-11-19 the two untracked items were audited and neither belonged to the nodecode repo — demo/ was scratch from this box's first session (2026-11-10, never committed, nothing referenced it), and the report is a read-only survey of /home/boxes/osa's tool-schema assembly (router._tools at router.py:547-551 vs worker.py:493, filtered by registry.py:216 Tool.offered's `scope in self.where`).
  ;; how: `rm -rf /home/boxes/nodecode/demo`; `mv tool-schema-report.md /home/boxes/osa/worklog/`, and `worklog/` appended to /home/boxes/osa/.git/info/exclude (LOCAL only — the tracked .gitignore was not edited), so `git status` in osa stays clean and nothing is pushed.
  ;; both checkouts now report an empty `git status --short`; the fork stays at main 8d08e08 with only main + the two archive branches.
  )
