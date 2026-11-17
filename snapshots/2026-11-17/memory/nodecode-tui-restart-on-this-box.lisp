;;; nodecode-tui-restart-on-this-box — define-memory recorded by session s-QHNCAI0R, 2026-11-13T06:07:41Z
(in-package :nodecode.evolved)

;; keeping the restart recipe: a TUI needs the session's controlling terminal
(define-memory nodecode-tui-restart-on-this-box
  "Restarting a dead nodecode TUI on this devbox: type it into the zmx session's own shell."
  :type :project
  :project "/home/boxes/nodecode")
