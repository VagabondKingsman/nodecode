;;; osa-xai-key-source — define-memory recorded by session experience-s-1CKKCZWG-turn-1U7JY42-RUFQX668U4, 2026-11-12T07:17:32Z
(in-package :nodecode.evolved)

(define-memory osa-xai-key-source
  "In /home/boxes/osa the xAI key is read by providers.api_key('xai') from the vault first and only then from the role's api_key_env, so a key pasted in the UI takes effect without touching systemd's Environment and without a restart for chat."
  :type :project :project "/home/boxes/nodecode")
