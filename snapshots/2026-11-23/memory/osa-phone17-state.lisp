;;; osa-phone17-state — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U83TRK-ZQ73PB3J05, 2026-11-23T00:38:58Z
(in-package :nodecode.evolved)

(define-skill osa-phone17-state
  "Máy bot OSA (Instabox m_agq63n5e7pezlmtlzqiktbnqsu) — osa-phone17 = redroid 13, adb 127.0.0.1:5563 (adb shell root), host EC2 Ubuntu có sudo và /dev/net/tun; máy ảo tự khai là Pixel 7a: getprop ro.product.model 'Pixel 7a', fingerprint google/lynx/lynx:13/TQ3A.230805.001/10316531 (props ghi trên đĩa, sống qua restart); egress đi qua wg0 (WARP) nhờ warp-phone.sh; sau mỗi docker restart container phải chạy lại /data/local/tmp/frida-server. Cập nhật 23/11/2026.")
