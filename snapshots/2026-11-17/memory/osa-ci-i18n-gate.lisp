;;; osa-ci-i18n-gate — define-memory recorded by session experience-s-WIAL20RG-turn-1U7RPOW-JR8CUXK8JF, 2026-11-16T12:10:20Z
(in-package :nodecode.evolved)

;; keeps: the i18n gate fact, and the BOARD-row procedure
(define-memory osa-ci-i18n-gate "Trong /home/boxes/osa, backend CI chạy `python -m osa.i18n` như cổng, nên mỗi khoá `i18n.t(...)` mới phải thêm vào cả `osa/locales/en.json` lẫn `vi.json`, đúng thứ tự chuỗi, trước khi push (PR #146 đỏ vì thiếu đúng khoá '坏了').")
