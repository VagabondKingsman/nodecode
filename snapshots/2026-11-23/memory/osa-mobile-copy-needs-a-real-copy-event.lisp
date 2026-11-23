;;; osa-mobile-copy-needs-a-real-copy-event — define-memory recorded by session experience-s-ZSN3J701-turn-1U7THGJ-IUT04CBIJ0, 2026-11-17T10:54:14Z
(in-package :nodecode.evolved)

;; the project fact a later OSA session would rediscover the hard way
(define-memory osa-mobile-copy-needs-a-real-copy-event "In /home/boxes/osa the phone reaches the web UI over plain http on the tailnet, so navigator.clipboard is absent and Android's document.execCommand('copy') returns true while copying nothing — copyText now trusts only a real copy event and falls back to a manual-copy sheet."
:type :project :project "/home/boxes/osa"
;; evidence: turn 17/11 - on http://<tailnet IP>:18765 window.isSecureContext was false and typeof navigator.clipboard undefined; the old helper returned execCommand's bare true, so every copy button said 已复制 with an empty clipboard.
;; the fix lives in web/src/copyText.ts (in-viewport textarea + own 'copy' listener; contentEditable range; else a long-press sheet in vi/en/zh) and the built copy is osa/static/dist, so `npm run build` in web/ is what the phone actually receives.
;; https on the tailnet (tailscale serve --bg --https=443 http://127.0.0.1:8765) is the real cure for browsers, but the Tauri Android app needs the native clipboard plugin and a rebuilt APK.
)
