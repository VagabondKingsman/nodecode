;;; osa-serve-merged-branch — define-skill recorded by session experience-s-1CKKCZWG-turn-1U7J0LY-XXOF6O7Q6B, 2026-11-11T18:58:32Z
(in-package :nodecode.evolved)

(define-skill osa-serve-merged-branch
  "Khi một PR của OSA vừa được merge vào i18n-vi, đưa cây đang chạy lên đúng bản đã merge và khởi động lại service, rồi chứng minh bằng manifest và hash bundle."
  ;; when-to-use: PR vừa MERGED (hoặc team merge thêm commit sau đó), và máy dev đang chạy OSA từ /home/boxes/osa — cần để bot thật chạy code đã merge chứ không phải nhánh cũ.
  ;; 1. git fetch -q origin; git log --oneline -8 origin/i18n-vi — xem có gì mới hơn nhánh đang checkout (2026-11-11: sau #50/#51 còn 16 commit của team: menu bot, APK reconnect…).
  ;; 2. git status --short phải trống; rồi git checkout -q -B i18n-vi origin/i18n-vi. Trước khi đổi: chắc rằng không có task đang chạy (sqlite3 $OSA_DATA_DIR/osa.db "select count(*) from task_steps where status='running'" → 0).
  ;; 3. Trong cây mới: .venv/bin/python -c 'import osa.server' và .venv/bin/python -m osa.i18n (exit 0) — bắt lỗi merge ngay tại chỗ, không để service chết.
  ;; 4. cd web && npm run build — BẮT BUỘC: osa/static/dist/ nằm trong .gitignore, nên checkout không mang bundle theo; không build thì server vẫn phục vụ UI cũ. Assert sau build: grep -o 'assets/index-[A-Za-z0-9_-]*\.js' osa/static/dist/index.html phải ra file vừa sinh.
  ;; 5. kill -TERM $(systemctl show -p MainPID --value osa); sleep 16; curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:8765/manifest.json → 200; ps -o etimes= -p $(... MainPID) → vài giây.
  ;; 6. Kiểm chứng thật: /api/bootstrap (cookie /tmp/ck) trả bots/chats như mong đợi, và hash bundle trong index.html == hash trong osa/static/dist/assets/.
  ;; evidence: 2026-11-11 18:57Z — cây đang ở cursor/audit-abc-cache (0 trước, 16 sau origin/i18n-vi); sau checkout + `npm run build` + restart: "manifest=200", index.html trỏ "assets/index-5KRlPE_P.js", và PR #51 còn trong Sidebar (7 chỗ chatLabel/askText/isBotChat).
  ;; 7. Trên chính cây này chạy được đúng bộ test như CI (máy có bwrap, xvfb, google-chrome; KHÔNG có docker):
  ;;    OSA_REQUIRE_SANDBOX=1 OSA_TEST_CHROME=1 xvfb-run -a .venv/bin/python -m pytest tests -q -p no:cacheprovider -rs
  ;;    → 2026-11-11 trên fca5ed2: 1160 passed / 1 skipped (test_host_desktop cần OSA_TEST_DESKTOP=1), cộng evals
  ;;    --base-ref i18n-vi 35/35 và web/ npm test 44/44 + npm run build. Chạy trần (không cờ) chỉ ra 1151/3 vì
  ;;    sandbox và Chrome bị skip — không phải lỗi.
  ;; confidence: high — chạy trọn một lần, mỗi bước có đầu ra riêng (log trên đều là đầu ra thật).
  )
