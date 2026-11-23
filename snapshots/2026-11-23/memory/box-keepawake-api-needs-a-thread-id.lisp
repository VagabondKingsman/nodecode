;;; box-keepawake-api-needs-a-thread-id — define-memory recorded by session experience-s-GKPN8NDI-turn-1U7TBIN-MARHWH286R, 2026-11-17T08:42:41Z
(in-package :nodecode.evolved)

(define-memory box-keepawake-api-needs-a-thread-id "In this box, `dvb-onbox devboxes keep-awake` answers thread_context_unavailable until BOXES_CLIENT_THREAD_ID is set, and its backend may answer service_unavailable for long stretches, so the watchdog must carry its own id and backoff."
  :type :project :project "/home/boxes/nodecode")
