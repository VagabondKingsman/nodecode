;;; osa-pr-to-i18n-vi — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7J0LY-XXOF6O7Q6B, 2026-11-11T18:59:01Z
(in-package :nodecode.evolved)

(define-memory osa-pr-to-i18n-vi
  "Opening a PR against open-super-agent-remake from this box: rebase first, run CI's own commands, push with the token in the URL, base i18n-vi; merges land by app/cursor, then the live tree follows origin/i18n-vi."
  :type :project
  :project "/home/boxes/osa"
  ;; Repo https://github.com/VagabondKingsman/open-super-agent-remake.git; the only shared branch is i18n-vi (no
  ;; "i18n" branch; the operator's "osar" means open-super-agent-remake). Work on a <bot>/<topic> branch.
  ;; The clone is shallow: compare with the pre-fetch tip (dac00da..887fd7d), not with "887fd7d~12".
  ;; Before pushing run CI's own steps: compileall + import osa.server, python -m osa.catalog / osa.templates /
  ;; osa.i18n / osa.skillpacks verify-sources, pytest -q, scripts/run_evals.py --base-ref i18n-vi, and in web/
  ;; npm test + npm run build. python -m osa.i18n exits 1 only on MISSING strings: add them to osa/locales and
  ;; web/src/locales with json.dump(ensure_ascii=False, indent=2) plus a trailing newline.
  ;; Push with the token in the URL, never in the remote: git push
  ;; "https://x-access-token:$(cat /home/boxes/.nodecode/gh-token)@github.com/VagabondKingsman/open-super-agent-remake.git" BRANCH:BRANCH
  ;; A commit made after git branch -f <pr-branch> HEAD lands on the checked-out branch, so the PR branch does not
  ;; move; re-run git branch -f and push again (that is what "Everything up-to-date" means).
  ;; Body follows .github/pull_request_template.md in Vietnamese; CHANGELOG.md has a Chinese [未发布] ### remake
  ;; section that takes one bullet per PR. CI: backend 5-12 min, frontend ~13 s, docker ~34 s.
  ;; Result 2026-11-11: #50 (54 commits) merged 16:09Z and #51 (3 commits) 16:16Z, both by app/cursor — automation
  ;; merges without a human click, so read gh pr view N --json state,mergedAt instead of waiting for a review.
  ;; 16 more commits landed within 2.5 h after, so a merged PR is not the end of the branch: fetch, then move the
  ;; live checkout to origin/i18n-vi (skill osa-serve-merged-branch; static/dist is gitignored so web/ must be rebuilt).
  )
