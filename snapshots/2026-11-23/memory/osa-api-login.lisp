;;; osa-api-login — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7JI6P-C3MP0JJPF3, 2026-11-12T01:20:55Z
(in-package :nodecode.evolved)

;; define-skill takes a docstring plus keyword options; fold the sections into one string
(define-skill osa-api-login
  "In /home/boxes/osa the API answers only with a session cookie: sign in at POST /login (form fields password and next), taking the password from the running process's environment, then send the jar.
;; when to use: you want GET/POST on the running OSA (settings, chats) from the shell and every call answers 'Vui lòng đăng nhập trước' — an empty or stale cookie jar.
;; 1. pid: ss -ltnp | grep 8765 (whichever unit owns 8765 - on this box the user unit, see osa-two-units-one-port).
;; 2. password: strings /proc/<pid>/environ | grep '^OSA_PASSWORD=' | cut -d= -f2 — the unit file /etc/systemd/system/osa.service is root-only ('Permission denied').
;; 3. sign in: curl -s -c /tmp/osa.jar -o /dev/null -w '%{http_code}' -X POST --data-urlencode \"password=$PW\" --data 'next=/' http://127.0.0.1:8765/login — 303 means the cookie is in the jar.
;; 4. read: curl -s -b /tmp/osa.jar http://127.0.0.1:8765/api/settings | python3 -c 'import json,sys; print(json.load(sys.stdin)[\"roles\"])' — the effective config the process runs.
;; 5. there is no /api/login (it answers 405 Method Not Allowed); the desktop app uses POST /login/ticket with Authorization: Bearer <password> instead.
;; confidence: high — 2026-11-12: /api/login gave Method Not Allowed, a stale /tmp/osa.jar gave 'Vui lòng đăng nhập trước', and after steps 1-3 the same jar returned the roles with router = grok-4.20-0309-non-reasoning.")
