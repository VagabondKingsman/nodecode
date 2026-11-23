;;; nodecode-runs-official-upstream-no-free-lane — define-memory recorded by session s-MJ1G3NHN, 2026-11-19T04:42:06Z
(in-package :nodecode.evolved)

(define-memory nodecode-runs-official-upstream-no-free-lane
  "Box nay chay nodecode CHINH THUC (0.1.16+60db5cd91, nightly = tip upstream/main); moi ban va free-lane da bi go bo vi chung lam hong model Cyber v1 free (nodecode-free)."
  :type :project
  ;; why: 2026-11-19 the operator asked to drop the free-lane patches: on the fork build a nodecode-free turn failed, and the wanted behaviour is the stock one.
  ;; what was removed: (a) the install -- ~/.local/share/nodecode/current now -> 60db5cd91 laid out by https://nodecode.ai/install.sh from channel nightly, and every fork release folder (eb6e2c8, 60db5cd, 80cb321.pre-restore, 6484256, ...) is gone; (b) the layer -- free-lane-form-reads-p, free-lane-unescape-once, fl-log, fl-sum, fl-suite-report, fl-replace-all forgotten with fmakunbound (their files left cells/cursor-agent/ and its .asd); (c) the memories that taught the fork (nodecode-this-box-runs-the-free-lane-fork, unified-free-lane-tree-in-tmp, free-lane-runs-full-mode, free-lane-must-run-tools, free-lane-tool-flow, audit-free-lane-eval-failures, free-lane-eval-failures-are-measured, free-lane-block-cannot-hold-a-fence, free-lane-one-unescape-census, install-nodecode-from-fork) deleted from cells/cursor-agent-memory/; (d) /home/boxes/nodecode checkout switched to branch box/clean at upstream/main (60db5cd) and the /tmp worktrees (nc-unified, nc-pr, nc-base) removed.
  ;; the timer that kept reinstalling the fork: nodecode-advance.timer (OnUnitActiveSec=5min, runs ~/.local/bin/nodecode-advance.sh, builds /home/boxes/nodecode and points `current` at it). It silently undid an official reinstall at 04:13:44 -- stopped and DISABLED. Re-enable only after the checkout's branch is one you want the box to run.
  ;; proof the stock lane works: `cd /home/boxes && timeout 150 script -qec \"nodecode --model nodecode-free/nodecode-cyber-v1 -- 'Reply with exactly: PONG-FREE'\" /dev/null` streamed and completed with PONG-FREE on build 0.1.16+60db5cd91.
  ;; upstream has no free lane at all: src/engine/providers/openai-completions.lisp's REQUEST-BODY sends the plain chat body, and +free-provider+ \"nodecode-free\" in tui/commands/dispatch.lisp is only the id /models offers Cyber v1 free under.
  )
