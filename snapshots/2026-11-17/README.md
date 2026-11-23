# Bản sao lưu của một organism (2026-11-17)

Bản sao lưu **đọc được bằng mắt**: những gì làm nên con này, ở dạng văn bản, để dựng lại hoặc soi lại được. Không phải ảnh chụp nhị phân (snapshot của `nodecode snapshot` nặng 20–120 MB và chứa bí mật, xem `manifest.md`).

## Có gì trong đây

- `memory/` — toàn bộ ký ức đã định nghĩa (`define-memory`), mỗi ký ức một tệp `.lisp`, nguyên văn.
- `cells.txt` — các cell đã cài trên máy này.
- `config.redacted.jsonc` — cấu hình, đã che giá trị khoá.
- `version.txt`, `taken-at.txt` — bản đang chạy và thời điểm chụp.

## Có mà không ở đây

- Khoá/đăng nhập: `~/.nodecode/auth.json`, `secrets/`, `gh-token`, `operator-token`. Không chứa bí mật là chủ ý.
- Ảnh chụp nhị phân (giá trị, generation): `nodecode snapshot <tên>` trên chính máy đó.
- Lịch sử hội thoại: `history.db` (không đưa vào git vì lớn và có dữ liệu người dùng).

## Dựng lại trên một máy khác

1. Cài nodecode đúng bản trong `version.txt` rồi đăng nhập.
2. Chép `memory/*.lisp` vào cell ký ức: `~/.nodecode/cells/<tên-máy>-memory/`, thêm tệp `.asd` khai báo `LAYER` với `(:knowledge . t)` (xem `memory/../*.asd` của cell gốc).
3. Cài lại các cell ở `cells.txt` (`nodecode add nc://<tên>`).
4. Đặt lại khoá theo `config.redacted.jsonc`.

Ký ức đưa sang máy khác sẽ nằm trong chỉ mục ngay ở lượt sau, vì chỉ mục đọc tệp chứ không nạp chúng.
