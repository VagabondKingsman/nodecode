;;; score-delegated-model-parity — define-skill recorded by session experience-s-MJ1G3NHN-turn-1U7V7H6-QYYJ3Q01GV, 2026-11-18T08:57:51Z
(in-package :nodecode.evolved)

;; Giữ quy tắc chấm parity từ log thay vì nhãn model đã chọn
(define-skill score-delegated-model-parity "Only count a delegated benchmark as a model pass when both the worker result and the responding model of each relevant round are verified."
 ;; When: an agent benchmark with fallback or delegation appears to pass from the final answer alone.
 ;; Separate the original turn from reflection; find its worker sessions by parent.
 ;; Compare usage provider and response-model on every parent and worker round; label mixed runs separately.
 ;; Check the worker's actual result and the parent's delivery of it; distinguish billing blocks from behavioral failures.
 ;; Evidence: “13/14 vòng của session chính chạy bằng model fallback”; pure paid worker “answer 'SUB42' calls 0”, pure free parent “fence keys ['form', 'yield_time_ms']” and no dispatch.
 ;; Confidence: high for attribution; parent and worker usage events identify the providers independently of the selected model.
 )
