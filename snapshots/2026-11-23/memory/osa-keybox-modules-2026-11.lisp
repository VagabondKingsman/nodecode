;;; osa-keybox-modules-2026-11 — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U7YP0M-ZNDW6VSVPA, 2026-11-20T06:24:54Z
(in-package :nodecode.evolved)

(define-skill osa-keybox-modules-2026-11
  "Bản đồ module keybox/Play Integrity còn sống tính đến 20/11/2026, để chọn nhanh khi cần verdict xanh trên máy root.
;; when: cần MEETS_BASIC/DEVICE/STRONG xanh trên redroid/emulator đã có Magisk, hoặc offer Google One không hiện vì attestation
;; đã xác minh repo (api.github.com): Yurii0307/yurikey 1963★ push 16/11/2026 (Action 1 nút: inject keybox YuriKey pool, set target.txt, security patch, boot hash, clear cache Google; cần TrickyStore + PIF/PIFork + Zygisk); GueRapii/FixIntegrity 6★ push 05/11 (tự check remote, tải keybox mới, ghi /data/adb/tricky_store/keybox.xml, kèm PIF); nercone-labs/replay-integrity 2★ push 15/11 (giữ STRONG, check revoke list, recover key từ XML hỏng); etnperlong/rkp-mini 8★ push 17/11 (tự issue keybox Qualcomm RKP, cert sống 12-14 ngày, experimental)
;; keybox tĩnh chỉ sống vài ngày (Google revoke liên tục) nên luôn dùng module auto-update, đừng giữ file cố định
;; Pixel 11 chưa có fingerprint riêng trên PIF: người ta pass STRONG bằng fingerprint+keybox của Pixel 10 Pro
;; evidence: lượt 20/11/2026 — máy Android 13 spoof Pixel 11 Pro + 12 feature XML + account sạch + IP US vẫn báo 'This offer is not available', tức props không đủ, cần keybox/attestation; 4 repo trên đều trả metadata hợp lệ qua GitHub API cùng lượt
;; confidence: medium — repo và metadata đã kiểm, nhưng chưa cài module nào nên chưa chứng minh được verdict xanh trên redroid.")
