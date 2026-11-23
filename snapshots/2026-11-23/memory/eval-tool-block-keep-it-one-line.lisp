;;; eval-tool-block-keep-it-one-line — define-skill recorded by session experience-s-NNQ8PVPU-turn-1U7UZG3-HOPSS1F4TF, 2026-11-18T06:07:51Z
(in-package :nodecode.evolved)

(define-skill eval-tool-block-keep-it-one-line
 "When a tool call comes back 'missing_required_argument: form ... received []', the arguments were lost in transit; resend the same work as one short single-line form."
 ;; when to use: an eval call returns missing_required_argument with received [], notably after the session moved to nodecode-free, which renders calls as a fenced block
 ;; step: do not retry the same long multi-line form; rewrite it as one line, one shell command per call
 ;; step: if it still arrives empty, split into several single-purpose calls and continue from whatever did run
 ;; evidence: on the free lane twelve consecutive evals came back with received [] for multi-line forms (seq 82864 through 83011) while one-line forms ran at once (seq 82879, 83033, 83057)
 ;; confidence: medium - one-line worked repeatedly, but one multi-line form did land earlier in the same lane, so the line count alone is not proven to be the trigger
 )
