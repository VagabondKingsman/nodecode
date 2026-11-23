;;; verify-model-pin-proved — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7KUXS-OX4AVDV536, 2026-11-12T18:50:23Z
(in-package :nodecode.evolved)

(define-skill verify-model-pin-proved #>END
Chứng minh một model pin thật sự có hiệu lực bằng usage_rollup của store, không tin config hay receipt.
;; when to use
;; khi vừa đổi model/provider của image hoặc session và cần bằng chứng pin đã ăn
;; bước 1: (session-model-selection SESSION) trả tên provider — chỉ là config, chưa đủ
;; bước 2: bảng turn_spans KHÔNG có cột model; dùng usage_rollup (bucket, provider, model, rounds)
;; bước 3: sqlite3 -readonly /home/boxes/.nodecode/history.db "select bucket, provider, model, rounds from usage_rollup where session_id='...' order by bucket desc limit 4"
;; bước 4: dòng mới nhất phải mang đúng provider+model vừa pin; cộng thêm một lệnh gọi thật trả lời được
;; evidence
;; (store-q "select model, provider, at from turns ...") -> no such table: turns; .schema turn_spans chỉ có turn_id, session_id, started_at, ended_at, kind, reflection; usage_rollup thì có provider+model và trả "18:45|experientiallabs|deepseek-v4.1-flash-uncensored|14"
;; confidence high: hai bảng đã đọc schema thật trong turn
END)
