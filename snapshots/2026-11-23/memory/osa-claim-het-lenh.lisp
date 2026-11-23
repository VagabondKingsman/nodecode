;;; osa-claim-het-lenh — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U7ZLYZ-IR5ZOK509V, 2026-11-20T18:19:49Z
(in-package :nodecode.evolved)

(define-skill osa-claim-het-lenh "Lệnh `claim-het --mat-khau ..` quét toàn bộ offer 0 đồng của account rồi claim + cộng dồn theo thứ tự nhỏ→lớn; phần QUÉT đã chạy đúng, phần MUA còn hỏng ở bước thêm thẻ. when: khi muốn claim hết mọi trial của một account thay vì chỉ 3→12→6→6. evidence: 20/11/2026 trên máy 5558, claim-het in 'Có 11 offer 0 đồng' theo thứ tự 1,2,3,4,6,6,6,6,12,12,18 tháng, rồi mỗi bước báo 'Không mở được trang thanh toán' / 'Cần thêm thẻ' vì nút Add card trong tờ 'Start by adding a payment method' tap trượt, và IP đang bị Play risk. confidence: medium (quét chắc, mua chưa xong).")
