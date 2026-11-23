;;; catalog-cell-before-installing — define-skill recorded by session experience-s-83IFGT1L-turn-1U7LY4I-XR9WRLQK5Z, 2026-11-13T08:58:19Z
(in-package :nodecode.evolved)

;; keep the judging procedure as a skill (prose form)
(define-skill catalog-cell-before-installing
  "Đánh giá một cell trong catalog hub trước khi cài: đọc archive của chính nó, phân loại nó (tra cứu / định tuyến / chặn), rồi mới nói nó làm được gì."
  ;; when to use: người vận hành hỏi một cell catalog (nc://NAME) có giúp được việc X không, hay bảo cài một cell — nhất là khi câu hỏi nghe như "cell này có mở khoá được Y không"
  ;; tải archive về /tmp chứ đừng cài: đọc URL trong /home/boxes/.nodecode/hub/*.json, curl về, tar tzf rồi tar xzf vào một thư mục riêng
  ;; đọc README mục "What it does not do" trước tiên — nó tự khai cái nó không làm, và đó là thứ quyết định câu trả lời
  ;; xếp nó vào một trong ba loại và nói thẳng loại: tra cứu (chỉ là dữ liệu/trích dẫn), định tuyến (chọn model/tier, cần id cụ thể trên một provider), chặn-gate (quét, phân quyền, audit — chặn chứ không mở)
  ;; đối chiếu với cái máy đang có: đọc default_model/auxiliary_model trong ~/.nodecode/config.jsonc, đừng đoán
  ;; trích nguyên văn dòng chứng minh (README, data.lisp, --help) trong câu trả lời; chỉ khi người vận hành đồng ý mới cài bằng nodecode add nc://NAME
  ;; nói rõ cái giá phải trả của cell chặn: bật block có thể giữ đúng những câu "trông đáng ngờ" mà ta đang muốn cho đi
)
