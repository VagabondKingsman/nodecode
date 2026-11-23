;;; nodecode-channel-nightly-vs-stable — define-memory recorded by session experience-s-MJ1G3NHN-turn-1U7WSLH-YUABQCMVWV, 2026-11-19T05:31:21Z
(in-package :nodecode.evolved)

(define-memory nodecode-channel-nightly-vs-stable
  "nodecode.ai co hai con tro kenh: stable la mot TAG phat hanh (co GitHub release, installer mirror theo no), nightly la build xanh moi nhat cua main (khong tag, khong release, installer giu nguyen cua stable); mot commit tren upstream chi cai duoc khi da publish thanh label."
  :type :reference
  ;; why: 2026-11-19 the operator asked what differs between the two channels and whether, with update.mode off, an update is only ever a manual act. Both answers come from tools/release/publish.sh: "stable is what every install and every home follows unless its config says otherwise: a version on GitHub's releases page, the installers mirrored. nightly is main's newest green build ... no tag, no GitHub release, and the installers stay the stable release's."
  ;; the pointers live at https://nodecode.ai/dl/<channel>-<arch>-<os>, one line each; read them with a ?cb=$(date +%s) cache-buster. 2026-11-19: stable=beee92a7e (release 0.1.16, 13/11), nightly=60db5cd91 (tip of upstream/main, 18/11) — which is why a build at 60db5cd91 is newer than "the latest release" and `nodecode update --check` says the stable label is older and the build stays.
  ;; a stable publish also moves every nightly pointer that names a commit it carries, so nightly is never behind stable; a platform held back (macOS/Windows skip) keeps every one of its pointers on the label it named.
  ;; moving this home by hand: `nodecode update LABEL` names one label AND PINS the home to it (~/.nodecode/release-pin; a bare `nodecode update` lifts the pin), `nodecode update --check` stages and classifies only, and the installer route is `env -u NODECODE_HOME NODECODE_VERSION=<label> sh install.sh` (no pin). update.mode=off only stops the organism looking by itself — the verb still works.
  ;; the gap to remember: commits on upstream/main are NOT installable until the Release workflow publishes them as a nightly; for an unpublished commit the only route is building from source (just release), which is what nodecode-advance.timer did.
  )
