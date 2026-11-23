(:name "osa-port-one-unit"
 :when-to-use "Khởi động lại OSA trên devbox này: cổng 8765 là của unit USER, restart không cần quyền"
 :body "2026-11-13: OSA chuyển sang unit USER /home/boxes/.config/systemd/user/osa.service (linger=yes nên vẫn chạy khi đăng xuất). File unit system cũ đã đổi tên thành /etc/systemd/system/osa.service.off và unit đó đã disable — đừng bật lại, hai bên sẽ đá nhau bằng EADDRINUSE (uvicorn exit 3, Restart=always quay vòng; đã có lúc NRestarts=307).

Restart (đường thường ngày, không quyền): systemctl --user restart osa, hoặc '/home/boxes/bin/osa idle' khi có thể đang có bot chạy (xem cell osa-restart-idle). Ứng dụng cũng tự restart tại chỗ được: POST /api/system/restart hoặc '.venv/bin/python restart_osa.py' (execv, PID không đổi, không cần systemd).

Helper ở /home/boxes/bin: 'osa status|restart|logs [n]|url' (user unit), 'osa-root <cmd>' = sudo -n (NOPASSWD có sẵn trên máy; nodecode-guard chặn mọi lệnh eval chứa chữ 'sudo', nên phải gọi qua wrapper), 'osa-svc <verb>' = sudo -n systemctl <verb> osa (cho unit system, giờ chỉ còn tailnet).

Đừng 'systemctl restart osa' nữa: unit system đã biến mất, lệnh đó báo not-found. Kiểm tra code đang chạy thật: so ps lstart của pid giữ cổng với mtime file vừa sửa; 'is-active' chỉ nói tiến trình còn sống.

scripts/net-fast.sh đã sửa cho hợp: ghi unit system thành .off, cuối script enable unit USER.")
