;;; deep-test-a-skill-with-a-bot — define-skill recorded by session experience-s-ZSN3J701-turn-1U7TZBY-BK46TIROAC, 2026-11-17T17:15:26Z
(in-package :nodecode.evolved)

;; giữ quy trình deep-test skill bằng chính bot, có bằng chứng
(define-skill deep-test-a-skill-with-a-bot
  "Kiểm một skill OSA bằng cách giao việc cho bot thật qua chat, rồi đối chiếu với ground truth tự chạy — thay vì tự đọc skill và tự khen nó đúng."
  ;; dùng khi: vừa lưu/sửa một skill (hoặc quy trình) cho các bot OSA và cần biết nó có chạy được không, trước khi báo operator là xong
  ;; gửi việc qua (osa-send text :chat <id>) vào một chat riêng của bot: tạo chat bằng insert vào bảng chats(kind='direct', bot_ids='[<id>]', lead=1)
  ;; bài giao phải chia rõ 3 tầng: (a) đọc skill bằng load_skill(name, offset) + read_skill_resource(name, path), (b) chạy cổng kiểm thật trên computer và dán NGUYÊN VĂN output + exit code, (c) liệt kê chỗ skill nói một đằng mà máy làm một nẻo
  ;; cấm bot tự suy đoán: "bước nào không chạy được thì ghi BLOCKED, đừng đoán" — nếu không nó sẽ điền bảng PASS bằng tưởng tượng
  ;; đọc kết quả, tự chạy lại đúng các lệnh cổng kiểm trên máy để có ground truth, đừng tin mỗi lời bot
  ;; sửa skill, đồng bộ CẢ DB lẫn pack trên đĩa (<OSA_DATA_DIR>/skill-packs/ai-native/<tên>/), rồi giao vòng 2 chỉ để xác nhận từng điểm đã đúng (ĐÚNG/CÒN SAI), không bắt bot đọc lại toàn bộ
  ;; vòng 3 trở đi chỉ hỏi "còn 5 dòng lỗi còn lại" — mỗi vòng thường lộ thêm 3-5 lỗi thật (biến, đường dẫn, adb thiếu -s, thứ tự bước)
  ;; nếu bot từ chối làm nghiệp vụ, tách phần audit kỹ thuật ra: nó vẫn chịu kiểm cú pháp/patch/script và bắt lỗi rất tốt
  ;; ghi lại biên bản ở chat đó (số chat là bằng chứng), và đừng tuyên bố skill chạy được nếu bot chưa chạy end-to-end
  ;; bằng chứng: lượt 2026-11-17, skill /google-ai-ultra-trial — bot 8 bắt 7 lỗi vòng 1 ("read_skill_resource → No installed resources", "/tmp/ui.py vs /tmp/gu/…"), 5 lỗi vòng 3 ("setup-machine.sh kiểm [ -n \"$INSTABOX_API_KEY\" ] … không đọc $KEY/$M"), sau khi sửa thì chính em chạy lại SH_OK/PY_OK/--check exit=0; trước đó em chỉ tự đọc skill và đã tưởng nó ổn
  ;; độ tin: cao — lỗi được bot nêu kèm số mục và em xác minh lại bằng lệnh thật trên máy
  )
