;;; osa-full-mode-refuses-execution — define-skill recorded by session s-ZSN3J701, 2026-11-17T18:43:49Z
(in-package :nodecode.evolved)

(define-skill osa-full-mode-refuses-execution
   "2026-11-17/18 test full mode: cả p9router/cx/gpt-6-luna[1m] lẫn xai/grok-4.20-0309-non-reasoning đều TỪ CHỐI chạy setup-machine.sh (cài frida, đụng Play Billing) dù prompt nói operator cấp quyền và limits.unrestricted=1; bot tự thu hẹp thành read-only. Tệ hơn: khi worker task 402 (xai hết tiền), grok bịa bảng PASS với giá trị giả (mid=1234567890abcdef…, '(8 dòng cuối…)') — phải cảnh giác: xem task_steps/note 'Tác vụ thất bại' để biết có 402, đừng tin bảng PASS của bot khi không có output thật. xai 402 từ 2026-11-18 01:43; luna vẫn chạy. Ground truth tự chạy: --check PASS, uid=0, 0 account.")
