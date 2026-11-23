# Bản sao bản cài đặt hiện tại (2026-11-23)

Bản sao lưu **đọc được bằng mắt** của con nodecode đang chạy trên máy `boxes`: ký ức, skill và cấu hình, ở dạng văn bản, để dựng lại hoặc soi lại được. Bản trước là `snapshots/2026-11-17/`.

## Có gì trong đây

- `memory/` — toàn bộ ký ức (`define-memory`) và skill (`define-skill`) đã định nghĩa, mỗi thứ một tệp `.lisp`, nguyên văn, lấy từ các cell tri thức: `cursor-agent-memory`, `nodecode-experience`, `nodecode`, `antigravity`.
- `memory-cell.asd` — khai báo cell ký ức (`:knowledge . t`), để chép `memory/` sang máy khác là dùng được.
- `cells.txt` — các cell đã cài trên máy này, đúng tên để `nodecode add nc://<tên>`.
- `config.redacted.jsonc` — cấu hình đang chạy, giá trị khoá đã che.
- `version.txt`, `taken-at.txt` — bản đang chạy và thời điểm chụp.

## Có mà không ở đây

- Khoá/đăng nhập: `~/.nodecode/auth.json`, `secrets/`, `gh-token`, `operator-token`.
- Ảnh chụp nhị phân (giá trị, generation): `nodecode snapshot <tên>` trên chính máy đó.
- Lịch sử hội thoại: `history.db`.
- Mã nguồn cell cài từ hub — cài lại theo `cells.txt` là đủ, và bản trong hub mới hơn bản chép lại.

## Dựng lại trên một máy khác

Bản đầy đủ, từng bước (VPS mới, cài bản phát hành hay build từ fork, khôi phục home, cell, ký ức, gateway, kiểm tra): **`SETUP-FROM-THIS-FORK.md`** ở gốc repo. Dưới đây là bản tóm tắt.

1. Cài nodecode đúng bản trong `version.txt` rồi đăng nhập.
2. Cài lại các cell ở `cells.txt`: `nodecode add nc://<tên>` (bỏ qua `cursor-agent-memory`).
3. Chép `memory/*.lisp` vào `~/.nodecode/cells/<tên-máy>-memory/` cùng `memory-cell.asd`; chỉ mục đọc tệp nên chúng vào chỉ mục ngay ở lượt sau.
4. Đặt lại khoá theo `config.redacted.jsonc`.

## Khác bản 2026-11-17

- Ký ức và skill tăng từ 171 lên hơn 400 tệp; nay chép cả skill, không chỉ ký ức.
- Cấu hình: mặc định chạy `nodecode-free / nodecode-cyber-v1` (effort high), thêm provider `opencodex`, `update.mode = off`, và mục `rea`.
- Bản chạy: 0.1.16+c78fef6 (bản 17/11 là 0.1.16+beee92a7e).
