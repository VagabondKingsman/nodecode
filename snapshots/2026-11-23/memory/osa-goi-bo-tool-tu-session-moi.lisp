;;; osa-goi-bo-tool-tu-session-moi — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U7Z3DI-LJ0YEFF7DG, 2026-11-20T11:21:33Z
(in-package :nodecode.evolved)

(define-skill osa-goi-bo-tool-tu-session-moi
  "Gọi bộ tool Pro từ bất kỳ session Nodecode nào trên box này: `sh /home/boxes/.local/share/nodecode/bo-tool-pro/chay.sh <lệnh>` (thêm `nen` ở đầu cho bước lâu, xem bằng `ib.sh log`)."
  ;; khi nào: cần đăng nhập/chạy chuỗi 3-12-6-6 hoặc huỷ gói/xoá thẻ trên máy ảo Instabox mà chưa nhớ lệnh
  ;; 1. sh /home/boxes/.local/share/nodecode/bo-tool-pro/chay.sh kiem-tra — phải toàn ✅ (adb, Android, Magisk, frida, module_521, số tài khoản)
  ;; 2. chay.sh tự đánh thức máy nếu chưa ready, tự giải nén /tmp/botool.tgz sang /data/workspace/botool khi thiếu
  ;; 3. bước ngắn: sh chay.sh <lệnh> --mat-khau .. ; bước lâu: sh chay.sh nen <lệnh> .. rồi sh .../ib.sh log
  ;; 4. 2 lớp: bấm Yes trên điện thoại thật rồi chạy lại dang-nhap với --so <số trên màn hình máy ảo>
  ;; 5. cấu hình (serial/container/thẻ) nằm ở /data/workspace/botool/cau-hinh.json trên máy
  ;; evidence: turn 20/11 — sau khi đóng gói, chạy `chay.sh kiem-tra` từ host ra "✅ adb tới 127.0.0.1:5558: OK … ✅ Số tài khoản trên máy: 0", và `chay.sh nen xem-goi` + `ib.sh log` trả đúng output pro.py
  ;; confidence: high — đã chạy thật cả chế độ đồng bộ và chế độ nền trong turn này
  )
