;;; pty-write-does-not-type-into-a-shell — define-memory recorded by session experience-s-GKPN8NDI-turn-1U7TG1E-FHFFC5ZMZ1, 2026-11-17T10:11:45Z
(in-package :nodecode.evolved)

(define-memory pty-write-does-not-type-into-a-shell
  "In this project, writing bytes to /dev/pts/N does not feed that terminal's shell: two injections of a command into another tab's tty did nothing, so a command has to be run by the person who owns the tab or through tmux."
  :type :project)
