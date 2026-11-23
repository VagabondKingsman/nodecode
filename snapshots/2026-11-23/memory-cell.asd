;;;; cursor-agent-memory.asd --- a knowledge cell: what the organism keeps and does not run, one definition per file. The index reads it; nothing loads it.

(defsystem "cursor-agent-memory"
  :description
  "cursor-agent-memory: memories and skills, one definition per file, read by the index and never loaded."
  :class
  nodecode.kernel:layer
  :depends-on
  ("nodecode")
  :properties
  ((:knowledge . t))
  :components
  nil)
