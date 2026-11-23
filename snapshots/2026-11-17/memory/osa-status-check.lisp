;;; osa-status-check — define-memory recorded by session s-GKPN8NDI, 2026-11-14T11:53:38Z
(in-package :nodecode.evolved)

;; refresh the status-check memory: the repo data dir is gone, children keep the env
(define-memory osa-status-check
  "Check the OSA fleet's real state on /home/boxes: user unit, the process's own OSA_DATA_DIR, GET /api/bootstrap, and a provider test — never a repo-local DB (there is none any more)."
  :type :lesson
  ;; why: <repo>/data used to shadow the real store and misled every status read; PR #95 removed its writers and the dir itself (2026-11-14).
  ;; 1. (osa-sc "status osa.service"); ss -ltnp | grep 8765 must show exactly one python on the user unit.
  ;; 2. sign in per osa-api-login (/proc/<pid>/environ OSA_PASSWORD, POST /login, keep the jar).
  ;; 3. there is no GET /api/bots (POST only): read bots, tasks and approvals from GET /api/bootstrap; tasks+approvals empty means idle.
  ;; 4. health: failures vs calls in llm_calls over 24h, task_steps status histogram, routine_runs, last message ts.
  ;; 5. prove the model path with POST /api/models/test {"provider","model","prompt"} — {"ok":true} means providers answer.
  ;; 6. logs at <OSA_DATA_DIR>/logs/osa.log; drop HTTP lines before reading errors.
  ;; 7. sqlite3 -readonly, and keep pipes INSIDE the (sh "...") string or the pipe reads as a |symbol|.
  ;; 8. a hand-run `python -c "import osa..."` in the repo still writes <repo>/data unless OSA_DATA_DIR is set — set it.
  )
