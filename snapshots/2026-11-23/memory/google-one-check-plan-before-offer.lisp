;;; google-one-check-plan-before-offer — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U7YUGK-D1KSF4ST7, 2026-11-20T08:09:03Z
(in-package :nodecode.evolved)

(define-skill google-one-check-plan-before-offer
  "Trước khi thử claim bất kỳ offer/trial Google One trên máy ảo, phải đọc Current plan trong Google One trước — account đã có gói thì mọi offer trial bị ẩn, và mọi công spoof (Pixel props, keybox, Magisk) đều vô nghĩa."
  ;; when to use: khi chuẩn bị claim trial/offer Google One (Pixel/Xiaomi/AI Pro) trên máy ảo với một account lạ
  ;; 1. Mở Google One trên máy đích, đọc dòng 'Current plan' + 'Member since' — nếu là gói trả phí thì dừng, xin account khác
  ;; 2. Mở 'Change your Google One plan' để xem storefront: giá bằng VNĐ/USD cho biết account nằm ở vùng nào (offer theo máy phụ thuộc vùng)
  ;; 3. Trong màn hình đổi gói, nếu không có dòng 'free trial'/6 months thì offer không tồn tại cho account đó, không phải lỗi máy
  ;; 4. Chỉ khi Current plan là gói miễn phí 15 GB mới đi tiếp bước Check for offers
  ;; evidence: 20/11/2026 trên osa-phone13m (5558) đã spoof Pixel + keybox + Magisk nhưng Google One hiện 'Google AI Plus (400 GB), Member since September 30, 2026' và bảng upgrade chỉ có ₫132.000/₫225.000/₫489.000, không dòng trial; trước đó nhiều lượt bị quy cho 'verdict đỏ' trong khi nút chặn thật là account đã có gói.
  ;; confidence: high — đọc trực tiếp từ app, hai màn hình khác nhau cùng khớp.
  )
