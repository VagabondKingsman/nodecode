;;; osa-db-wal-and-loop-freeze — define-memory recorded by session s-GKPN8NDI, 2026-11-15T05:46:15Z
(in-package :nodecode.evolved)

(define-memory osa-db-wal-and-loop-freeze "The OSA shared sqlite in /home/boxes/osa-data is WAL with synchronous=NORMAL since 15/11, and `providers._bounded` counts wall time: a frozen event loop (672 s on 14/11) now yields StreamStalled instead of silently continuing." :type :project :project "/home/boxes/osa"
;; Commits (PR #103). Backups must use the sqlite backup API, not cp of osa.db alone; looplag prints stacks next time the loop stalls.
)
