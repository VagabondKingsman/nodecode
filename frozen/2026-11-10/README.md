# Đóng băng image Nodecode — 2026-11-10T20:56Z

Một **cos thể** (organism) Lisp đang sống được đóng băng ra khỏi sandbox `/home/boxes`
sang đĩa bền `/project` (archil, aws-us-west-2). Ba lớp, vì mỗi lớp sống lại theo một cách:

| Lớp | File | Chứa gì | Sống lại bằng |
|---|---|---|---|
| Portable home | `home-portable.tar.gz` (16K) | config.jsonc, `cells/cursor-agent/` (layer + git history) | `tar xzf` vào `$NODECODE_HOME` |
| Home còn lại | `home-rest.tar.gz` | context/, hub/, generations/, composer-*, secrets (`auth.json`, `operator-token`) | `tar xzf` |
| Store | `store/history.db{,-wal,-shm}` | toàn bộ hội thoại, checkpoint, session | `--store` |
| **Heap** | `heap-snapshot.tar.gz` | organism đang chạy, **nguyên heap**: values, closures, định nghĩa không file nào giữ | `nodecode snapshots` + switch |
| Release | `release-98dd6dc80/` | chính binary + source đã biên dịch (104M) — để khỏi tải mạng | chạy trực tiếp |
| Git thuần | `layer.bundle` | layer dưới dạng git bundle | `git clone layer.bundle` |

## Đã chứng minh (không phải suy đoán)

1. `sha256sum -c SHA256SUMS` — toàn vẹn.
2. Bung `home-portable.tar.gz` vào `/tmp/proof` → layer file **byte-identical** với bản đang sống.
3. Boot **organism thứ hai** từ artifact:
   `NODECODE_HOME=/tmp/proof/.nodecode release-98dd6dc80/nodecode serve --store …`
   → log: `cell cursor-agent: layer, 1 definition, unsealed` / `gateway ready` / `serving … on port 32795`.
   Tức layer của tôi tự nạp lại và chạy được ở tiến trình khác.

## Giới hạn phải biết

- **Heap snapshot không portable giữa các release**: nó là heap của đúng release `98dd6dc80`.
  Đổi bản nodecode thì dùng `home-*` + `store` (định nghĩa nằm trong layer dạng văn bản, luôn load lại được).
- **Có bí mật trong đây**: `auth.json`, `operator-token`. Chỉ để trên đĩa tin được.
- `history.db-wal` được copy khi organism đang chạy → sqlite sẽ replay WAL lúc mở; mất tối đa vài frame cuối.
- Snapshot heap của lần đóng băng này được CLI xếp hàng *sau* turn đang chạy; `finish-freeze.sh`
  chờ nó rơi xuống rồi mới khoá. Xem `freeze.log` để biết đã xong chưa.

## Khôi phục

    ./restore.sh /tmp/restored          # kiểm checksum + bung mọi lớp
    NODECODE_HOME=/tmp/restored/.nodecode ./release-98dd6dc80/nodecode

## Nguồn gốc

- box: `e2b.local` (VM, systemd PID 1), `/home/boxes/.nodecode`
- phiên: `s-1CKKCZWG`, model `nodecode-cyber-v1` (provider `nodecode-free`, effort high)
- release: `98dd6dc80`, generations đã niêm phong: `generations/1..3.json`
- layer: `cells/cursor-agent/demo_sum-sq.lisp` (định nghĩa duy nhất, đã patch sang dạng đóng)
