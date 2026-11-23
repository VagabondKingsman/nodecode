(in-package :nodecode.evolved)

;; a habit, not a note about a package: this image carries pstack and reaches for it
(define-memory how-i-use-pstack
  "pstack (cell nodecode-pstack, 17 playbooks + 52 skills, no key) is my engineering router: read the matching playbook before the work, in one call, and climb its ladder before adding code."
  :type :lesson
  ;; why: the operator installed it 2026-11-23 and asked me to use it if it earns its place. The rules of its router that already change how I work here: name the data shape before logic; one guard in the shared path over a guard per caller; verify on the same surface where I reproduced.
  ;; 1. reach it from eval: (ps) is the catalogue, (ps "bug-fix") one file whole. Both live in the layer, so a fresh boot has them.
  ;; 2. route, don't browse: investigation (why / trace) | bug-fix (known broken) | feature (new behaviour) | perf-issue | refactoring | figure-it-out (none fits, start with investigation to scope) | session-pickup (taking over another session's work) | opening-a-pr + shipping (landing) | babysit / autopilot-stack / autopilot-full / orchestrate (a queue of PRs) | autonomous-run (long, operator away) | hillclimb (beat a measured number) | eval (experiment design).
  ;; 3. skills I actually want: architect (a seam between modules), interrogate (two valid designs), how (read a subsystem before touching it), swarm (3+ independent slices), unslop (prose before it ships), technical-writing, principle-prove-it-works, reflect/judgment-reviewer (nested path, read by path).
  ;; 4. the operator's standing rule outranks a playbook every time: OS work here lands as a PR the dev team reviews (osa-lands-through-review-prs); pstack's local-autonomy section does not make a shared branch reversible.
  ;; 5. the prose still says delegate_task / skill_view / cronjob: read the header the cell prints. delegate_task is Nodecode delegation, cronjob is the cron cell, skill_view(name='pstack:X') is (ps "X").
  ;; 6. a reference resolves one level under references/ (reflect/judgment-reviewer is fine). Measured 2026-11-23: 71 of the cell's 72 md answer by name; create-verification-skill/feature-map-example/README does not, by any spelling. Check a name serves before quoting it.
  )
