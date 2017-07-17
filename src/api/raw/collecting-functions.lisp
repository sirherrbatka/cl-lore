(in-package #:cl-lore.api.raw)


(defun get-chunk (label)
  (cl-lore.protocol.collecting:get-chunk *chunks* label))


(defun push-chunk (label)
  (cl-lore.protocol.collecting:push-chunk *chunks* label))
