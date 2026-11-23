;;; osa-docker-computer-e2e — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7OCSD-G7ADZ7HILM, 2026-11-14T16:25:57Z
(in-package :nodecode.evolved)

(define-skill osa-docker-computer-e2e "How to E2E the OSA Docker computer without touching the live instance: build osa-computer:1, run a second server on another port with backend local, then drive it over HTTP."
;; when-to-use - an OSA-002-style check of the Docker desktop path on a box that has docker but the live service already uses another backend
;; 1. docker build -t osa-computer:1 osa/computer/image (needs the docker group: sg docker -c ...).
;; 2. Copy config.yaml to a temp data dir with computer.backend: local and computer.idle_pause_s: 0; start uvicorn on a spare port with OSA_DATA_DIR/OSA_CONFIG pointing there, under sg docker.
;; 3. GET /api/bots/1/computer, POST .../start, .../takeover, .../type, .../handback; verify with docker exec the container's desktop (xdotool getdisplaygeometry).
;; 4. The shot route answers 409 by design for this backend ("màn hình trực tiếp") — the picture comes from the websocket /api/bots/<id>/computer/vnc, not /shot.
;; 5. Kill the second instance and docker rm -f the container when done.
;; evidence - 14/11: start/takeover/type/handback 200, exec 0, screenshot PNG, but the VNC socket read timed out on its first frame (still open); shot 409 explained by the backend being a desk, not a peek source.
;; confidence - medium; the HTTP half is proven, the VNC half is not yet.
)
