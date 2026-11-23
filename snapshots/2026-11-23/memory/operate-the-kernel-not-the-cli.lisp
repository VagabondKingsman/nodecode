;;; operate-the-kernel-not-the-cli — define-memory recorded by session s-YXFQ3K5L, 2026-11-23T06:53:51Z
(in-package :nodecode.evolved)

(define-memory operate-the-kernel-not-the-cli
  "The operator built nodecode thin on purpose — as minimal as pi, as capable as hermes/openclaw through cells — and expects the model to reach the kernel by sentence, not by a slash command or a typed shell, so every turn should ask for the outcome and let the verb do the work."
  :type :feedback
  :project "/home/boxes/nodecode"
  ;; Their words, 2026-11-23: codex/claude "go the distance" off a long system prompt at
  ;; the cost of tokens; nodecode trades that length for cells (discord/telegram, goal) and
  ;; keeps the prompt malleable by the model, unpoisoned. "in lisp, code is data, data is
  ;; code; so theres no need to manually type /goal [X] in the composer, literally just
  ;; ask it". They think users are "sleeping on" this and using nodecode "at face value,
  ;; in the same nature as any other clis".
  ;;
  ;; What that means in practice, checked this session: goal:start takes a shell check
  ;; (done when it exits 0) or a judge, a fork of this session told to change nothing,
  ;; answering MET or NOT MET, with k 2-8 attempts in their own worktrees and a blind
  ;; pick; (help :goal) is the manual. A define-memory/define-skill made mid-turn is a
  ;; file in the knowledge cell and is in the index the next turn — code as data, observed.
  ;;
  ;; Where the reading has an edge to it: the same thin prompt is not equally reliable on
  ;; every model, so the memory/skill layer is what carries consistency, and it is
  ;; model-authored. And a prompt the model may rewrite can be eroded by it, so keep what
  ;; must never lapse in a cell or a memory with receipts, not in prose the next model
  ;; inherits blind.
  )
