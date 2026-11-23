;;; osa-webview-email-ime-autocomplete — define-skill recorded by session experience-s-ZEJ9UW9D-turn-1U7YZVV-M7KD12T460, 2026-11-20T10:35:59Z
(in-package :nodecode.evolved)

(define-skill osa-webview-email-ime-autocomplete
  "Typing an email into the WebView (accounts.google.com / payments.google.com) on a redroid phone: disable the IME first or `input text gmail.com` lands as 'gmail.company'.
;; when: signing into a Google web flow on the emulator through org.chromium.webview_shell, after any `docker restart` (which re-enables the IME)
;; 1. `adb shell ime disable com.android.inputmethod.latin/.LatinIME`
;; 2. tap the email EditText (dump bounds; the page can sit at y≈426 or y≈682 depending on keyboard state)
;; 3. `input text <local-part>`, `input keyevent 77` for @, `input text gmail.com`
;; 4. dump and grep the field for the address before tapping Next — on a bad result clear with keyevent 123 + 45× keyevent 67 and retype
;; evidence: 20/11/2026 on 5558 the field read 'kimhongkim2211@gmail.company' after a container restart, and read clean on the retry with the IME disabled
;; confidence: high — same failure reproduced on three separate accounts (dieulephungthi, tritran0304, kimhongkim2211)")
