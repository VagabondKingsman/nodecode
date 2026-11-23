;;; nodecode-install-official-beside-a-live-home — define-memory recorded by session experience-s-MJ1G3NHN-turn-1U7WQ07-XSSKVC93CF, 2026-11-19T04:45:06Z
(in-package :nodecode.evolved)

(define-memory nodecode-install-official-beside-a-live-home
  "Cai lai mot ban nodecode CHINH THUC tren box nay: tat timer tu dong dung lai fork, dat release vao ~/.local/share/nodecode voi env -u NODECODE_HOME, roi giu ~/.nodecode (memory) nguyen."
  :type :lesson
  ;; why: 2026-11-19 an official reinstall was silently undone at 04:13:44 by nodecode-advance.timer, which merges upstream into /home/boxes/nodecode, runs `just release`, lays the build under the share dir and repoints `current` -- so checking what reinstalls comes FIRST.
  ;; 0. `systemctl --user list-timers --all` and `systemctl --user is-enabled nodecode-advance.timer`: stop and disable it before repointing, or the fork is back within five minutes.
  ;; 1. channel pointers: https://nodecode.ai/dl/stable-x86_64-linux (beee92a7e, release 0.1.16) and .../nightly-x86_64-linux (60db5cd91 = tip of upstream/main); nightly is the newest UPSTREAM build, and there is no beta/edge.
  ;; 2. `nodecode update` refuses on a home built from source ("no installer travels with this build"), which is why the official installer is the way back.
  ;; 3. run it as `env -u NODECODE_HOME NODECODE_VERSION=<label> sh install.sh`: with NODECODE_HOME exported (this box exports /home/boxes/.nodecode) install.sh's HOME_DIR becomes the MEMORY home and lays the release out there.
  ;; 4. the installer never touches ~/.nodecode (cells/, history.db, config.jsonc, auth.json), so memory survives by construction -- back the home up first anyway.
  ;; 5. the unit /home/boxes/.config/systemd/user/nodecode-gateway.service runs ~/.local/share/nodecode/current/nodecode with NODECODE_HOME=~/.nodecode, so repointing `current` is what it starts next; restart it detached (`setsid nohup nodecode gateway restart --force`) because a session lives inside it.
  ;; 6. after the switch the fork's own layer files do not answer on the official build: the boot says "this build did not load N layer file(s)" and they must be forgotten (fmakunbound), not forced.
  ;; 7. verify from the running surface: `nodecode --version`, `nodecode gateway status` (build line), and a real model turn.
  )
