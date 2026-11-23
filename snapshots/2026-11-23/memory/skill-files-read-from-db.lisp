;;; skill-files-read-from-db — define-skill recorded by session s-ZSN3J701, 2026-11-17T17:28:38Z
(in-package :nodecode.evolved)

(define-skill skill-files-read-from-db
   "Từ 2026-11-17 OSA đọc file của skill từ hai nguồn: pack trên đĩa ($OSA_DATA_DIR/skill-packs/ai-native/<tên>/) trước, thiếu thì lấy cột skills.files trong DB (PR #172). Bot gọi read_skill_resource(name, path='') để liệt kê, path='<tên file>' để đọc; load_skill trả thêm files + resource_hint khi chỉ có bản trong kho. Không cần cài pack nữa; lỗi 'No installed resources' chỉ còn khi không có cả hai.
;; when: nghĩ một thay đổi của kho skill (đọc/ghi file đính kèm) đã thật sự tới tay bot
;; evidence: 2026-11-17 read_skill_resource trả 'No installed resources' dù skill có file trong DB; sau khi vá + restart mềm, bot 8 đọc đúng nội dung file chỉ-có-trong-DB
;; confidence: high (test đơn vị + một lượt bot thật trên service đang chạy)
;; steps: 1) skills.save một skill tạm chỉ có file trong DB, không tạo pack trên đĩa; 2) POST /api/system/restart?when=idle; 3) nhờ một bot gọi read_skill_resource(path='') rồi path='<tên file>' và dán nguyên văn; 4) xoá skill tạm và kiểm list_for không còn tên đó")
