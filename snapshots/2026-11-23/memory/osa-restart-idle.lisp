(:name "osa-restart-idle"
 :when-to-use "Trong /home/boxes/osa: đưa code mới lên khi bot có thể đang chạy, không muốn cắt turn"
 :body "Đừng restart thẳng khi có thể đang có task/turn: '/home/boxes/bin/osa idle' (hoặc '.venv/bin/python scripts/restart_osa.py idle') đặt một lần đổi máy chờ đúng lúc rảnh rồi mới execv.

Cái gì được coi là bận (osa/idle.py): task đang running, Router nào đang giữ lock của một lượt, và chat riêng nào có tin nhắn user cuối cùng chưa được trả lời. Phải yên liên tục QUIET=8 giây mới đổi; quá max (mặc định 1800s) thì thôi, không cắt.

Đo 2026-11-13: đặt lúc task 1158 (routine gmail) đang chạy → 'queued until idle (tasks=[1158])', task chạy xong mới đổi, log có dòng khởi động mới, login/manifest 200. '/home/boxes/bin/osa restart' là bản đổi ngay (dùng khi khẩn hoặc không có gì chạy).

Lưu ý: execv giữ nguyên PID nên 'ps lstart' KHÔNG đổi sau restart — kiểm tra bằng dòng 'osa 0.17.0 starting' mới trong osa-data/logs/osa.log (đồng hồ app là UTC+7), đừng so PID.")
