;;; osa-direct-chats — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7IS2G-OJF0BU1Y0N, 2026-11-11T16:07:40Z
(in-package :nodecode.evolved)

(define-memory osa-direct-chats
  "In /home/boxes/osa one Bot can own several direct chats (the oldest, id-min, is the Bot's own and dies with it); PR #51 teaches the UI to label them and the API to rename/delete the extra ones, and until that merges the live box can only be cleaned with sqlite."
  :type :project
  :project "/home/boxes/osa"
  ;; Evidence 2026-11-11: the operator saw two "Nova"; `bots` held one row (id 1) and `chats` held ids 1 "Nova"
  ;; and 3 "scratch-nova", both bot_ids [1] — chat 3 had been inserted straight into the DB by an earlier session's
  ;; probe (`insert into chats(kind,title,bot_ids,updated,seen) values ('direct','scratch-nova','[1]',…)`).
  ;; Before PR #51: `chatLabel` did not exist, the sidebar and the header wrote bot.name for every direct chat, so
  ;; two chats of one bot read the same; `bots._bot()` picked the bot's chat with no order by (arbitrary);
  ;; renaming a bot overwrote every direct chat; PATCH/DELETE /api/chats/{id} answered "Chỉ xóa được nhóm; hội thoại
  ;; riêng bị xóa cùng Bot" (400) for a direct chat, and even its title could only be changed by SQL.
  ;; PR #51 (branch cursor/direct-chat-label, 2 commits, CI green): web/src/chatLabel.ts shows "Nova · probe" when a
  ;; direct chat carries its own title; `_bot()` orders by id; a rename only touches chats still holding the old name;
  ;; PATCH takes a direct chat's title (empty = follow the bot name), DELETE removes a direct chat that is not the
  ;; bot's own, and the sidebar menu gained 改名 / 删除对话 through the new askText() dialog.
  ;; On this box the live service runs cursor/audit-abc-cache, so until #51 merges a stray direct chat is renamed or
  ;; dropped with sqlite3 on /home/boxes/osa-data/osa.db (the running API refuses), and `(restart)`/kill -TERM
  ;; is what makes a merged change live.
  )
