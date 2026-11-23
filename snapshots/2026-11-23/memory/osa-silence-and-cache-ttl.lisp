;;; osa-silence-and-cache-ttl — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7IAME-7NCDINTA42, 2026-11-11T14:43:42Z
(in-package :nodecode.evolved)

(define-memory osa-silence-and-cache-ttl "In /home/boxes/osa every model call records its longest stream silence (llm_calls.silence_ms), and a chat turn's cold first call is the provider's cache expiring between turns, not a body of ours that changed." :type :project :project "/home/boxes/nodecode"
;; C24 (31e0b1d, 926bd38): providers.guard_stream nhận stats={} và điền stats[silence] bằng khoảng lặng dài nhất
;; của lần gọi — chờ khối đầu hoặc hở lớn nhất giữa hai khối; worker/router ghi vào llm_calls.silence_ms khi
;; thành công, khi huỷ và khi lỗi (lỗi thì đó là ngưỡng đã cắn). scripts/silence_stats.py in phân bố theo role.
;; Ngưỡng limits.stream_idle_s (120 s) CỐ Ý chưa đổi: 7 ngày có 6 lần stall, và một lần gọi lại xong trong 17 s
;; (task #90) — nghĩa là luồng chết thật chứ không phải đang nghĩ, nhưng đó mới là một mẫu.
;; Cache của lượt chat, đo 11/11: lần gọi đầu mỗi lượt lạnh (hit 1152, miss 22–24k, ~0,045 $), lần thứ hai sau
;; 1 s hit cả body. Lưu hai body liền nhau và so: cái sau là phần nối y nguyên của cái trước; gửi lại theo thứ
;; tự thì cái thứ hai hit 23936 — body không sai, cache nhà cung cấp hết hạn giữa các lượt (gửi lại ngay thì hit
;; 26496, để ~4 phút thì về 1152). Vậy đòn duy nhất là làm phần lạnh nhỏ đi (tool schema 35% một request router,
;; system 27% trong đó 86% là chỉ dẫn của Bot, history 38%), không phải hâm lại bằng một lần gọi rỗng.
;; Đo bằng scripts/cache_conv_probe.py (gửi một body mới rồi gửi lại y nguyên) và scripts/cache_replay_probe.py.
)
