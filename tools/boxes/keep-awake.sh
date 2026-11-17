#!/usr/bin/env bash
# Giữ box boxes.dev khỏi tự đi ngủ, để task trên nodecode và tiến trình OSA không bị cắt.
#
# Vì sao cần: boxes.dev cho box ngủ khi không còn ai nhìn terminal (ví dụ điện thoại đã tắt app).
# Một cái giữ (keep-awake hold) do ta tự gia hạn thì box ở lại; hết hạn mà không ai gia hạn thì
# box lại ngủ như cũ. Mức trần một lần giữ là 4 giờ, nên phải gia hạn định kỳ.
#
# Chạy bởi box-keepawake.timer (mỗi 10 phút). Cài:
#   cp tools/boxes/keep-awake.sh ~/.local/bin/
#   cp tools/boxes/systemd/box-keepawake.* ~/.config/systemd/user/
#   systemctl --user daemon-reload && systemctl --user enable --now box-keepawake.timer
#
# Biến:
#   KEEPAWAKE_FOR=30m        mỗi lần giữ bao lâu (trần của boxes.dev: 4h)
#   KEEPAWAKE_CADENCE_S=600  nhịp gia hạn; hold còn dài hơn 2 nhịp thì thôi không gọi
#   KEEPAWAKE_REASON="..."   lý do ghi vào hold
#
# Mã thoát: 0 = đang có hold đủ dài hoặc vừa đặt được; 1 = không đặt được (lần sau timer thử lại).
set -uo pipefail

STATE="${HOME}/.nodecode/box-keepawake"
mkdir -p "$STATE"
LOG="$STATE/log"
IDFILE="$STATE/thread-id"
if [ ! -s "$IDFILE" ]; then
  (cat /proc/sys/kernel/random/uuid 2>/dev/null || uuidgen) > "$IDFILE"
fi
# Lệnh của boxes.dev đòi biết đang chạy trong "thread" nào. Nodecode không đặt biến đó, nên ta tự giữ một id cố định.
export BOXES_CLIENT_THREAD_ID="${BOXES_CLIENT_THREAD_ID:-$(cat "$IDFILE")}"

FOR="${KEEPAWAKE_FOR:-30m}"
CADENCE="${KEEPAWAKE_CADENCE_S:-600}"
REASON="${KEEPAWAKE_REASON:-giữ box cho task đang chạy (nodecode/OSA)}"

say() { printf '%s %s\n' "$(date -u +%FT%TZ)" "$*" | tee -a "$LOG" >&2; }

if [ "${1:-}" = "--selftest" ]; then
  # Tự kiểm không cần mạng: một `dvb-onbox` giả đọc câu trả lời từ tệp trong $tmp.
  tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
  recover() { rm -rf "$tmp"; }
  cat > "$tmp/dvb-onbox" <<'STUB'
#!/usr/bin/env bash
case "$1 $2 $3" in
  "devboxes keep-awake get") cat "$STUBDIR/get" 2>/dev/null ;;
  "devboxes keep-awake set") cat "$STUBDIR/set" 2>/dev/null ;;
esac
exit 0
STUB
  chmod +x "$tmp/dvb-onbox"
  run() { STUBDIR="$tmp" PATH="$tmp:$PATH" bash "$0"; echo "rc=$?"; }
  fut=$(python3 -c 'import datetime,time;print((datetime.datetime.now(datetime.UTC)+datetime.timedelta(hours=1)).isoformat().replace("+00:00","Z"))')
  printf '{"ok":true,"hold":{"endsAt":"%s"}}' "$fut" > "$tmp/get"; : > "$tmp/set"
  echo "-- hold còn 1 giờ: phải bỏ qua (rc=0, in 'hold còn')"
  run | tail -2
  printf '{"ok":true,"hold":null}' > "$tmp/get"; printf '{"ok": true}' > "$tmp/set"
  echo "-- không có hold, đặt được: phải gọi set (rc=0, in 'đã giữ box')"
  run | tail -2
  : > "$tmp/get"; printf '{"ok": false, "errorCode": "service_unavailable"}' > "$tmp/set"
  echo "-- không có hold, set hỏng cả 3 lần: rc=1"
  run | tail -1
  exit 0
fi

ends_in() {   # đọc JSON của `get`, in ra số giây còn lại của hold (rỗng nếu không có). phải là -c: heredoc sẽ nuốt stdin
  python3 -c '
import json, sys, time, datetime
try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
hold = d.get("hold") or {}
end = hold.get("endsAt") or hold.get("expiresAt") or d.get("endsAt")
if not end:
    sys.exit(0)
try:
    t = datetime.datetime.fromisoformat(str(end).replace("Z", "+00:00")).timestamp()
except Exception:
    sys.exit(0)
print(int(t - time.time()))
'
}

current=$(dvb-onbox devboxes keep-awake get --json 2>/dev/null || true)
left=$(printf '%s' "$current" | ends_in)
if [ -n "$left" ] && [ "$left" -gt $((CADENCE * 2)) ]; then
  echo "hold còn ${left}s, đủ dùng"
  exit 0
fi

for try in 1 2 3; do
  if out=$(dvb-onbox devboxes keep-awake set --for "$FOR" --reason "$REASON" \
             --idempotency-key "$(cat /proc/sys/kernel/random/uuid)" --json 2>&1); then
    if printf '%s' "$out" | grep -q '"ok": true'; then
      say "đã giữ box ${FOR} (lần thử ${try})"
      exit 0
    fi
  fi
  say "lần ${try} không đặt được: $(printf '%s' "$out" | tr '\n' ' ' | cut -c1-160)"
  [ "$try" -lt 3 ] && sleep $((try * 20))
done
exit 1
