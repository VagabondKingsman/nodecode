;;; prove-a-page-animates — define-skill recorded by session experience-s-UE91KT8Y-turn-1U7WRU4-7PDTE400MD, 2026-11-19T05:20:49Z
(in-package :nodecode.evolved)

;; a procedure worth keeping: prove motion, don't assume it
(define-skill prove-a-page-animates
  "Chứng minh một trang động thật sự đang chạy ở đúng chỗ người dùng sẽ nhìn, bằng hai ảnh chụp cách nhau, không bằng cách đọc code."
  ;; when to use - sau khi triển khai một trang HTML/SVG/CSS có animation (lên thư viện, lên máy ảo, hay trang chia sẻ) và cần nói "nó chạy" mà không tự lừa mình; khi trang nằm trong sandbox CSP hoặc trên một máy khác, nơi "mở được" không đồng nghĩa "đang chạy"
  ;; steps
  ;; 1. Chốt chỗ người dùng nhìn: máy ảo, trình duyệt headless, hay chính URL chia sẻ - không phải máy này nếu trang sống ở máy khác.
  ;; 2. Chụp hai lần cách nhau ~1,4 giây ở chỗ đó (c.screenshot() hai lần trên máy ảo; hoặc CDP Page.captureScreenshot ở Chrome headless).
  ;; 3. So byte: khác nhau thì đang động; giống hệt thì nghi frozen - đừng kết luận "chạy" chỉ vì HTTP 200.
  ;; 4. Nếu người dùng cần tự bấm dừng/tiếp tục, lái thêm nút đó (Space hoặc click) và đọc lại trạng thái aria/CSS - cả ba trạng thái moving/paused/resumed mới đáng gọi là PASS.
  ;; 5. Ghi lại kèm bằng chứng: hash hai ảnh, hoặc vị trí phần tử đổi giữa hai lần đọc.
  ;; evidence - hai ảnh máy ảo cách 1,4s cho ra "shot1 473284 b591ce3a4f2b shot2 467240 0699f6815954 ANIMATING", và bản headless cho "verdict PASS ... moving true, frozen true, resumed true"; trước đó chỉ có "serve=200 / open title" mà không nói gì về chuyển động.
  ;; confidence - high: cùng một kết luận đứng trên hai môi trường độc lập (máy ảo và Chrome headless), và phép đo là so byte chứ không phải suy diễn.
  )
