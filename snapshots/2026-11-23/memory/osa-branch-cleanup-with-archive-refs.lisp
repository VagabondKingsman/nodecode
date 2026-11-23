;;; osa-branch-cleanup-with-archive-refs — define-memory recorded by session experience-s-MJ1G3NHN-turn-1U7VS7M-EG92GC5MHW, 2026-11-18T16:24:14Z
(in-package :nodecode.evolved)

(define-memory osa-branch-cleanup-with-archive-refs
  "Muốn xoá nhánh cũ trong /home/boxes/osa thì archive ref trước (refs/archive/<UTC>/...) rồi mới xoá, và kiểm lại refspec remote.origin.fetch vì repo này từng bị thu hẹp về đúng i18n-vi."
  :type :project
  :project "/home/boxes/osa"
  ;; 2026-11-18: local 55 nhánh -> 1 (i18n-vi); 44 đã nằm trọn trong origin/i18n-vi,
  ;; 3 còn commit riêng (fix/task-ids-own-space 4, selfbuild/repair-chain 1, tmp-parity 2).
  ;; Backup local: for b in $(git for-each-ref --format='%(refname:short)' refs/heads/ | grep -v '^i18n-vi$');
  ;;   do git update-ref refs/archive/$D/$b refs/heads/$b; done   (D=$(date -u +%Y%m%dT%H%M%SZ))
  ;; Backup remote: git update-ref refs/archive/$D/remote/$b refs/remotes/origin/$b
  ;; Xoá remote đã merge: git push origin --delete <b> chỉ khi git merge-base --is-ancestor origin/<b> origin/i18n-vi
  ;;   (xoá 19; 3 nhánh báo FAIL nhưng thực ra đã biến mất — kiểm bằng git ls-remote --heads origin <b>).
  ;; Bẫy refspec: git config --get-all remote.origin.fetch trả về chỉ i18n-vi => fetch không thấy nhánh khác,
  ;;   sinh 22 tracking stale + 37 thiếu. Sửa: git config --replace-all remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
  ;;   rồi git fetch --prune; đối chiếu tracking == git ls-remote --heads origin (87 == 87).
  ;; Khôi phục đã thử: git branch probe-archive refs/archive/20261118T161149Z/tmp-parity -> cùng objectname, rồi branch -D.
  ;; Dọn kèm: git worktree remove --force <path> + git worktree prune; git update-ref -d cho tracking stale;
  ;;   find . -name __pycache__ -not -path './.venv/*' -prune -exec rm -rf {} + ; rm -rf .pytest_cache.
  ;; /tmp: kiểm tiến trình đang giữ (readlink /proc/*/fd/*) trước khi xoá; giữ bare.log, wire.log, osa-docker, zmx-*. 1.7G -> 14M.
  )
