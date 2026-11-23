;;; nodecode-update-to-0-1-14 — define-memory recorded by session s-1CKKCZWG, 2026-11-11T16:12:23Z
(in-package :nodecode.evolved)

(define-memory nodecode-update-to-0-1-14
  "In this project (/home/boxes/nodecode) the home is now LIVE on 0.1.14+cef1be5a3 (16:19Z 2026-11-11, from 98dd6dc80); the release could not go in hot because the new build names kernel functions the old image lacks, and killing the serve pid handed the organism over in-process on the OLD build with the layer only — a unit restart (`nodecode gateway restart`) is what actually booted it."
  :type :project
  :project "/home/boxes/nodecode"
  ;; Why a restart: `nodecode update` said "cef1be5a3 runs at the next launch: this image refused it live
  ;; (organism/evolve.lisp: standing-package-refused — names nodecode.kernel::standing-package-refused-name,
  ;; -operation, which this image does not define)" and `nodecode update --check` classified it as
  ;; "core: restart: organism/evolve.lisp — changes outside any definition are boot state; cells: restart:
  ;; ironclad — a system this image never loaded". So the new build names kernel functions the OLD image lacks;
  ;; it only works when the whole new image loads.
  ;; State: ~/.local/share/nodecode/current -> cef1be5a3 (0.1.14), `nodecode --version` prints 0.1.14+cef1be5a3,
  ;; but the organism answering this session was pid 96719 (`nodecode serve --store ~/.nodecode/history.db`,
  ;; started 05:30Z) on 98dd6dc80. `nodecode gateway status` said "on — waiting: pid 96719 runs the organism now,
  ;; and the gateway takes it over when that closes", so killing 96719 is the handover: the gateway relaunches
  ;; `current` on 0.1.14 with the same store (session history and the layer survive).
  ;; 16:13Z, what the kill actually did: the gateway (pid 527282, an OLD 98dd6dc80 process started 10 h earlier) took
  ;; the organism over IN-PROCESS ("serving store ... on port 37177 (session s-GATEWAY)"), so the build did not change
  ;; (restart-cells answered "generation 18", and "cef1be5a3 is staged; it goes live the first moment no turn is
  ;; running") — and the takeover came up with the LAYER ONLY: (cells) listed cursor-agent alone and the packages of
  ;; live-time / subagents / ports / nodecode-board / telemetry were all NIL, while memories and skills still read
  ;; fine. So killing the serve process is NOT enough for this home: restart through the unit (`nodecode gateway
  ;; restart`), which boots the home fresh from `current` and brings the 29 cells back. Check after: (length (cells))
  ;; = 29-ish, (find-package :live-time) non-NIL, `nodecode --version` 0.1.14+cef1be5a3.
  ;; DONE 16:19Z: the unit restart landed the new build — `nodecode gateway status` says "serving: pid 2765380,
  ;; port 37177, up 4m, build 0.1.14+cef1be5a3", `nodecode --version` is 0.1.14+cef1be5a3, the standing notice says
  ;; "nodecode updated to 0.1.14+cef1be5a3 (from 98dd6dc80)", and (cells) lists 30, all :LOADED (28 shipped +
  ;; subagents + cursor-agent/memory). Note there is no (nodecode-version) function to call from a snippet; the live
  ;; build is read from `nodecode gateway status` or the gcav notice, not from inside the image.
  ;; Verify after: `nodecode --version` and a live eval of (nodecode-version) / (help :image); `nodecode gateway
  ;; status` should say it runs the organism itself. If the new build does not serve, the next launch is pristine
  ;; generation 0 and `nodecode rollback N` restores a sealed generation; `nodecode update 0.1.13` pins this home
  ;; back (a bare `update` lifts the pin).
  ;; Worth reading in 0.1.14 for this box: restart-cells takes the name /cells shows (and a bare restart-cells
  ;; skips cells turned off — several cells were installed here), a snippet can no longer delete or rename a
  ;; package nodecode runs on (#387), config-set/config-get refuse dotted names (#401), a kept variable holding a
  ;; process/thread/socket keeps only its name (#392), and #442: a gateway that updated while running keeps
  ;; getting updates after another home's install cleans old releases.
  )
