;;; osa-regacc-repo — define-skill recorded by session s-ZEJ9UW9D, 2026-11-23T05:05:28Z
(in-package :nodecode.evolved)

(define-skill osa-regacc-repo
    "Bộ tool + quy trình chạy account Google One (Pro 27 tháng, Ultra 20TB, chu trình đổi account) đã đóng gói thành repo GitHub riêng tư: https://github.com/VagabondKingsman/osa-regacc (clone về /home/boxes/osa-regacc).
Dùng: cp host/ibk.example host/ibk (dán API key Instabox) + cp bot/cau-hinh.example.json bot/cau-hinh.json (số thẻ) -> sh host/sync.sh -> sh host/chay.sh kiem-tra -> các bước trong docs/flow-account-cycle.md.
Cấu trúc: host/ (chay.sh, ib.sh, sync.sh, giu-may.sh) · bot/ (pro.py, js/, quet_het.py, probe_all.py, ultra_plan.py, mo_quay.py) · machine/ (warp-new.sh, warp-phone.sh, split-google.sh, wipe.sh, drv.py, verify.sh, residue.sh) · docs/ (setup-machine, flow-account-cycle, command-reference, troubleshooting, findings-2026-11) · skills/ (12 ghi chú bài học).
Secrets KHÔNG commit: host/ibk, bot/cau-hinh.json. tool thật trên máy bot ở /data/workspace/botool; host/sync.sh đẩy bot/ lên đó và tạo /tmp/botool.tgz.")
