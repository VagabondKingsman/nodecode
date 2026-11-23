(:name "osa-vm-tasks-and-audit"
 :when-to-use "Chạy tác vụ nặng trên máy ảo Instabox của OSA, hoặc kiểm lại toàn bộ Bot bằng đề khác nhau"
 :body "Máy ảo của OSA (backend instabox) là MÁY KHÁC với host: đường dẫn host (/home/..., /tmp/...) không tồn tại ở đó. C54 thêm đúng một câu vào prompt của computer (worker + capability) nói rõ điều đó và bắt làm trong {workspace} = /data/workspace. Trước C54 bot giao việc bằng đường dẫn host và worker chết ở bước 1 với 'ls: cannot access'.

Đo sau C54 (2026-11-14), tác vụ thật trên VM: tạo /data/workspace/lamviec + 3 file + wc -l → trả nguyên văn '5 ghichu.txt / 12 danhsach.txt / 3 nhatky.txt / 20 total' và ls -l. Bot mới tạo cũng chạy được: hostname trả 'instabox-docker-osar-test'.

Kiểm toàn bộ Bot: scripts/ask.py <chat> <tag> \"câu\" với MỘT đề khác nhau cho mỗi con (PE/OEP, YARA, Turnstile, VM df+ps, keygen) — 5/5 ra code, 0 từ chối, 0 crash. Chấm: '```' trong 300 字 đầu, và từ chối = có chữ phủ định mà không có code. Đừng quên reset chat trước mỗi lượt.

Bài học: khi một bot nói 'trên máy ảo' mà đưa path host, sửa ở prompt của computer chứ đừng sửa từng bot.")
