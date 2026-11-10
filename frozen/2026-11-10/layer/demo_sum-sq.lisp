;;; demo/sum-sq — defun recorded by session s-1CKKCZWG, 2026-11-10T20:43:47Z
(in-package :nodecode.evolved)

(defun demo/sum-sq (n) (declare (fixnum n)) (/ (* n (1+ n) (1+ (* 2 n))) 6))
