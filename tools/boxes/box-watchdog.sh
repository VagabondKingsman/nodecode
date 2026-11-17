#  -*- mode: shell-script -*-
# Một nhịp canh box: (a) thấy máy vừa ngủ thì dựng lại việc, (b) thấy OSA/gateway chết hay treo thì
# dựng lại, (c) luôn cố giữ box khỏi ngủ tiếp. Chạy bởi box-watchdog.timer mỗi 30 giây.
#
# Vì sao phải đo bằng ĐỒNG HỒ: host cho box ngủ là tiến trình đông cứng, không có suspend.target
# trong systemd user, nên cách duy nhất biết "vừa ngủ" là so đồng hồ thật với đồng hồ đơn điệu
# (máy ngủ thì monotonic đứng, wall vẫn chạy). Lệch > 60 giây là một lần ngủ.
set -uo pipefail

STATE="${WATCHDOG_STATE:-${HOME}/.nodecode/box-watchdog}"
mkdir -p "$STATE"
LOG="$STATE/log"
say() { printf '%s %s\n' "$(date -u +%FT%TZ)" "$*" | tee -a "$LOG" >&2; }

SLEEP_GAP="${WATCHDOG_SLEEP_GAP_S:-60}"
FAIL_LIMIT="${WATCHDOG_FAIL_LIMIT:-2}"

mono=$(cut -d' ' -f1 /proc/uptime)
wall=$(date +%s)
prev_mono=$(cat "$STATE/mono" 2>/dev/null || echo "$mono")
prev_wall=$(cat "$STATE/wall" 2>/dev/null || echo "$wall")
printf '%s\n' "$mono" > "$STATE/mono"; printf '%s\n' "$wall" > "$STATE/wall"

# Sau một lần ngủ thì DỰNG LẠI CẢ HAI, không chỉ khi thấy chết: ngủ làm đứt mọi kết nối
# (provider, WebSocket của điện thoại), tiến trình "vẫn sống" sau đó thường là nửa hỏng.
heal() {
  say "dựng lại: $1"
  systemctl --user restart osa.service >/dev/null 2>&1 || true
  systemctl --user restart nodecode-gateway.service >/dev/null 2>&1 || true
  command -v keep-awake.sh >/dev/null 2>&1 && keep-awake.sh --force >/dev/null 2>&1 || true
}

# (a) máy vừa ngủ?
gap=$(python3 -c "print(int(($wall - $prev_wall) - ($mono - $prev_mono)))" 2>/dev/null || echo 0)
if [ "${gap:-0}" -gt "$SLEEP_GAP" ]; then
  say "máy vừa ngủ ${gap}s"
  heal "sau khi ngủ ${gap}s"
fi

# (b) OSA còn trả lời? đếm 2 nhịp liên tiếp mới dựng, đừng giật khi một lần chậm
fails=$(cat "$STATE/osa-fails" 2>/dev/null || echo 0)
if curl -fsS -m 5 -o /dev/null http://127.0.0.1:8765/manifest.json 2>/dev/null; then
  [ "$fails" != 0 ] && printf '0\n' > "$STATE/osa-fails"
else
  fails=$((fails + 1)); printf '%s\n' "$fails" > "$STATE/osa-fails"
  if [ "$fails" -ge "$FAIL_LIMIT" ]; then
    say "OSA không trả lời ${fails} nhịp — khởi động lại"
    systemctl --user restart osa.service >/dev/null 2>&1 || true
    printf '0\n' > "$STATE/osa-fails"
  fi
fi

# gateway: unit sống thì thôi
if ! systemctl --user is-active --quiet nodecode-gateway.service; then
  say "gateway không chạy — bật lại"
  systemctl --user start nodecode-gateway.service >/dev/null 2>&1 || true
fi

# (c) giữ box: gọi keep-awake, nó tự bỏ qua khi còn hold đủ dài và tự backoff khi API hỏng
if command -v keep-awake.sh >/dev/null 2>&1; then
  keep-awake.sh >/dev/null 2>&1 || true
fi
exit 0
