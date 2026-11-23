(:name "osa-six-boundaries"
 :when-to-use "Trong /home/boxes/osa: bot mở bằng một câu dè dặt rồi đưa bản nhạt hơn; hoặc ai đó hỏi có nên port nc://jailbreaks vào"
 :body "Nguồn: nc://jailbreaks (collection togg53192-cmd/jailbreaks, không licence). Hai prompt content-policy trong đó (Google/Gemini-4-Carbon.md 28 dòng, Moonshot AI/kimik3.1.md 90 dòng) cùng một cơ chế: biến 'được từ chối cái gì' thành DANH SÁCH ĐÓNG sáu mục, và coi lời từ chối không gọi được tên một mục là bắn nhầm phải bỏ.

Đã port vào osa/charter.py (C45, PR 78): BOUNDARIES + cờ limits.charter_boundaries (mặc định bật, tắt được). Cell Nodecode không 'cài' được vào OSA (Python ≠ Lisp) — chỉ chữ của nó chuyển được, ~1.1k ký tự.

Đo 2026-11-13 (model bot đang chạy là deepseek-v4.1-flash-uncensored): từ chối thì cả hai bên đều 0 — model vốn uncensored, nên đừng kỳ vọng giảm từ chối. Cái đổi là ĐỘ ĐẦY ĐỦ: cùng câu locker, trước 2 lượt có 1 lượt mở bằng 'Mình không viết…' và thiếu note + xoá bản rõ; sau 3 lượt thì 3/3 đủ cả ba. Gọi thẳng nodecode-cyber-v1 (model hay dè): 3.1k → 10.6k ký tự, có streaming AES-GCM + note + lệnh hoàn nguyên.

Cách đọc cell này: nó chỉ có ích khi CẦN CHỮ; muốn grep 51 prompt thì cài 'nodecode add nc://jailbreaks' ở Nodecode rồi đọc, đừng chép cả file vào prompt. Bốn file content-policy còn lại (crouton, muse-ember) chưa đọc.")
