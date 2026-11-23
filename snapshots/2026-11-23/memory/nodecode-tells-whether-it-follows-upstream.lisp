;;; nodecode-tells-whether-it-follows-upstream — define-skill recorded by session experience-s-MJ1G3NHN-turn-1U7WRP5-9LQPE167A5, 2026-11-19T05:21:34Z
(in-package :nodecode.evolved)

(define-skill nodecode-tells-whether-it-follows-upstream
  "Tell whether a nodecode home will move to a newer upstream build on its own, and what a self-built release would differ in."
  ;; when-to-use: the operator asks "will this box update itself when upstream moves" or "does turning on the self-build/advance timer change or break the running organism"
  ;; evidence: 2026-11-19 on /home/boxes — config had update mode off and channel stable, the live image listed 22 threads with neither UPDATE-POLLER nor RELEASE-FEED, `nodecode update --check` answered "beee92a7e, the stable channel's latest, is older than this build, 60db5cd91, so this build stays", and nodecode-advance.timer answered disabled; after enabling nothing, the box still served 0.1.16+60db5cd91.
  ;; 1. read the mode, not the intent: (json-value (read-shared-config) :object "update") — MODE off means never looks, ask stages only, auto applies; CHANNEL is the pointer it would follow (stable beee92a7e vs nightly 60db5cd91 on 2026-11-19); an unset mode is auto on an installed build and off on a checkout's (update.lisp UPDATE-SETTINGS).
  ;; 2. in source: START-UPDATE-POLLER and START-RELEASE-FEED both sit inside (unless (string= mode "off") …) — grep those two names in src/organism/update.lisp before trusting any claim that it polls.
  ;; 3. in the RUNNING image, not the file: (mapcar #'sb-thread:thread-name (sb-thread:list-all-threads)) must contain neither "update-poller" nor "release-feed"; their absence is the fact, a config file alone is only the intent.
  ;; 4. ask the CLI: `nodecode update --check` names the channel's label and says whether it is older than the running build ("this build stays") — it is the same question asked of the release host.
  ;; 5. for a self-build (nodecode-advance.sh / a checkout): `just release` dumps on the box's own SBCL (2.6.0 here) while official releases are dumped on the project's SBCL from tools/build/sbcl/build.sh (2.6.8) — that is why a compatibility patch such as lib/dial's sockopt-errno lookup exists in a fork and not in the official build; name that runtime difference rather than calling the build identical.
  ;; 6. before recommending the advance timer, list what it does beyond building: it merges upstream into the checked-out branch (conflict => merge --abort and stop), installs beside the old release, and restarts the gateway only when open_turns shows no turn newer than STALE_S=900 — so a long quiet turn can still be cut.
  ;; 7. measure a candidate build instead of predicting it: run the suite on the checkout (sbcl --eval '(asdf:test-system :nodecode)') and compare the failures by NAME against a clean upstream checkout on the same box; different names are the regression, the same names are the box's known reds.
  ;; confidence: high — every step above answered with a quotable line in one turn, and the suite gave the same five names on the fork build as on clean upstream.
  )
