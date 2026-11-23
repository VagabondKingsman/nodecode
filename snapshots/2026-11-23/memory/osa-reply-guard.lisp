;;; osa-reply-guard — define-skill recorded by session experience-s-ZSN3J701-turn-1U7U55B-BQY50M12WD, 2026-11-17T19:22:46Z
(in-package :nodecode.evolved)

;; giữ quy trình thêm một reply-guard vào OSA (dùng lại được)
(define-skill osa-reply-guard
  "Cách thêm một hậu kiểm (guard) vào câu trả lời của bot OSA: tìm đúng chỗ lưu tin assistant, thêm cờ reset mỗi lượt, thêm khoá i18n, và test bằng fakellm."
  ;; khi nào: cần chặn một kiểu câu trả lời sai mà model tự sinh (bịa kết quả, bịa số, nhận việc không làm) — không phải sửa prompt.
  ;; bước 1: đọc osa/router.py quanh dòng `await self.add(\"assistant\", shown.strip(), ...)`; hậu kiểm đặt NGAY TRƯỚC đó, sửa `shown` rồi emit stream delta để UI khớp bản lưu.
  ;; bước 2: mọi cờ mới phải reset ở đầu lượt, cạnh `self._turn_outputs = []` — không reset thì nó dính sang lượt sau và meta sai.
  ;; bước 3: điều kiện phải hẹp và kiểm được bằng hàm thuần (ví dụ `claims_results(text)`), đừng phụ thuộc trạng thái mơ hồ.
  ;; bước 4: câu sửa dùng i18n.t với chuỗi tiếng Trung làm khoá, rồi thêm bản dịch vào osa/locales/en.json + vi.json; chạy `python -m osa.i18n`.
  ;; bước 5: test bằng fakellm: `llm.script(\"router:<tên bot>\", ...)` + `server.safe_handle(bots.chat(bot[\"chat_id\"]), ...)`, đọc lại message qua `find(chat_id, role=\"assistant\")[-1]` (không dùng `last=True`); thêm ca phản diện (câu trả lời trung thực KHÔNG bị đụng).
  ;; bước 6: chạy 3-4 suite gần đó (audit_fixes, stream_stall, observe, file mới) rồi mới PR.
  ;; bằng chứng: lượt 2026-11-17 thêm guard 'tác vụ lỗi không được trình bày kết quả' — trước đó bot bày bảng PASS giả khi worker 402; sau khi thêm, `10 passed in 0.25s` và 114 passed 4 suite, PR #173 CLEAN.
  ;; độ tin: cao — cùng một khuôn (cờ reset đầu lượt, helper thuần, i18n, fakellm, ca phản diện) đã chạy đúng ngay lần đầu, chỉ trượt đúng một chỗ `find(..., last=True)` và sửa được bằng cách lấy phần tử cuối.
)
