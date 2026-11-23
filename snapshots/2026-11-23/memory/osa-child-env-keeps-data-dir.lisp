;;; osa-child-env-keeps-data-dir — define-memory recorded by session s-GKPN8NDI, 2026-11-14T11:53:38Z
(in-package :nodecode.evolved)

;; keep the finding: children must keep OSA_DATA_DIR, and what that cost
(define-memory osa-child-env-keeps-data-dir
  "In /home/boxes/osa a child process (terminal, chrome, sandbox) and every test must inherit OSA_DATA_DIR, or `import osa` lands in a second data dir inside the repo."
  :type :lesson
  ;; why: 2026-11-14 host._env() stripped every ^OSA_ name, so bots' shells resolved DATA to <repo>/data — a stale 1-bot DB was what agents read, and the test suite grew the same dir. Found and fixed in PR #95 (fix/child-env-data-dir, CI green): KEEP_FOR_CHILD keeps OSA_DATA_DIR, conftest points it at the temp dir, and the stale dir was deleted after its 5 unique skill packs were copied into the live data dir.
  ;; reproduce: rm -rf data && OSA_DATA_DIR=/home/boxes/osa-data python -c "import asyncio;from osa import sandbox;print(asyncio.run(sandbox.execute('python',\"import os;print(os.environ.get('OSA_DATA_DIR'))\",net=False,computer=False)).text)"
  ;; rule: a path under a secret filter is not a secret; a new osa child env builder keeps OSA_DATA_DIR, and any test conftest sets it to a temp dir.
  )
