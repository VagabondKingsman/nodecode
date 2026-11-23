;;; osa-library-pages-and-downloads — define-memory recorded by session experience-s-UE91KT8Y-turn-1U7WRU4-7PDTE400MD, 2026-11-19T05:20:44Z
(in-package :nodecode.evolved)

;; keeps: the library routes as a fact of this project, and how to prove a page really animates
(define-memory osa-library-pages-and-downloads
  "Trong /home/boxes/osa thư viện giữ trang ở /api/pages (title/content/format html), chia sẻ công khai bằng POST /api/pages/{id}/share rồi /s/<token> và /api/shared/<token>/raw; tải một tệp y nguyên từ máy bot bằng GET /api/files/download?path=<đường dẫn tuyệt đối> (html luôn đi attachment, cần cookie đăng nhập).")
