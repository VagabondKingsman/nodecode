;;; devbox-platform-vs-local — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7TEKS-WSIIL82VJC, 2026-11-17T09:37:29Z
(in-package :nodecode.evolved)

(define-skill devbox-platform-vs-local "Phân biệt lỗi do nền tảng boxes.dev với lỗi cấu hình trên máy trước khi sửa gì trên máy"
  ;; khi lệnh dvb-onbox (giữ máy, hẹn giờ, ports, threads) trả service_unavailable hoặc treo, và ta định sửa PATH/quyền/cấu hình trên máy
  ;; đọc cuối ~/.devbox/daemon/sprite-daemon.log: dòng onbox_keep_awake (hay hàm Convex tương ứng) kèm status= và duration_ms
  ;; nếu status=503 mà duration_ms chỉ vài chục ms và việc khác qua cùng daemon vẫn status=ok (codex_read_thread, jsonl sync) thì lỗi ở backend của họ, không phải trên máy
  ;; khi đó chỉ cần: để nhịp thử lại với backoff, và gửi họ tên hàm + một request_id + mốc giờ; đừng sửa PATH/quyền/token
  ;; nếu ngược lại (daemon chết, 401, 404, hoặc lệnh không thấy) mới sửa trên máy
  ;; evidence: 17/11 09:35 lượt đo — sprite-daemon.log 122 lần "threadKeepAwakeHolds ... status=503 ... duration_ms=85" trong khi cùng daemon trả codex_read_thread status=ok; trước đó tôi đã đi sửa PATH của unit và thêm guard trong script, đều không đổi được 503
  ;; confidence: high — hai đường độc lập (keep-awake và schedule) cùng 503 trong khi đường khác qua cùng daemon vẫn ok
  )
