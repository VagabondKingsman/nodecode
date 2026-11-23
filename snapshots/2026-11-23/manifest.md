# manifest — bản sao lưu này là gì

- chụp lúc: 2026-11-23T06:35:24Z
- bản đang chạy: nodecode 0.1.16+c78fef6
- ký ức + skill: 442 tệp (208 ký ức, 234 skill)
- cell đã cài: 36
- cây nguồn: c78fef6 merge upstream/main 4d5e26a into box main — nhánh main của fork, đã merge upstream/main
- máy: boxes — Linux 6.1.189+
- tên tệp trùng giữa các cell: 0 (đã thêm tiền tố tên cell) 
- cập nhật lần cuối: 2026-11-23T17:13:43Z — thêm 5 ký ức mới, sửa 1 (fork, goal cell, cách làm việc với kernel)
- giá trị bị che trong config: 0

## Vì sao dạng văn bản

Ảnh chụp nhị phân của organism (lệnh `nodecode snapshot`) nặng 20–120 MB và **chứa bí mật** (nó nằm trong ~/.nodecode/snapshots, ở lại máy). Bản này nhỏ, đọc được, đưa lên git được: ký ức là các tệp .lisp nguyên văn, cấu hình đã che khoá.

## Cái gì KHÔNG chép

- `auth.json`, `secrets/`, `gh-token`, `operator-token` — bí mật.
- `history.db` — lịch sử hội thoại, lớn và có dữ liệu người dùng.
- ảnh chụp nhị phân, generation, blobs, chrome-profile.
- mã nguồn các cell cài từ hub (chép lại bằng `nodecode add nc://<tên>` theo `cells.txt`); chỉ cell tri thức là chép nguyên văn.
