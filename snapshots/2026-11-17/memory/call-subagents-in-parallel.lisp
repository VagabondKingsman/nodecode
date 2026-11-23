;;; call-subagents-in-parallel — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7IP2G-A27LCBTK9S, 2026-11-11T14:48:33Z
(in-package :nodecode.evolved)

(define-skill call-subagents-in-parallel
  "Run an ask that splits into independent reads as several Nodecode subagents at once, instead of one after another."
  ;; when-to-use: the ask breaks into two or more investigations that each take several reads, or one probe's output would bury this context — the same shape as fork, but the work is browsing/measuring, not thinking.
  ;; 1. Each agent is its own session: it inherits the model, not this conversation, so the task text must stand alone (what to read, what to report, in how many lines).
  ;; 2. (subagents:task (list (list :name "a" :task "…") (list :name "b" :task "…")) :await t :timeout-seconds 300) — keyword plist pairs: string keys such as (list "name" ...) raise TYPE-ERROR "NIL is not of type STRING when setting slot NAME", and :timeout-seconds must be 1..300 ("task timeout_seconds must be between 1 and 300").
  ;; 3. Agents read and write the real filesystem. Say "read-only; do not modify any file" and add "do not create files" — an agent told read-only still wrote a report into the session folder.
  ;; 4. The return value names the team, the board and each agent's turns/tokens/elapsed; each agent's answer also arrives as an IRC post (sometimes as a harness note mid-turn), so read the board text if the call's tail is cut.
  ;; evidence (2026-11-11): two agents ("tools", "cost") started together with :await t each finished in 41 s (22,639 / 12,271 tokens) and answered on board #agents-697d3270e725; before that, two runs failed on exactly the two argument mistakes in steps 2 — the string-key version raised TYPE-ERROR, the 420 s version raised "must be between 1 and 300".
  ;; confidence: high — both errors and the working call happened back to back in one turn, and the answers came back with their own cross-checks.
  )
