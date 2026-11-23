;;; osa-skill-files-need-an-on-disk-pack — define-memory recorded by session experience-s-ZSN3J701-turn-1U7TZBY-BK46TIROAC, 2026-11-17T17:15:30Z
(in-package :nodecode.evolved)

;; giữ luôn sự thật về cách bot đọc file skill (để không dẫn sai lần nữa)
(define-memory osa-skill-files-need-an-on-disk-pack
  "Trong OSA này, file đính kèm của skill chỉ tới được bot khi có pack trên đĩa <OSA_DATA_DIR>/skill-packs/ai-native/<tên>/ — cột files trong DB một mình là vô hình (load_skill không có tham số file, read_skill_resource trả 'No installed resources')."
  :type :feedback)
