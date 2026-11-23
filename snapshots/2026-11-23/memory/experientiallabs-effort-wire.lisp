;;; experientiallabs-effort-wire — define-memory recorded by session s-1CKKCZWG, 2026-11-12T18:53:03Z
(in-package :nodecode.evolved)

(define-memory experientiallabs-effort-wire #>END
Provider experientiallabs (deepseek-v4.1-flash-uncensored) nhận reasoning_effort: none|minimal|low|medium|high|xhigh|ultra|max; mặc định khi không gửi = reasoning BẬT. Image chỉ cho ladder (off low high xhigh max) và lane openai-completions bỏ hẳn field khi "off" (openai-completions.lisp:109-111) nên chọn off KHÔNG tắt reasoning; muốn tắt thật phải gửi "none". "medium" và "ultra" bị image chặn dù provider nhận.
END)
