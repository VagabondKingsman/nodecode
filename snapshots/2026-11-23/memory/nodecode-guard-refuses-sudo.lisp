;;; nodecode-guard-refuses-sudo — define-memory recorded by session experience-s-CC94P7FJ-turn-1U7U40Z-HW5E4FTKNB, 2026-11-17T18:44:15Z
(in-package :nodecode.evolved)

(define-memory nodecode-guard-refuses-sudo
  "On this box any shell command whose text contains `sudo` is refused by nodecode-guard before it runs, read-only probes included, so root access cannot be tested or used from an eval call: check what you can with `id -u`, `loginctl show-user`, `ss -ltnp` and by reading files, and hand any root step to the operator as a command to run themselves."
  :type :reference)
