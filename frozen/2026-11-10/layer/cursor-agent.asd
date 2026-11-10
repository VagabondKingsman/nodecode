;;;; cursor-agent.asd --- the organism's own layer. Generated at each definition; edit freely, the component list is the load order.

(defsystem "cursor-agent"
  :description
  "cursor-agent's layer: the organism's own definitions, one per file, over the shipped source."
  :class
  nodecode.kernel:layer
  :depends-on
  ("nodecode")
  :serial
  t
  :components
  ((:file "demo_sum-sq")))
