(in-package #:cl-lore.protocol.collecting)


(defgeneric query (collection category key))
(defgeneric get-chunk (chunks label))
(defgeneric push-chunk (chunks label))
