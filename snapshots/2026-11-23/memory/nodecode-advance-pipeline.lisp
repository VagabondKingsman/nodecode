;;; nodecode-advance-pipeline — define-memory recorded by session s-LRZO1F6H, 2026-11-18T06:35:19Z
(in-package :nodecode.evolved)

;; correct the memory with what the box taught me
(define-memory nodecode-advance-pipeline
  "Nodecode trên box này tự đi lên bản mới: nodecode-advance.timer (5 phút) fetch repo gốc upstream, gộp vào nhánh đang dựng, `just release` tại máy, cài ~/.local/share/nodecode/<hash>, restart gateway giữa hai lượt."
  :type :project :project "/home/boxes/nodecode"
  ;; Script: /home/boxes/.local/bin/nodecode-advance.sh (+ --build-only). Unit: nodecode-advance.{service,timer},
  ;; OnUnitActiveSec=5min, đã enable --now. State/log: ~/.nodecode/self-update/{log,built,served,lock}.
  ;; repo gốc = remote upstream, https://github.com/nodecode-ai/nodecode; origin = fork VagabondKingsman;
  ;; nhánh đang dựng = box/short-sleep (2026-11-18: gộp 60db5cd cells pin 8009087 -> 80cb321).
  ;; Thứ tự: fetch upstream -> merge (xung đột thì merge --abort, không build) -> `just release` (SBCL 2.6.0 ở
  ;; ~/.local/bin, quicklisp do ~/.sbclrc) -> bản dựng phải tự khai `+<short>` mới được cài -> symlink current
  ;; -> restart systemctl --user restart nodecode-gateway.service, một lần cho mỗi bản (so với state/served).
  ;; ĐO "đang có lượt" BẰNG open_turns, KHÔNG bằng mtime của history.db-wal: wal ghi cả khi rảnh (age 1s),
  ;; nên luật wal làm restart không bao giờ xảy ra. Câu đúng, đọc read-only trên history.db:
  ;;   select count(*) from open_turns o where exists (select 1 from events e
  ;;     where e.turn_id=o.turn_id and e.occurred_at > strftime('%Y-%m-%dT%H:%M:%fZ','now','-900 seconds'))
  ;; events.turn_id có dữ liệu; 900s là ngưỡng coi một lượt mở đã chết (đừng hạ thấp: build/tool dài im lặng
  ;; hợp pháp). gateway status cho port + `curl /healthz` = "ok":true trước khi restart.
  ;; BẪY flock: `exec 9>lock` bị con của `just release` thừa kế, lock sống lâu hơn script -> nhịp sau vào
  ;; `flock -n 9 || exit 0` im lặng mãi. Đã vá bằng `just release ... 9>&-`; nhịp im lặng không log = nghi lock.
  ;; KHÔNG chép install.sh vào ~/.local/share/nodecode/<hash>: bản tự dựng thiếu nó (nên `nodecode update`
  ;; báo "no installer travels with this build"), mà chép vào thì mode auto stage đúng bản kênh stable
  ;; beee92a7e (13/11) tức HẠ CẤP. Vì thế config update.mode="off", channel="stable".
  )
