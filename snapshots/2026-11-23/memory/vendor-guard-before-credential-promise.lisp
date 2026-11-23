;;; vendor-guard-before-credential-promise — define-skill recorded by session experience-s-CC94P7FJ-turn-1U7U4XZ-MOAEC344PU, 2026-11-17T19:05:54Z
(in-package :nodecode.evolved)

(define-skill vendor-guard-before-credential-promise
  "Before promising you can add an account or credential to a third-party tool, read that tool's own agent rules and grep its source for a risk-acknowledgement guard; if a guard exists, its refusal is final and the step belongs to the operator in the vendor's own UI."
  ;; when to use - an ask of the shape "add / log in provider X for me", or "is it safe to sign in with account Y", where an OAuth consent or stored credential is the deliverable; the question to settle first is whether an automated run is allowed to perform it at all
  ;; 1 - read the installed package's AGENTS_*.md / contribution rules before touching the flow: (grep -n -i '<provider>' <pkg>/AGENTS_INSTALL.md), because that file states what an agent must never do
  ;; 2 - grep the source for the guard, not just the docs: (grep -rln 'risk\\|acknowledge\\|refus' <pkg>/src/oauth/), and read the module that owns it
  ;; 3 - probe the API door without the acknowledgement to learn its real shape - a 4xx carrying a code such as antigravity_risk_not_acknowledged is the boundary, and sending the acknowledgement yourself is exactly what the guard forbids
  ;; 4 - do the parts that carry no credential and no consent: adding the provider, restarting the unit, verifying the roster, then hand the operator the exact button, the checkbox, and where the OAuth redirect will land
  ;; evidence - in this turn `ocx provider add google-antigravity` was fine, but POST /api/oauth/login returned "{\"code\":\"antigravity_risk_not_acknowledged\"} http=403", and AGENTS_INSTALL.md read "Agent-driven runs are refused with antigravity_risk_not_acknowledged whatever the flag says; treat that as the final answer." Before reading it I had been told to make the login work; after reading it the answer became the operator's own dashboard click plus a written warning, which is what the operator got.
  ;; confidence - high: the refusal is a code-level guard quoted from the package itself and reproduced live, not an inference
  )
