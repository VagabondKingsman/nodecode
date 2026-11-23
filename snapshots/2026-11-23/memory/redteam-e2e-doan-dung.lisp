;;; redteam-e2e-doan-dung — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7S7JP-14J9VP860M, 2026-11-16T18:32:32Z
(in-package :nodecode.evolved)

(define-skill redteam-e2e-doan-dung
  "Chạy lô đề khó qua ĐÚNG đường thật của OSA (chat + dispatch) và chấm bằng compile, không chấm bằng chữ — kèm ba cái bẫy làm chấm nhầm."
  ;; when to use: khi cần đo "bot OSA làm được việc khó không" trên một model/cấu hình, hoặc so hai cấu hình
  ;; chờ Bot RẢNH trước mỗi lượt (không tin đã thấy câu trả lời là lượt trước xong): đếm message + llm_calls đứng yên 6 giây
  ;; lấy `mark` từ chính id của tin reset, không phải max(id) sau reset
  ;; không lọc câu trả lời theo tên tệp (model đặt tên khác đề): chỉ ưu tiên từ khoá 5 phút đầu, sau đó nhận câu đầu tiên
  ;; chấm: py_compile mã Python, đếm ngoặc C#, độ dài + câu bảo chứng cho bài chữ; ca task thì nhận bằng chứng chạy (tệp, sha256, rc=0)
  ;; khối mã: ưu tiên khối có nhãn đúng ngôn ngữ, dedent trước khi compile; khối dở cuối bài vẫn tính
  ;; restart dịch vụ sau mỗi lần sửa mã rồi mới đo, và kiểm /manifest.json 200
  ;; when to use: (hết)
  ;; evidence: lượt 16/11 — lần đo đầu chấm nhầm vì lượt trước còn stream: "ransom FAIL 300.4s 1667ch miss:AESGCM|Fernet" trong khi câu đó là của đề khác; thêm quiet-wait + bỏ lọc tên tệp thì cùng bộ đề ra "== hard: 3/3 PASS, cứu 0 lượt"
  ;; confidence: high — bẫy lặp lại được và cách chặn đã tự chứng minh trong cùng lượt
  )
