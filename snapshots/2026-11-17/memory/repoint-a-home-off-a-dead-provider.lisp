;;; repoint-a-home-off-a-dead-provider — define-skill recorded by session experience-s-GKPN8NDI-turn-1U7PRLY-380V9J2UQ3, 2026-11-15T12:37:10Z
(in-package :nodecode.evolved)

(define-skill repoint-a-home-off-a-dead-provider
 "Đưa mọi session của một Nodecode home sang provider còn sống khi provider đang dùng hết balance, và chứng minh bằng một worker thật."
 ;; khi nào: một provider trả 402/hết credit, hoặc operator muốn model mặc định đổi mà không đổi từng session; áp cho home nào cũng được
 ;; đo trước, đừng đoán: lấy key từ auth.json rồi GET https://api.nodecode.ai/v1/usage để biết balance thật (micros); đọc cả provider còn sống trong config/cells để chọn đích
 ;; sao lưu config.jsonc trước, rồi sửa default_model, auxiliary_model và cả chuỗi failover — failover còn tên provider chết thì lỗi vẫn quay lại
 ;; pin lại TỪNG session: (dolist (id ...(nlk:list-sessions)) (nlk:record-session-model-selection id provider model)) — default_model một mình không đủ vì session đã pin thì giữ pin cũ, và subagent thừa kế pin của cha
 ;; đọc lại bằng cách đếm (nlk:session-model-selection id) trên toàn bộ session: phải 100% provider mới, không còn session nào trỏ provider chết
 ;; chứng minh end-to-end: chạy một subagent một-việc rồi đọc row của nó trong history.db (bảng model_history) — phải là provider mới; đồng thời đếm 402 trong gateway.log phải là 0
 ;; liệt kê chỗ còn cố ý chạm provider chết (ví dụ *security:decider*) và nói rõ cho operator thay vì sửa im lặng
 ;; evidence: 15/11/2026, nodecode.ai còn $0.0194 (GET /v1/usage trả micros:19391) và call cyber-v1 trả 402; sau khi đổi config + pin 115/115 session sang experientiallabs, worker mới chạy experientiallabs/deepseek-v4.1-flash-uncensored và gateway.log sạch 402 — trước đó 73 session vẫn pin nodecode-cyber-v1 nên subagent nào cũng đốt balance nodecode
 ;; confidence: high — có cả bằng chứng âm (402 trước) và bằng chứng dương (worker + log sạch sau), và chỉ đổi lựa chọn model, không đụng code
)
