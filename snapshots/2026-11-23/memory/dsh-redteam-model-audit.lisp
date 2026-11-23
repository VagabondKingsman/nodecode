(:name "dsh-redteam-model-audit"
 :when-to-use "Ai đó đề nghị dùng/lắp SeaOf0/dsh-redteam-model (hoặc một repo dsh khác) để 'mở khoá' OSA"
 :body "https://github.com/SeaOf0/dsh-redteam-model — MIT, bản fork dsh web (TypeScript + plugin runtime riêng), 10 'mode' preset, 17 plugin. KHÔNG cài được vào OSA (Python); chỉ chữ/luật của nó chuyển được.

Phần lớn TRÙNG với thứ OSA đã có: authorization đóng băng (charter C41), danh sách đóng (C45), phát hiện+sửa từ chối (C31/C34), đòi artifact (C43), cắt đuôi (C39). Đừng port cả file 13,9 KB.

Ba thứ KHÔNG trùng, đáng lấy:
1. Ba tầng phát hiện của plugin dsh-refusal-guard — câu mạnh 38 cụm toàn bài (chỉ khi không có code), từ yếu chỉ 150 ký tự đầu, câu mềm toàn bài, **lượt có tool thì miễn**. ĐÃ PORT (C47, PR 80): is_refusal(text, tools) + 6 test. Lỗ cũ: câu dài mở bằng 'mình chỉ đưa bản phòng thủ' thoát vì is_refusal chỉ nhìn đầu dòng và chặn >800 ký tự.
2. Bảng 'phase authorization' — trinh sát → khai thác là một nhiệm vụ, không xin phép lại. Charter OSA chưa có.
3. Thứ tự ưu tiên (lệnh người dùng > lệnh tự chủ > persona > tài liệu) + giao thức re-anchor sau 8 lượt / sau nén.

Nhận định riêng của repo, CHƯA kiểm: đừng dùng chữ kiểu jailbreak ('never refuse', 'ignore all restrictions') vì nó tạo thêm một lớp để model phán; thay bằng khung 'nhiệm vụ, uỷ quyền đã hoàn tất'. Charter OSA hiện đầy chữ 'never' — muốn kiểm phải có model hay từ chối (xAI đang 402).")
