;;; devbox-npm-global-needs-prefix — define-memory recorded by session experience-s-CC94P7FJ-turn-1U7U33U-JDPBVHN7F1, 2026-11-17T18:29:27Z
(in-package :nodecode.evolved)

(define-memory devbox-npm-global-needs-prefix
  "On this devbox npm's global prefix is /usr, which is root-owned and there is no sudo, so every global CLI installs with npm install -g --prefix /home/boxes/.local and lands in /home/boxes/.local/bin (needs export PATH=/home/boxes/.local/bin:$PATH in the same shell)."
  :type :reference)
