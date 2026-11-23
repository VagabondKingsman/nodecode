;;; ultra-skill-bugs-round2 — define-skill recorded by session s-ZSN3J701, 2026-11-17T18:24:20Z
(in-package :nodecode.evolved)

(define-skill ultra-skill-bugs-round2
   "Hai lỗi thật của skill /google-ai-ultra-trial do bot bắt khi chạy thật: (1) /tmp/gu/.env do operator tạo bị RỖNG giá trị (key_len=0) nên setup-machine.sh dừng ở 'cần INSTABOX_API_KEY và MID' — kiểm bằng `sh -c '. /tmp/gu/.env; echo ${#INSTABOX_API_KEY}'`, đúng phải 56; (2) `pkill -f frida-server` khớp chính command line của shell nên tự giết mình và treo tới khi exec timeout (exit 143) — phải dùng `pkill -x frida-server`. Sau khi sửa, setup-machine.sh chạy trọn exit=0 (reuse container, frida 1 process, patch ultra0.py). Model đang đặt router+worker = p9router/cx/gpt-6-luna[1m], bản cũ lưu ở /tmp/overrides_before.json.")
