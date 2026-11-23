;;; free-lane-demand-here — define-memory recorded by session experience-s-YXFQ3K5L-turn-1U851Y8-GD48E9L3S5, 2026-11-23T16:34:54Z
(in-package :nodecode.evolved)

;; keep the measured demand, as a fact of this box
(nodecode.evolved:define-memory free-lane-demand-here
  "This box's free-lane demand, measured from history.db as input-tokens + output-tokens (the tokens the free meter counts) over 2026-11-16..23, peaks at 69.4M = 6.9 account-days of the 10M/24h meter and averages 21.7M = 2.2 account-days across 900-3300 model calls a day."
  :type :project
  :project "/home/boxes"
  ;; Read 2026-11-23 with a read-only sqlite handle on ~/.nodecode/history.db, kind='turn.usage':
  ;; per day 3.7M, 10.5M, 36.3M, 5.4M, 69.4M, 37.9M, 0.5M, 10.2M. Multiply by nothing else:
  ;; cached input is NOT in this number, which is why it is the free meter's own quantity.
  ;;
  ;; What it decides: how many accounts a pool needs. 3-4 covers a normal day whole, 7 covers
  ;; the worst day measured. A pool that spreads evenly (least-recently-served) keeps each
  ;; account's rolling 24h window from expiring together -- on 2026-11-23 one account was
  ;; exhausted by 07:49 UTC while a second one would have carried the rest of the day.
  )
