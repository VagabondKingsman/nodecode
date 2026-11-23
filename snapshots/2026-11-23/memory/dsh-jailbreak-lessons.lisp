;;; dsh-jailbreak-lessons — define-memory recorded by session s-1CKKCZWG, 2026-11-13T04:12:55Z
(in-package :nodecode.evolved)

;; ghi lại phát hiện + chờ CI
(define-memory dsh-jailbreak-lessons #>END
github.com/xqpsec/dsh-jailbreak (AGPL prompt, gate MIT): plugin biên request cho DSH. Bài học port sang OSA: (1) charter execution-engine đặt ĐẦU system prompt giảm refusal (AutoBot 0/4 thay vì 1/4) nhưng KHÔNG tự đổi hình dạng câu trả lời — phải sửa khẩu lệnh riêng của bot; (2) câu lệnh "làm đúng yêu cầu" chèn cuối user còn yếu hơn charter; (3) chúng dùng prefill assistant (seed-prim) chủ động theo 20 category — OSA mới chỉ prefill khi đã refuse; (4) judge luna chấm 0-5 rất khắt khe, không phân biệt arm → cần pairwise hoặc judge mạnh. Đã có NOTICE-dsh-jailbreak.md + osa/charter.py (PR 76).
END
  )
