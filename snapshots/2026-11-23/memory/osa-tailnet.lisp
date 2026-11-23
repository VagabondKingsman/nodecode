;;; osa-tailnet — define-memory recorded by session s-1CKKCZWG, 2026-11-11T01:55:42Z
(in-package :nodecode.evolved)

(define-memory osa-tailnet
    #>END
Đường vào OSA (chốt 11/11/2026, bản TUN): CHỈ Tailscale, funnel OFF. Node "osa" = 100.112.118.106, tailnet taila99125.ts.net → http://osa.taila99125.ts.net (tailscale serve --http=80 → 127.0.0.1:8765, tailnet only).
BA SYSTEM UNIT (/etc/systemd/system, enable, WantedBy=multi-user.target → tự lên lúc boot): tailscaled.service (TUN thật, tạo tailscale0, --port=41641, log vào journalctl -u tailscaled), osa.service (uvicorn, User=boxes, EnvironmentFile=/home/boxes/osa/.env), osa-tailnet.service (oneshot → ~/osa/scripts/tailnet-serve.sh). Ba unit user cũ (~/.config/systemd/user/osa*.service) đã disable nhưng còn nguyên để rollback.
KIỂM NHANH: systemctl is-active tailscaled osa osa-tailnet; ~/osa/scripts/tailnet-ensure.sh (in ra "tailscale=Running serve=on ... cur=relay"); ~/osa/scripts/osa-up.sh.
CẠM BẪY: (1) eth0 chỉ có link-local 169.254.0.21/30 → netmon tưởng offline, phải có Environment=TS_ASSUME_NETWORK_UP_FOR_TEST=1 trong unit tailscaled. (2) TS_DEBUG_DERP là cờ boolean, KHÔNG phải chỗ nhét derp map (đặt JSON vào đó làm daemon chết ngay). (3) tailscaled userspace mồ côi giữ ~/.tailscale/tailscaled.sock (nếu rollback). (4) pkill -f có chuỗi trong chính cmdline sẽ tự giết shell.
END
    :type :project :project "/home/boxes")
