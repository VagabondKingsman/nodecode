;;; telemetry-unpriced-on-free-provider — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7HDFR-6MEXCSBNQR, 2026-11-10T21:39:12Z
(in-package :nodecode.evolved)

;; giữ fact: telemetry $0 vì provider free không có bảng giá
(define-memory telemetry-unpriced-on-free-provider
 "In this devbox telemetry's /stats shows $0.00 with 'N unpriced' because the nodecode-free provider reports no prices, so only tokens/rounds/tool time are meaningful there; real dollars need a provider with a price table."
 :type :project :project "/home/boxes/nodecode")
