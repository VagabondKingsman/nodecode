;;; skill-prose-form-paren — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7IAME-7NCDINTA42, 2026-11-11T14:43:34Z
(in-package :nodecode.evolved)

(define-memory skill-prose-form-paren "Skill dạng prose của image này chỉ giữ phần body khi dấu ) đóng form nằm trên dòng riêng, và mỗi dòng body phải mở đầu bằng ;; — một dòng trơn làm define-skill đọc nó thành đối số và cả form hỏng." :type :lesson
;; để ) ở cuối dòng ;; thì (define-skill ...) chỉ ghi tên + mô tả; một dấu ngoặc kép nằm trong dòng ;; làm cả file
;; không đọc được, nên phải viết chữ thay cho ngoặc kép (áp dụng cả khi body nằm trong CHUỖI MÔ TẢ: một dấu ngoặc kép bên trong chuỗi cắt ngang form và define-skill báo 'takes keyword options and then at most one string; X is neither' — 23/11/2026, lỗi đầu tiên của osa-regacc-full-flow).
;; Chèn một dòng trơn (không có ;;) vào body cho lỗi "define-skill takes keyword options and then at most one string"
;; và (help) mất skill; chèn dòng trơn có dấu phẩy cho "Comma not inside a backquote". Sửa bằng cách viết lại
;; TOÀN BỘ form bằng define-skill/define-memory. Vá từng dòng chỉ an toàn khi dòng thêm vào mở đầu bằng ;; — chèn
;; một dòng như thế vào file memory đang sống thì nhận receipt "live here", còn dòng trơn thì receipt nói
;; không đọc được (11/11 và 11/18). 23/11: cách chữa gọn nhất là đặt các bước vào CHÍNH chuỗi mô tả (xuống dòng thật bên trong chuỗi) rồi để ) trên dòng riêng, define xong grep lại file để chắc body còn.
)
