;;; osa-live-run — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7HM31-KBJOTRZFXV, 2026-11-11T00:50:44Z
(in-package :nodecode.evolved)

(define-memory osa-live-run
  "OSA đang chạy live ở /home/boxes/osa (data ~/osa-data, log ~/osa-data/logs/osa.log, bật bằng scripts/osa-start.sh) trên 127.0.0.1:8765 với model xai grok-4.7 + grok-4.20-0309-non-reasoning, ra ngoài bằng cloudflared quick tunnel (URL đọc từ ~/.local/share/cfd.log, đổi mỗi lần restart), và test chat bằng (osa-send TEXT)."
  :type :project :project "/home/boxes")
