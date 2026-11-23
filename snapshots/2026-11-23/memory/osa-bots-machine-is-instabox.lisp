;;; osa-bots-machine-is-instabox — define-memory recorded by session experience-s-GKPN8NDI-turn-1U7P60S-K5ZQJPT059, 2026-11-15T10:09:02Z
(in-package :nodecode.evolved)

(define-memory osa-bots-machine-is-instabox "Trên /home/boxes/osa máy của bot là Instabox (computer.backend tự chọn ra instabox), nên mã chỉ chạy với backend Docker — mount, `docker ps` — không áp dụng cho live; muốn đưa tệp cho bot thì dùng `computer.write_bytes` vào `c.workspace`." :type :project :project "/home/boxes/osa"
;; Đo 15/11: `computer.get().backend` trả 'instabox', `docker ps -a` rỗng, sandbox có $HOME=/data/home. Cùng ngày thêm OSA_COMPUTER_MOUNTS cho backend Docker — có test nhưng chưa chứng minh được trên live.
;; Cách làm đã thành hình: (osa-push-to-machine "đường-dẫn-tệp") chép vào workspace rồi đọc lại; Nova đã đọc được tệp ở /data/workspace/agents/BOARD.md.
)
