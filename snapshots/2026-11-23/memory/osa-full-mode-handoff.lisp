(:name "osa-full-mode-handoff"
 :when-to-use "Bắt đầu phiên mới làm OSA full mode: đọc bàn giao ở đâu, còn mở gì"
 :body "Bàn giao 13–14/11 đã merge vào `i18n-vi`: `.agents/log/2026-11-14-cursor-unrestricted-full-mode.md` (17 PR C41–C58, bảng Evidence có dòng PARTIAL, cấu hình đang chạy, mục Còn mở). `HANDOFF.md` trỏ tới nó; `STATE.md` đánh dấu snapshot cũ.

Việc đầu phiên sau, theo thứ tự trong log: (1) cho nhánh **huỷ** task cũng đánh thức (`cancel()` không đi qua `_publish`) rồi chứng minh wake bằng một task ngắn KHÔNG chạm VM; (2) `LEARNED SHAPES` còn rỗng — cần một đề mà model mặc định từ chối mới thấy C53 chạy; (3) model của vai hay bị đổi ngoài ý muốn — đọc CFG trước khi báo 'full mode'.

Đừng cài lại từ đầu: charter, sáu biên giới, cứu hộ, C46, C54, C56 đều đã ở tầng core.")
