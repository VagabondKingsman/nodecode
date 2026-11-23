;;; osa-live-unrestricted-lives-in-overrides — define-memory, 2026-11-13
(in-package :nodecode.evolved)

(define-memory osa-live-unrestricted-lives-in-overrides #>BODY
On /home/boxes/osa the live unrestricted switch is NOT in config.yaml: it is settings key='overrides' -> limits.unrestricted=1, applied by settings.apply() at server start. A bare `.venv/bin/python -c "from osa import freedom; freedom.on()"` prints False and will make you think the mode is off — call settings.apply() first. So a code path gated by `freedom.on()` cannot be judged by grepping config.yaml either.
Live facts 2026-11-13 (PR 76 code, chat 1 = Nova, chat 2 = AutoBot): the train probe is 23–28 s end to end, the measurement posts one verdict line in the same second the dm_reply lands, and llm_calls shows no extra router call after it.
Also on this box: bots has no chat_id column (chats hold bot_ids JSON), the live DB has no `tasks` table (messages + task_steps instead), `pkill -f 'uvicorn osa.server'` also kills the sh that ran it, and the live data dir is /home/boxes/osa-data (OSA_DATA_DIR from the unit) — python against the repo default writes the wrong DB.
BODY
)
