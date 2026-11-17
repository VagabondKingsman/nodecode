#!/usr/bin/env bash
# Sau khi box tỉnh dậy (hoặc vừa boot): dựng lại những gì phải luôn sống.
#
# Box ngủ thì tiến trình đông cứng; nếu nó *dừng* (host thu hồi) thì unit nào chết sẽ được
# systemd dựng lại, nhưng cái gì chưa chết mà đã hỏng (đứt mạng, WS rỗng) thì không ai sửa.
# Đây là chỗ sửa: chạy sau sleep.target, và lúc boot.
set -uo pipefail

LOG="${HOME}/.nodecode/resume-heal.log"
say() { printf '%s %s\n' "$(date -u +%FT%TZ)" "$*" | tee -a "$LOG" >&2; }

# một tiến trình chết thì systemd (Restart=always) đã lo; ở đây chỉ lo ca còn sống mà hỏng
systemctl --user start osa.service >/dev/null 2>&1 || true
systemctl --user start nodecode-gateway.service >/dev/null 2>&1 || true

# OSA: health phải trả 200, không thì khởi động lại
if ! curl -fsS -m 10 -o /dev/null http://127.0.0.1:8765/manifest.json; then
  say "OSA không trả lời sau khi tỉnh — khởi động lại"
  systemctl --user restart osa.service >/dev/null 2>&1 || true
fi

# giữ box ngay, đừng đợi nhịp timer kế tiếp
command -v keep-awake.sh >/dev/null 2>&1 && keep-awake.sh >/dev/null 2>&1 || true

say "xong (osa=$(systemctl --user is-active osa.service) gateway=$(systemctl --user is-active nodecode-gateway.service))"
exit 0
