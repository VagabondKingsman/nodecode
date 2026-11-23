;;; opencodex-browser-login-redirects — define-memory recorded by session s-CC94P7FJ, 2026-11-17T18:37:49Z
(in-package :nodecode.evolved)

(define-memory opencodex-browser-login-redirects
  "In opencodex every account login can be finished from a browser that is NOT on the proxy machine: Claude/Anthropic code-display registers redirect_uri https://platform.claude.com/oauth/code/callback (a hosted page, not localhost), so approve -> copy code#state -> paste into the dashboard paste field or POST /api/oauth/login/code; xAI is a pure device flow (https://accounts.x.ai/oauth2/device?user_code=..., confirm and it finishes alone); Codex/ChatGPT browser login registers redirect_uri http://localhost:1455/auth/callback, which fails on the operator's own machine - capture the code from the address bar of the error page and submit it with POST /api/codex-auth/login/code (or run `ocx account login codex --device` for the device flow). Nothing needs an ssh -L of a callback port except when you prefer the CLI's browser mode."
  :type :reference)
