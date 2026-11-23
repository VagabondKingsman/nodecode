;;; nodecode-update-by-hand-flow — define-memory recorded by session s-MJ1G3NHN, 2026-11-19T05:59:52Z
(in-package :nodecode.evolved)

(define-memory nodecode-update-by-hand-flow
  "Box nay KHONG tu cap nhat (update.mode=off, advance tat); channel da doi sang NIGHTLY nen mot lenh `nodecode update' tron di toi. Khi can: chay (nc-update-check) roi update bang label da publish."
  :type :feedback
  ;; why: 2026-11-19 the operator approved this flow (manual, on request) instead of re-enabling the auto-advance timer, and then asked for the channel to be nightly.
  ;; step 1, one call: (nc-update-check) prints installed label, the nightly and stable pointers, upstream/main's head, how many commits upstream is past the installed build, whether a release-pin exists, and a verdict. Kept defun: cells/cursor-agent/nc-update-check.lisp.
  ;; step 2, only when the verdict names a label: `nodecode update <label>' — stages beside the running build, classifies definition by definition, goes live hot when every changed definition can, else restarts at the next idle moment; it WRITES ~/.nodecode/release-pin, and a later bare `nodecode update' lifts the pin. The installer (`env -u NODECODE_HOME NODECODE_VERSION=<label> sh install.sh') does not pin, verifies sha256, and moves `current'.
  ;; step 3, when upstream is ahead but the nightly pointer still names the installed build: there is NOTHING to download; the commits exist only in git, so carrying them means a source build (`cd /home/boxes/nodecode && just release' then install the dump) — the only route that also swaps the runtime from the release's SBCL 2.6.8 to this box's 2.6.0.
  ;; config now: ~/.nodecode/config.jsonc update = { mode: "off", channel: "nightly" } (backup at config.jsonc.bak-20261119-0559). mode stays off on purpose — nothing looks at the channel until someone runs the verb. Proof the channel took: before the change `nodecode update --check' answered "stable's latest beee92a7e is older than this build … this build stays"; after it, "already at 0.1.16 (60db5cd91)".
  ;; the live image reads config afresh: (nodecode.evolved::update-settings) answered mode=off channel=nightly url=https://nodecode.ai/dl feed=<same>, with no restart.
  )
