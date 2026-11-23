;;; skill-prose-form-paren — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7IAME-7NCDINTA42, 2026-11-11T14:43:34Z
(in-package :nodecode.evolved)

(define-memory skill-prose-form-paren "Skill dạng prose của image này chỉ giữ phần body khi dấu ) đóng form nằm trên dòng riêng, và mỗi dòng body phải mở đầu bằng ;; — một dòng trơn làm define-skill đọc nó thành đối số và cả form hỏng." :type :lesson
;; để ) ở cuối dòng ;; thì (define-skill ...) chỉ ghi tên + mô tả; một dấu ngoặc kép nằm trong dòng ;; làm cả file
;; không đọc được, nên phải viết chữ thay cho ngoặc kép.
;; Chèn một dòng trơn (không có ;;) vào body cho lỗi "define-skill takes keyword options and then at most one string"
;; và (help) mất skill; chèn dòng trơn có dấu phẩy cho "Comma not inside a backquote". Sửa bằng cách viết lại
;; TOÀN BỘ form bằng define-skill/define-memory, đừng vá từng dòng — vá từng dòng lại đúng là cách nó hỏng (11/11).
)
