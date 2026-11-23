;;; home-cells-link-into-the-checkout — define-memory recorded by session experience-s-YXFQ3K5L-turn-1U84ARM-DLDZTKZA4K, 2026-11-23T06:48:52Z
(in-package :nodecode.evolved)

;; step 3: the trap a next session would hit — the live home's cells hang off a checkout
(nodecode.evolved:define-memory home-cells-link-into-the-checkout
  "On this box the running home's 18 shipped cells are symlinks into /home/boxes/nodecode/cells/, so moving or deleting that checkout takes them out of the live organism."
  :type :project
  :project "/home/boxes"
  ;; measured on 2026-11-23, `ls -la ~/.nodecode/cells`: nodecode-board ->
  ;; /home/boxes/nodecode/cells/board/, nodecode-web -> /home/boxes/nodecode/cells/web/, and so on,
  ;; eighteen of them. The reason is on disk too: ~/.nodecode/cell-repoint-2026-11-18.map lists each
  ;; cell and the checkout path it points at — the link was made so a cell edit lands in the organism
  ;; without reinstalling, and the map still names the older nodecode-upstream paths.
  ;;
  ;; The whole home is 35 cells in three kinds, and only this kind is a link: 13 hub cells (a real
  ;; directory each, marked .hub with its repository and pinned commit — undo pstack rea tinyfish
  ;; heartbeat live-time ports telemetry toolaria tool-break doc-markdown subagents google-antigravity),
  ;; 4 local directories nobody's hub has (antigravity, cursor-agent, cursor-agent-memory, nodecode),
  ;; and these 18 links. A fresh install on another machine needs no links at all: the release ships
  ;; those cells and `nodecode add` fetches the hub ones — the link is this box's arrangement, not a
  ;; requirement of the product.
  ;;
  ;; so: before `rm -rf /home/boxes/nodecode`, a `git clean` in it, or a move of the checkout, look at
  ;; `readlink -f ~/.nodecode/cells/*` first; if the links must go, replace them with copies of the
  ;; folders (or let the release's own copies take over), or the organism loses eighteen cells on its
  ;; next start.
  )
