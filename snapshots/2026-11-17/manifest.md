# manifest — bản sao lưu này là gì

- chụp lúc: 2026-11-17T06:15:55Z
- bản đang chạy: nodecode 0.1.16+beee92a7e
- ký ức: 171 tệp
- cell đã cài: 30
- cây nguồn: a3b10f7 (upstream nodecode-ai/nodecode đã fetch, nhánh làm việc đã rebase lên upstream/main)
- máy: boxes — Linux 6.1.189+

## Vì sao dạng văn bản

Ảnh chụp nhị phân của organism (lệnh `nodecode snapshot`) nặng 20–120 MB và **chứa bí mật** (nó nằm trong ~/.nodecode/snapshots, ở lại máy). Bản này nhỏ, đọc được, đưa lên git được: ký ức là các tệp .lisp nguyên văn, cấu hình đã che khoá.

## Cái gì KHÔNG chép

- `auth.json`, `secrets/`, `gh-token`, `operator-token` — bí mật.
- `history.db` — lịch sử hội thoại, lớn và có dữ liệu người dùng.
- ảnh chụp nhị phân, generation, blobs, chrome-profile.
