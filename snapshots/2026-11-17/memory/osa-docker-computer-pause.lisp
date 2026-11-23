;;; osa-docker-computer-pause — define-memory recorded by session s-GKPN8NDI, 2026-11-15T05:46:21Z
(in-package :nodecode.evolved)

(define-memory osa-docker-computer-pause "On /home/boxes/osa the Docker computer hangs silently if the container is paused while someone watches: `docker exec` waits forever. Since 15/11 `open_vnc` unpauses first, `viewers` blocks idle_pause, and 10 s without a first byte raises ConnectionError carrying docker's last line." :type :project :project "/home/boxes/osa"
;; PR #104, tests/test_vnc.py. RFB is a server-speaks-first protocol: a test client must answer the version line or it looks hung.
)
