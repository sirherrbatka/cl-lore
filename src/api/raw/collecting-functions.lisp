(in-package #:cl-lore.api.raw)


(defun get-chunk (label)
  (make-instance 'cl-lore.protocol.structure:included-node
                 :chunks *chunks*
                 :label label))


(defun push-chunk (label)
  (cl-lore.protocol.collecting:push-chunk *chunks* label))
