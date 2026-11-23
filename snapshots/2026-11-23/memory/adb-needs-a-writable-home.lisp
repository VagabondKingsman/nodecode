;;; adb-needs-a-writable-home — define-skill recorded by session experience-s-ZSN3J701-turn-1U7U3RG-9T5K26N7ZP, 2026-11-17T18:50:35Z
(in-package :nodecode.evolved)

(define-skill adb-needs-a-writable-home
  "Cho adb một HOME ghi được trước khi tin bất cứ lỗi 'no device'/'no root' nào trong shell của bot/task."
  ;; when: một bot hoặc task worker chạy adb trên computer và báo không thấy thiết bị / không có root, dù máy Android vẫn đang chạy
  ;; chạy adb kill-server, đặt HOME sang thư mục ghi được (ví dụ /tmp/adbhome), mkdir $HOME/.android, adb start-server, adb connect <serial>
  ;; adb -s <serial> root; sleep 2; connect lại (adbd restart làm rớt kết nối)
  ;; chỉ sau đó mới chạy phép kiểm thật (--check), và chỉ tin kết quả của nó
  ;; evidence: shell tối giản in "adb: Cannot mkdir '/home/user/.android': No such file or directory" rồi "Aborted"; script kết luận oan "设备没有 root 权限" exit=1. Sau khi thêm connect-adb.sh: "HOME=/tmp/adbhome", "uid=0(root)", "--check 环境自检通过 exit=0"
  ;; confidence: high — tái hiện được hai chiều (env -i hỏng, có connect-adb.sh thì xanh)
)
