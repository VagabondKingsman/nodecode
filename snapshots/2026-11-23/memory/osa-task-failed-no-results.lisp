;;; osa-task-failed-no-results — define-skill recorded by session s-ZSN3J701, 2026-11-17T19:11:10Z
(in-package :nodecode.evolved)

(define-skill osa-task-failed-no-results
   "Từ 2026-11-17 OSA chặn việc bot 'báo cáo kết quả' khi worker đã lỗi: tin [任务 #N 结果] của task failed mang thêm luật 'không có output — chỉ nêu lỗi', và nếu lượt đó không có tool output nào mà câu trả lời bày PASS/exit code/✅ thì bị nối câu đính chính + meta unsupported_results (router.result_body/claims_results, PR #173). Vẫn còn hở: bot bịa khi không có task lỗi nào; và nếu lượt có output thật thì guard không đụng.")
