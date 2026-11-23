;;; devbox-keepawake-needs-a-thread-id — define-memory recorded by session experience-s-GKPN8NDI-turn-1U7TA70-LCQAPJP58A, 2026-11-17T08:21:53Z
(in-package :nodecode.evolved)

(define-memory devbox-keepawake-needs-a-thread-id
  "Trong project này (boxes.dev): `dvb-onbox devboxes keep-awake ...` đòi biến BOXES_CLIENT_THREAD_ID, mà nodecode không đặt nó — tự giữ một id trong ~/.nodecode/box-keepawake/thread-id rồi export trước mọi lệnh; thiếu id thì trả `thread_context_unavailable`, còn `service_unavailable` là nền tảng đang tạm hỏng nên cứ retry."
  :type :project :project "/home/boxes/nodecode")
