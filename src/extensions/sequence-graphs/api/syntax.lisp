(in-package #:cl-lore.extensions.sequence-graphs.api)


(cl-lore.api.raw:def-syntax sequence-graph (axis input)
  (ret
   (make-sequence-node axis input)))


(defalias seq #'cl-lore.extensions.sequence-graphs.graphics:seq)
