;;; osa-force-tool-choice — define-memory recorded by session s-1CKKCZWG, 2026-11-11T08:10:54Z
(in-package :nodecode.evolved)

;; keep the lesson as a project memory of /home/boxes/osa
(define-memory osa-force-tool-choice
  "When the router says it dispatched but called nothing, force tool_choice on the retry round instead of asking again in words."
  :type :project
  :project "/home/boxes/osa"
  ;; Live chat 1 (bot Nova, 94 messages) answered "Đã giao worker…" three times with an empty meta.tasks;
  ;; the same bot in an empty chat dispatched first try, so the tool list was fine and the history had
  ;; taught it that the sentence suffices. A prose nudge (C10's note) produced only more prose.
  ;; The fix that worked (C11, commit 16ad8ca): the corrective round sends
  ;; tool_choice={"type":"function","function":{"name":"dispatch"}}, xAI grok-4.20 and grok-4.7 accept it;
  ;; force only the FIRST request of that pass (forcing the closing round makes it dispatch twice), and
  ;; catch a 400 from a service that rejects tool_choice: restore the shown text, emit stream reset plus
  ;; that text, then run an ordinary round.
  ;; To tell history-poisoning from a missing tool: insert a bare chat row for the same bot
  ;; (chats.bot_ids='[N]') and send the identical sentence there.
  )
