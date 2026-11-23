;;; osa-box-privileges — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7HNN7-BX5FFDJ8DA, 2026-11-11T01:23:18Z
(in-package :nodecode.evolved)

(define-memory osa-box-privileges
  "Trong project /home/boxes: shell không có capability nào (CapEff=0) và nodecode-guard chặn sudo, nên đổi mạng cấp hệ thống (thêm IP, bật tunnel/funnel cần root) phải đưa lệnh cho operator tự chạy; eth0 chỉ có 169.254.0.21/30 nên tailscaled userspace cần TS_ASSUME_NETWORK_UP_FOR_TEST=1."
  :type :project :project "/home/boxes")
