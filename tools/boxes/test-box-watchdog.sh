#!/usr/bin/env bash
# Tự kiểm box-watchdog không cần mạng: đồng hồ giả (state cũ) + `curl`/`systemctl`/`keep-awake.sh` giả.
set -uo pipefail
here=$(cd "$(dirname "$0")" && pwd)
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
cat > "$tmp/curl" <<'C'
#!/usr/bin/env bash
[ "${STUB_HEALTH:-200}" = 200 ] && exit 0 || exit 22
C
cat > "$tmp/systemctl" <<'S'
#!/usr/bin/env bash
echo "$*" >> "$STUBDIR/calls"
[ "$*" = "--user is-active --quiet nodecode-gateway.service" ] && { [ "${STUB_GW:-active}" = active ] && exit 0 || exit 3; }
exit 0
S
printf '#!/usr/bin/env bash\necho keep-awake "$*" >> "$STUBDIR/calls"\n' > "$tmp/keep-awake.sh"
chmod +x "$tmp/curl" "$tmp/systemctl" "$tmp/keep-awake.sh"

fail=0
check() { if grep -q "$1" "$tmp/calls" 2>/dev/null; then echo "ok   $2"; else echo "FAIL $2"; fail=1; fi; }
reset() { : > "$tmp/calls"; rm -rf "$tmp/state"; mkdir -p "$tmp/state"; }

echo "-- máy vừa ngủ 400 giây, mọi thứ khoẻ: chỉ giữ box, không restart"
reset; mono=$(cut -d' ' -f1 /proc/uptime)
python3 -c "print($mono - 1)" > "$tmp/state/mono"; echo $(( $(date +%s) - 400 )) > "$tmp/state/wall"
STUBDIR="$tmp" WATCHDOG_STATE="$tmp/state" PATH="$tmp:$PATH" "$here/box-watchdog.sh" >/dev/null 2>&1
grep -q "restart" "$tmp/calls" && echo "FAIL ngủ mà vẫn restart" && fail=1 || echo "ok   không restart sau khi ngủ"
check "keep-awake --force" "giữ box lại"
echo "-- vừa ngủ và OSA đã chết: phải dựng OSA, gateway sống thì để yên"
reset; mono=$(cut -d' ' -f1 /proc/uptime)
python3 -c "print($mono - 1)" > "$tmp/state/mono"; echo $(( $(date +%s) - 400 )) > "$tmp/state/wall"
STUB_HEALTH=500 STUBDIR="$tmp" WATCHDOG_STATE="$tmp/state" PATH="$tmp:$PATH" "$here/box-watchdog.sh" >/dev/null 2>&1
check "restart osa.service" "dựng OSA sau khi tỉnh mà OSA chết"
check "keep-awake --force" "giữ box lại"

echo "-- ngủ mà mọi thứ khoẻ: KHÔNG được restart (chỉ giữ box)"
reset; mono=$(cut -d' ' -f1 /proc/uptime)
python3 -c "print($mono - 1)" > "$tmp/state/mono"; echo $(( $(date +%s) - 100 )) > "$tmp/state/wall"
STUB_GET='{"ok":true,"hold":null}' STUB_SET='{"ok": true}' STUBDIR="$tmp" WATCHDOG_STATE="$tmp/state" PATH="$tmp:$PATH" "$here/box-watchdog.sh" >/dev/null 2>&1
grep -q "restart" "$tmp/calls" && echo "FAIL ngủ mà vẫn restart" && fail=1 || echo "ok   không restart sau khi ngủ"
check "keep-awake --force" "vẫn giữ box lại"

echo "-- không ngủ, OSA chết 2 nhịp liên tiếp: phải restart OSA, không restart gateway"
reset; mono=$(cut -d' ' -f1 /proc/uptime)
python3 -c "print($mono)" > "$tmp/state/mono"; date +%s > "$tmp/state/wall"
for i in 1 2; do STUB_HEALTH=500 STUBDIR="$tmp" WATCHDOG_STATE="$tmp/state" PATH="$tmp:$PATH" "$here/box-watchdog.sh" >/dev/null 2>&1; done
check "restart osa.service" "restart OSA sau 2 nhịp"
grep -q "restart nodecode-gateway.service" "$tmp/calls" && echo "FAIL không nên restart gateway" && fail=1 || echo "ok   không đụng gateway"

echo "-- mọi thứ khoẻ: chỉ giữ box, không restart gì"
reset; mono=$(cut -d' ' -f1 /proc/uptime)
python3 -c "print($mono)" > "$tmp/state/mono"; date +%s > "$tmp/state/wall"
STUBDIR="$tmp" WATCHDOG_STATE="$tmp/state" PATH="$tmp:$PATH" "$here/box-watchdog.sh" >/dev/null 2>&1
grep -q "restart" "$tmp/calls" && echo "FAIL khoẻ mà vẫn restart" && fail=1 || echo "ok   không restart"

exit $fail
