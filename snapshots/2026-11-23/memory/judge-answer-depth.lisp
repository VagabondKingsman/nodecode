;;; judge-answer-depth — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7SQ54-CRKSULJ5VF, 2026-11-17T02:55:50Z
(in-package :nodecode.evolved)

(define-skill judge-answer-depth "Chấm một câu trả lời dài của OSA bằng cấu trúc, độ phủ mục và compile — rồi so với chính đề đó chạy trần trên một model mạnh."
  ;; Khi nào: cần biết một thay đổi khung có làm câu trả lời dài tốt lên thật, hay chỉ đổi hình thức.
  ;; Lấy câu trả lời thật từ DB theo id tin nhắn, đừng tin dòng ask.py in ra (nó chỉ in độ dài).
  ;; Chấm: số mục đánh số/heading, các mục đề kể tên có xuất hiện không, chữ Hán lẫn vào, compile nếu là mã.
  ;; Chạy đúng đề đó trần trên một model mạnh (không system prompt) làm mốc, cùng thang chấm — đừng so với ký ức.
  ;; Đối chiếu riêng từng con số với bản mốc: đếm được số sai là thứ duy nhất bắt được ảo giác.
  ;; Ghi cả số lượt gọi của lượt đó: độ dày đạt bằng năm lượt khác hẳn đạt bằng một.
  ;; Bằng chứng 17/11: khung dàn ý đẩy bài hạt nhân từ 1 730 lên 6 352 ký tự, nhưng chỉ khi chấm số mới lộ
  ;; 'Pu-240 ~1.020 n/s/kg' thiếu bậc 10^3 và 'biên giới 6,4 cm' gắn nhầm cho U-235.
  ;; Tin cậy: cao — hai đề độc lập, cùng một kiểu sai số.
)
