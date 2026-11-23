;;; osa-cdp-copy-on-insecure-origin — define-skill recorded by session experience-s-ZSN3J701-turn-1U7THGJ-IUT04CBIJ0, 2026-11-17T10:54:10Z
(in-package :nodecode.evolved)

;; the old skill's file is not reachable by a guessed path: keep the correction as its own skill
(define-skill osa-cdp-copy-on-insecure-origin "Prove a copy button works over a plain-http origin by tapping it with a real input event and reading the clipboard back from a secure page."
;; when-to-use: a copy/paste bug was reported on a phone, from the tailnet's http origin or inside a WebView, and the fix has to be shown working end to end rather than by unit test - also wherever osa-cdp-clipboard-check's "provable only by unit test" note would stop you early
;; evidence: turn 17/11 - a programmatic b.click() on the same button under a real insecure origin reported "after a tap: {'label': 'Không sao chép được', 'sheet': True}" and left the clipboard empty; after switching to Input.dispatchMouseEvent the read-back held the text ("label after a real tap: Sao chép"), so the earlier belief that this box's headless Chrome cannot copy on plain http was wrong
;; confidence: high - two runs on the same page, one honest tap read back from a second page and one with document.execCommand stubbed to a bare true
;; serve insecurely for real: socat TCP-LISTEN:18765,fork,reuseaddr TCP:127.0.0.1:8765, open http://<tailnet IP>:18765, then assert window.isSecureContext === false and typeof navigator.clipboard === 'undefined'
;; grant clipboard permissions on BOTH origins, setFocusEmulationEnabled {enabled:true}, bringToFront, else readText answers 'Document is not focused.'
;; tap with Input.dispatchMouseEvent mousePressed then mouseReleased at the button's client-rect centre - a click() from Runtime.evaluate carries no user activation
;; read back from a SECOND page on http://127.0.0.1:8765, since localhost is a secure context and the insecure page that copied cannot read its own clipboard
;; then stub document.execCommand = () => true the way Android does and expect the honest failure label plus the manual-copy sheet: that is the phone's path
)
