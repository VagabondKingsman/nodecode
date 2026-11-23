;;; termius-ssh-needs-a-key — define-memory recorded by session experience-s-GKPN8NDI-turn-1U7TCOT-E8DH4YYHG5, 2026-11-17T08:54:40Z
(in-package :nodecode.evolved)

(define-memory termius-ssh-needs-a-key
 "In this boxes.dev box the operator reaches the shell from Termius over the tailnet (host osa / 100.112.118.106, user boxes), and that works only by public key: the boxes password is locked, so ~/.ssh/termius_ed25519 (private, on the box) stays paired with its line in ~/.ssh/authorized_keys, and sshd keeps PasswordAuthentication on so that sudo passwd boxes would be the alternative."
 :type :project :project "/home/boxes/nodecode")
