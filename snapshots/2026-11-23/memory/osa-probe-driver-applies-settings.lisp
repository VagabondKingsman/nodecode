;;; osa-probe-driver-applies-settings — define-skill recorded by session experience-s-83IFGT1L-turn-1U7LQA0-KUY5MTKG8P, 2026-11-13T06:07:29Z
(in-package :nodecode.evolved)

;; keep: a local probe driver must apply the store settings first
(define-skill osa-probe-driver-applies-settings #>END
In /home/boxes/osa, a python driver that imports osa.* must call settings.apply() before it touches a bot, or it runs on config.yaml's roles instead of the store's overrides and dies on quota while the live server is fine.
;; when a measurement script in that repo gets ProviderLimit/401/402 even though the running app answers
;; the driver imports osa.providers via osa.router; settings.apply() (osa/settings.py, which calls providers.apply()) is what installs the store override rows - without it the roles stay xai/deepseek from config.yaml
;; .env there holds only XAI_API_KEY while the overrides row points roles at deepseek + p9router, so an unapplied driver inherits the 402/401 pair
;; when it can, prefer driving the probe through the live surface (osa-send over /ws, or the platform's «huấn luyện <Bot> trên câu: …» path) - that process already applied the settings
;; evidence 2026-11-13 06:07: /tmp/measure.py set OSA_DATA_DIR correctly but not settings.apply(), every dm wake ended in ProviderLimit 402 while the same store serves the running server
;; confidence medium: the 402 trace is solid, apply() is read from settings.py:22, not yet rerun to a green count.
END
)
