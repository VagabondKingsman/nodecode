;;; gzip-middleware-verify — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7HQN0-BOF116OFX7, 2026-11-11T02:25:01Z
(in-package :nodecode.evolved)

(define-skill gzip-middleware-verify
  "Trước khi báo xong một thay đổi nén/encoding ở server, chứng minh từng response giải nén ra đúng byte gốc và trang vẫn render trong trình duyệt."
  ;; when: a middleware or static server starts compressing responses (gzip/br/deflate), or a page suddenly renders blank/dark with CSS intact
  ;; 1. curl -H 'Accept-Encoding: gzip' URL -o /tmp/x.gz -D /tmp/x.h — đọc content-encoding thật trong header
  ;; 2. so gunzip -c /tmp/x.gz | wc -c với bản không nén (hoặc với file trên đĩa); lệch = khai báo encoding sai
  ;; 3. khai báo gzip thì compressor phải là zlib.compressobj(6, zlib.DEFLATED, 16 + 15); wbits -15 là raw deflate, đúng với 'deflate' chứ không phải 'gzip'
  ;; 4. lặp cho mọi route text (HTML, JSON) và mọi asset đầu vào, rồi render bằng chrome --headless --screenshot và xem ảnh
  ;; evidence: turn này — /login "wire=1053B plain=2054B decoded=2054B OK" sau khi đổi sang 16+15, trước đó "gunzip -> 37 bytes" và màn hình đen; sau cùng headless báo "els:743"
  ;; confidence: high — lỗi và bản sửa chỉ khác một tham số, đo lại đúng cùng URL
  )
