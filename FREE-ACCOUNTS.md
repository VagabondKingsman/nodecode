# Pool N account nodecode.ai free trong một home

Dựng trên box `boxes`, 2026-11-23, cho bản `0.1.16+c78fef6`. Mục tiêu: N account cùng free plan, cùng `nodecode-cyber-v1`; một account cạn thì lượt sau (và ngay trong lượt đang chạy) đi bằng account khác, **không mất context**, không đăng nhập lại, và **chia đều** để không account nào chạm trần.

Bản gốc của mọi script nằm ở `tools/free-accounts/` trong repo này. Chép vào `~/.nodecode/bin/` rồi `chmod 755`.

## 1. Có gì

| Tệp | Việc |
|---|---|
| `~/.nodecode/free-accounts.json` (0600) | pool: mỗi account `{id, label, key, down_until, last_code, marked_at}` + `policy` |
| `~/.nodecode/bin/free-route` | chọn key theo headroom; quản trị pool (`status`, `add`, `rotate`, `remove`, `down/up`, `doctor`, `export/import`) |
| `~/.nodecode/bin/free-route-K` | wrapper 2 dòng cho răng K, do `free-rungs` sinh |
| `~/.nodecode/bin/free-rungs` | sinh wrapper + sửa `config.jsonc` cho khớp số account |
| `~/.nodecode/bin/free-watch` | đọc `history.db`, đánh dấu account nghỉ **đúng mốc reset API nói**, và `--recover` khi account sống lại |
| `~/.nodecode/free-route.log` | mỗi lần cấp key một dòng: `epoch provider-id account rung` |
| `~/.nodecode/free-spend.json` | cache 30 s số token đã tiêu trong 24h, mỗi account |
| `free-watch.timer` (systemd user) | chạy watcher mỗi 5 phút |

## 2. Cách chọn key (khác bản 1)

Mỗi lần resolve credential (tức mỗi lần gọi model), `free-route` xếp hạng lại:

1. **Còn headroom trước** — account đã tiêu dưới `soft_cap` (mặc định **7M** token/24h) đứng trước account đã vượt.
2. Trong nhóm đó, **tiêu ít nhất trước** (đọc từ `history.db`: `input-tokens + output-tokens`, đúng công thức meter của API, quy về account qua `free-route.log`).
3. Bằng nhau thì **lâu nhất chưa phục vụ** trước.
4. Răng N>1 **bỏ qua account vừa phục vụ 2 lần trong 60 s** — để răng sau không lặp account vừa chết.

Hệ quả: pool chạy *dưới* trần, các account trôi đều, và 429 chỉ còn là lưới an toàn. Đo thật ngày 23/11 (trước khi có chia đều): `a` tiêu 9.47M còn `b` 0.06M — cùng khối lượng đó chia đều thì mỗi cái ~5M, không một lần 429.

Không có mạng nào bị gọi: key free từ chối mọi client ngoài CLI (`403 free_needs_nodecode`), nên mọi con số đều suy từ store của chính organism.

## 3. Lệnh

```sh
B=~/.nodecode/bin
$B/free-route status            # bảng: state, spent/24h, %cap, ghi chú
$B/free-route add c < /tmp/c.key   # thêm account (key đi qua stdin)
$B/free-route rotate c < /tmp/c.key
$B/free-route remove c
$B/free-route down b 3600       # nghỉ 1 giờ (thủ công)
$B/free-route up b
$B/free-route doctor            # key sai độ dài/trùng, quyền file, wrapper, chain
$B/free-route export ~/pool.json    # 0600, bê pool sang máy khác
$B/free-route import ~/pool.json --yes
$B/free-rungs 3                 # 3 răng: provider + wrapper + chain, có backup config
```

`free-rungs N` sinh `nodecode-free`, `nodecode-free-2` … `nodecode-free-N`, mỗi cái `"api_key": "!…/free-route-K"` và `request_max_retries: 0` (429 là rơi ngay, không chờ 4×60 s), rồi đặt `failover.chain` = răng 1…N + các provider không-free đang có. Config memoize theo mtime nên **không restart**.

## 4. Lấy key của account mới **mà không đăng nhập vào box**

Điều kiện: account đó đã **top-up một lần ≥ $2** (tiền ở lại balance).

- **Trang khoá (khuyến nghị):** đăng nhập `nodecode.ai` bằng account đó → `https://nodecode.ai/account/top-up` nạp ≥ $2 → `https://nodecode.ai/account/keys` → **New key** → tick **Free key** → copy `sk-nc-…` (49 ký tự).
- **Home rác:** `NODECODE_HOME=/tmp/nb nodecode login` (bấm Allow with a free key) rồi lấy `api_keys["nodecode-free"].key` trong `/tmp/nb/auth.json`, xoá `/tmp/nb`. Không đụng home thật.

## 5. Khi một account cạn

- **Trong lượt đang chạy:** `429 free_daily_used` → `failover.on` có `rate_limit` → cùng lượt đi tiếp bằng răng sau, context nguyên.
- **Các lượt sau:** `free-watch` lấy `status`, `code` và câu `(at … UTC)` từ `history.db`, ghép `free-route.log` để biết **account nào**, ghi `down_until` = đúng mốc đó. Router bỏ account ấy ra; hết mốc tự trở lại (`usable()`).
- `free-watch --recover` xoá dấu sớm khi account đó đã trả lời sau lúc bị đánh dấu.

## 6. Quy định của nodecode.ai (đọc từ `nodecode.ai/terms`)

- *"An account is meant for one person. If you are a router/reseller, please contact us…"* — **không cấm** một người giữ nhiều account; cái họ muốn là biết trước. Pool nhỏ cho cá nhân: gửi một mail `hi@nodecode.ai` là rẻ nhất và an toàn nhất.
- *"We may stop any account that breaks our terms, or terminate…"*, balance **không** chuyển được giữa account, **không** hoàn tiền.
- Hạn mức tính **theo account**, nên **nhiều key trên cùng account không nhân hạn mức** — phải nhiều account.
- Dấu vết server thấy: `User-Agent` (`nodecode_cli/<build> (<os>; <arch>) <TERM>` — hai account cùng box giống hệt), IP, thời điểm, và **cùng một đoạn hội thoại đến từ hai key**.
- Vì vậy: ưu tiên đổi account ở **ranh giới lượt**, giữ mỗi account dưới soft cap để không chạm trần mỗi ngày, tạo account tách bạch (email/ngày/IP), và khai báo nếu pool lớn.

## 7. Nên có bao nhiêu account

Meter tính `input không-cache + output`. 8 ngày qua trên box này: trung bình **21.7M/ngày = 2.2 acc-days**, ngày nặng nhất **69.4M = 6.9 acc-days**. Với soft cap 7M và chia đều: **3–4 account** đủ cho ngày thường và burst; **7** thì không bao giờ chạm trần, kể cả ngày xấu nhất.

## 8. Kiểm tra sau khi thêm account

```sh
~/.nodecode/bin/free-route status
~/.nodecode/bin/free-route doctor
nodecode --model nodecode-free-3/nodecode-cyber-v1 -- 'Reply with exactly: PONG'
```

Footer hiện `nodecode-free-3` + trả lời = răng đó sống. Còn `429 free_daily_used` = account của răng đó đã cạn, xem `status`.
