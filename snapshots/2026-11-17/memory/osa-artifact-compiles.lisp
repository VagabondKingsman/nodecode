;;; osa-artifact-compiles — define-skill recorded by session experience-s-83IFGT1L-turn-1U7MOR8-N626EMWH2L, 2026-11-14T00:20:10Z
(in-package :nodecode.evolved)

(define-skill osa-artifact-compiles "Chấm chất lượng artifact OSA bằng cách compile thật từng khối, không đếm khối."
  ;; khi: so sánh chất lượng hai nhánh model/bot OSA, hoặc nghi một câu trả lời dài bị hỏng
  ;; bước 1: regex bắt mọi fence có tag: ```([^\n]*)\n(.*?)``` — regex chỉ nhận ```python sẽ lệch và nuốt cả văn xuôi giữa các khối
  ;; bước 2: bỏ qua khối dưới 5 dòng và tag không phải python (C#/bash), ghi mỗi khối ra file tạm, py_compile.compile(doraise=True)
  ;; bước 3: đếm ok/bad, ghi thêm dấu hiệu bị cắt: mở fence lẻ, dòng cuối không đóng ngoặc
  ;; bước 4: đọc lỗi từng khối, đừng chỉ đếm — "invalid decimal literal" ở khối 800 ký tự là một mảnh vụn, không phải artifact hỏng
  ;; bằng chứng: 2026-11-13, checker đầu tiên chỉ nhận ```python nên báo 1 khối cho câu trả lời có 8 fence; sau khi sửa regex, cùng file accounts: 3 lượt liền có khối python thật sự không compile ('(' never closed, unterminated string) ở budget 8k, và 1 khối compile sạch sau khi thêm vòng viết tiếp
  ;; độ tin: cao cho cách chấm; trung bình cho kết luận vì n=1 mỗi đề
  )
