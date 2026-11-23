;;; nodecode-checkout-two-untracked-scratch — define-memory recorded by session experience-s-MJ1G3NHN-turn-1U7WR6X-DH95M9COTF, 2026-11-19T05:00:02Z
(in-package :nodecode.evolved)

(define-memory nodecode-checkout-two-untracked-scratch
  "In /home/boxes/nodecode two untracked paths are scratch, not source: demo/ (an edit-verb test file and a hand-drawn arch SVG) and tool-schema-report.md (a read-only survey of /home/boxes/osa) — never stage them with git add -A."
  :type :project
  ;; why: 2026-11-19 the operator asked what these two untracked entries were before deciding; both were left by earlier sessions, neither was ever committed on any ref (`git log --all -- demo tool-schema-report.md` is empty) and no source, doc or build file references them.
  ;; demo/ (8.5 KB, 2026-11-10 20:43): demo/t.txt holds 'dòng một / dòng hai — đã sửa bằng (edit ...)', a scratch file proving the edit verb; demo/kien-truc.svg is a 900x540 Vietnamese architecture diagram (EVAL / LAYER / CELLS / SHELL blocks).
  ;; tool-schema-report.md (3.1 KB, 32 lines, 2026-11-11 14:47): a read-only survey of OSA's tool-schema assembly — osa/registry.py:216 Tool.offered via `scope in self.where`, osa/router.py:547-551 _tools() vs osa/worker.py:493 — whose point is that router and worker get different lists. Its own first lines say it touched nothing under /home/boxes/osa, so it is OSA documentation parked in the nodecode checkout.
  )
