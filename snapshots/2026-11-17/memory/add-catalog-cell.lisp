;;; add-catalog-cell — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7HDA5-MJXRBX35SG, 2026-11-10T21:36:45Z
(in-package :nodecode.evolved)

;; giữ thủ tục: cài 1 cell từ catalog + xác nhận nạp như đã làm lượt này
(define-skill add-catalog-cell
  "Cài một cell từ catalog Nodecode và xác nhận nó thực sự nạp, không tin mỗi receipt 'is on'."
  ;; when-to-use: khi operator hỏi 'soi danh mục xem có gì đáng thêm' hoặc muốn thêm một cell từ hub
  ;; evidence: lượt này `nodecode add nc://live-time --yes` in 'live-time is on' cho cả 4 cell, rồi /doctor in 'cells 24 loaded', rồi (help :ports) trả manual đầy đủ — receipt một mình không đủ, phải đọc lại bằng /doctor hoặc (help :<cell>).
  ;; confidence: high — chuỗi lệnh chạy trọn 4 lần liên tiếp trong lượt này, xác nhận bằng hai kênh khác nhau
  ;; 1. Lấy index hub một lần: curl -sS https://raw.githubusercontent.com/nodecode-ai/cells/main/index.json -o /tmp/cells-index.json (765 cell, trường category/name/description/serves; serves vắng = không cần key).
  ;; 2. Lọc bằng python3 theo category + từ khoá, loại ~/.nodecode/cells đã có, để ra danh sách ngắn thay vì đọc cả 765.
  ;; 3. Cài từng cái: nodecode add nc://<tên> --yes (tự bật), rồi (restart-cells).
  ;; 4. Xác nhận bằng hai kênh: (help :<tên>) phải trả manual, và (fboundp (find-symbol "TASK" :<pkg>)) phải trả một function ⇒ cell đăng ký API thật. `nodecode doctor` KHÔNG có trong bản 98dd6dc80 ("no command doctor") — đừng chờ nó. Dấu vết bền nằm ở ~/.nodecode/generations/<số mới nhất>.json: một dòng {"name":"nodecode-<tên>","kind":"cell","origin":"hub","revision":…}, tức là boot sau vẫn nạp.
  ;; 5. Chỉ đề xuất tiếp nhóm 'rẻ + auto' (heartbeat, telemetry, doc-markdown, tool-break) sau khi operator chọn, đừng cài hàng loạt.
  ;; 6. Cell có API riêng thì smoke bằng một lệnh không tốn tiền trước, rồi một task thật nhỏ. subagents 2026-11-11: (subagents:agents "list") báo 'no current subagents team; create one with the task tool' khi chưa có team (đúng, không phải lỗi cài); (subagents:task '((:name "smoke" :task "Reply with exactly one word: ok")) :await t :timeout-seconds 180) chạy trọn — trả team, board #agents-…, một dòng IRC báo done.
  )
