;;; make-a-posture-the-default — define-skill recorded by session experience-s-83IFGT1L-turn-1U7M6O8-Q3B9XQHUYI, 2026-11-13T12:03:20Z
(in-package :nodecode.evolved)

(define-skill make-a-posture-the-default "Làm một tư thế prompt thành mặc định cho mọi bot OSA, kể cả bot sinh ra sau này."
 ;; when to use: người vận hành nói "mọi bot", "kể cả bot mới", "mặc định luôn" — không phải một bot cụ thể
 ;; 1. Chỗ sinh bot: prepend khối vào bots.create khi cờ đang bật, giữ nguyên instructions người dùng gõ.
 ;; 2. Chỗ nạp: hàm ensure_* quét bot thiếu marker, idempotent, gọi NGAY SAU settings.apply() trong hook startup, và log số lượng.
 ;; 3. Test cả hai chiều: bật thì có marker + phần thân còn nguyên, tắt thì không; gọi lần hai trả 0.
 ;; 4. Chạy full suite, rồi restart kiểu idle và đọc dòng log để chứng minh lượt quét đã chạy thật.
 ;; evidence: 2026-11-13 C46 — trước đó chỉ train tay từng bot; sau khi thêm ensure_modes vào startup, test 4/4 và suite 1229 pass, nhưng tiến trình đang chạy còn giữ code cũ nên lượt quét chưa được chứng minh cho tới khi restart.
 ;; confidence: medium — hai chỗ hook đúng, nhưng bằng chứng live chưa có trong lượt.
 )
