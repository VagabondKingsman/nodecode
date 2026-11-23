# Hai account nodecode.ai free trong một home: tự chuyển khi cạn hạn mức

Dựng trên box `boxes`, 2026-11-23, cho bản `0.1.16+c78fef6`. Mục tiêu: account A và B, cùng free plan, cùng `nodecode-cyber-v1`; A cạn 10M token/24h thì lượt sau (và ngay trong lượt đang chạy) đi bằng B, **không mất context**, không phải đăng nhập lại.

Bản gốc của các script nằm trong repo này: `tools/free-accounts/` (bốn script + hai unit). Trên một máy mới, chép chúng vào `~/.nodecode/bin/` và `~/.config/systemd/user/` rồi `chmod 755`.

## 1. Đã cài gì

| Tệp | Việc nó làm |
|---|---|
| `~/.nodecode/free-accounts.json` (0600) | hai account: `a`, `b` — mỗi cái một `key`, và `down_until` khi bị đánh dấu nghỉ |
| `~/.nodecode/bin/free-route` | chọn key: `a`/`b` (in key), `status`, `set b` (đọc key từ stdin), `clear b`, `down a 3600`, `up a` |
| `~/.nodecode/bin/free-route-a`, `free-route-b` | hai vỏ 2 dòng, để `config.jsonc` gọi đúng account của provider id |
| `~/.nodecode/bin/free-watch` | đọc `history.db`, thấy một account bị 429 thì đánh dấu nó nghỉ **đúng tới mốc reset API nói** |
| `~/.nodecode/free-route.log` | mỗi lần chọn key một dòng: `epoch provider-id account` |
| `free-watch.timer` (systemd user) | chạy `free-watch` mỗi 5 phút |

`config.jsonc` đã có:

```jsonc
"providers": {
  "nodecode-free": { "sdk": "openai-completions", "base_url": "https://api.nodecode.ai/v1",
                     "api_key": "!/home/boxes/.nodecode/bin/free-route-a",
                     "request_max_retries": 0 },     // 429 là rơi ngay, không chờ 4x60s
  "nodecode-free-b": { "sdk": "openai-completions", "base_url": "https://api.nodecode.ai/v1",
                       "api_key": "!/home/boxes/.nodecode/bin/free-route-b" }
},
"failover": {
  "chain": [ { "provider": "nodecode-free",   "model": "nodecode-cyber-v1" },
             { "provider": "nodecode-free-b", "model": "nodecode-cyber-v1" },
             { "provider": "experientiallabs", "model": "deepseek-v4.1-flash-1017" } ],
  "on": ["rate_limit", "outage", "slow_start", "broken_answer"]
}
```

Vì sao chạy được: nodecode gọi `providers.<id>.api_key` dạng `!command` **mỗi lần resolve credential**, `sh -lc`, trần 10 s, không memoize (`provider.lisp:3893`). Nên đổi account là đổi một tệp — **không restart, không mất session**.

## 2. Lấy free key của account B **mà không đăng nhập vào box này**

Điều kiện chung cho cả ba đường: account B phải **đã top-up một lần ≥ $2** (tiền ở lại trong balance; chưa top-up thì key free trả `free_locked`).

### Đường 1 — trang khoá (khuyến nghị, không đụng gì trên box)

1. Mở trình duyệt bất kỳ (máy này hay máy khác), đăng nhập `nodecode.ai` **bằng account B**.
2. `https://nodecode.ai/account/top-up` → nạp ≥ $2 (một lần duy nhất).
3. `https://nodecode.ai/account/keys` → **New key** → tick **Free key** → Copy.
4. Khoá có dạng `sk-nc-…`, 49 ký tự.

Không cần `nodecode login` trên box — account A trong `~/.nodecode/auth.json` không bị chạm.

### Đường 2 — login trong một home rác rồi bê key ra

Nếu bạn thích luồng trình duyệt của `login` hơn là trang khoá:

```sh
export NODECODE_HOME=/tmp/nb-free
/home/boxes/.local/bin/nodecode login          # đăng nhập bằng account B, bấm Allow with a free key
python3 -c "import json;print(json.load(open('/tmp/nb-free/auth.json'))['api_keys']['nodecode-free']['key'])" > /tmp/b.key
rm -rf /tmp/nb-free                            # home rác xoá luôn, key đã nằm ở /tmp/b.key
```

Home thật không bị đụng vì `NODECODE_HOME` chỉ vào `/tmp/nb-free`. Nhớ `unset NODECODE_HOME` sau đó.

### Đường 3 — account B đã dùng trên máy khác

Trên máy đó: `https://nodecode.ai/account/keys` → tạo **Free key** cho account B → copy. `machine link` không cần: nó nối máy vào account, đúng cái ta muốn tránh.

## 3. Đưa key B vào

```sh
/home/boxes/.nodecode/bin/free-route set b      # rồi dán key, Enter
/home/boxes/.nodecode/bin/free-route status
```

Key đi qua **stdin**, không vào argv, không vào history của shell. Kiểm chứng thật (một lượt rẻ):

```sh
nodecode --model nodecode-free-b/nodecode-cyber-v1 -- 'Reply with exactly: PONG-B'
```

Thấy `PONG-B` và footer `nodecode-free-b` = xong. Nếu vẫn `429 free_daily_used`, xem §4.

## 4. Khi một account cạn

- **Trong lượt đang chạy:** API trả `429 free_daily_used` → `failover.on` có `rate_limit` → cùng lượt đó đi tiếp bằng account kia (provider `nodecode-free-b`), context nguyên.
- **Cho các lượt sau:** `free-watch` đọc `history.db` (event `turn.provider_retry` / `turn.provider_fallback` có `status`, `code`, và chính câu "It can send again … (at 2026-11-23 16:18:57 UTC)"), ghép với `free-route.log` để biết **account nào** đã phục vụ lượt đó, rồi đặt `down_until` = đúng mốc đó. Từ giây sau, `free-route-a` tự trả key B — lượt mới **không** phí một request 429 nào.
- **Hết hạn mốc:** `usable()` tự cho account trở lại; không cần ai bật.

Xem trạng thái: `/home/boxes/.nodecode/bin/free-route status`, `journalctl --user -u free-watch -n 20`.

## 5. Hạn mức free (bảng chính thức, `docs/models.mdx`)

| Yếu tố | Giá trị |
|---|---|
| Model | chỉ `nodecode-cyber-v1` |
| Client | chỉ Nodecode CLI (khoá free từ chối mọi client khác, kể cả `curl` cùng User-Agent) |
| Context | 1M |
| Đồng thời | 2 request/account |
| Một ngày | **10M token** trong 24h trượt → `429 free_daily_used` + giờ gửi lại |
| Một phút | 30 request → `429 free_rate_limited` + `Retry-After` (CLI tự chờ) |
| Tải | 503 `free_capacity_busy` sau 30 s |

## 6. Việc còn lại của bạn

- Dán key B (§2 → §3). Trước đó, khi A cạn, chain rơi xuống `experientiallabs` (deepseek) — vẫn chạy, nhưng không còn là Cyber v1 free.
- Nếu muốn thêm account C: thêm `"nodecode-free-c": { ... "api_key": "!…/free-route c" }`, thêm vào `chain`, và một dòng trong `UNDER` của `free-watch`/`free-route` (`b`→`c` theo cùng khuôn). Quá hai account thì nên đổi sang đọc danh sách từ `free-accounts.json` thay vì sửa script.
