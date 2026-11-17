;;; edit-verb-text-escapes — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7KPKZ-KUFODNN9CH, 2026-11-12T17:54:54Z
(in-package :nodecode.evolved)

(define-skill edit-verb-text-escapes
  "Patching source with (edit PATH ($ old) ($ new)): a strings entry is read verbatim (JSON \\n is a real line break, \\\\n stays the two characters \\n), a backslash-n typed inside the Lisp form reads as a plain n — and the text (help 'name) prints is the docstring already escaped, so an edit built from it never matches the file.

Viết đầu file: write-file thay CẢ file, nên thêm một dòng mô tả mà dùng write-file là mất thân script (scripts/probe_run.py còn 2 dòng, chạy ra rỗng, rc=0 - hỏng không kèm lỗi). Thêm đầu file bằng edit trên dòng đầu, hoặc write-file mang trọn thân; ghi xong đọc lại số dòng.")
