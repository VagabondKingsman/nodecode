;;; google-ultra-runbook-in-osa — define-skill recorded by session s-ZSN3J701, 2026-11-17T16:41:41Z
(in-package :nodecode.evolved)

(define-skill google-ultra-runbook-in-osa
   "Quy trình mở Google AI Ultra 12 tháng $0 đã đóng gói thành skill TOÀN CỤC trong OSA (`/google-ai-ultra-trial`, skills.id 21, kèm ui.py, billing_probe.py, setup-machine.sh, install-gapps.sh, keepalive.sh, ultra0-osa.patch) — mọi bot thấy nó qua summary và đọc bằng `load_skill(name, offset)` (KHÔNG có tham số file) và `read_skill_resource(name, path)` — mà read_skill_resource chỉ đọc pack trên đĩa, nên file phải nằm ở `<OSA_DATA_DIR>/skill-packs/ai-native/google-ai-ultra-trial/` chứ không chỉ trong cột files của DB. Cần thêm một号: takeover máy, ADB_SERIAL=127.0.0.1:5556, --check xanh, sign-in có 2FA người thật, cài Google One, probe để lấy offer eft-12month, thẻ phải có tiền, chỉ bấm khi $0.")
