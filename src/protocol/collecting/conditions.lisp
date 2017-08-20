(in-package #:cl-lore.protocol.collecting)


(define-condition fundamental-collecting-condition (error)
  ((%text :initarg :text
          :reader read-text
          :type 'string)))


(define-condition no-chunk-with-label-condition
    (fundamental-collecting-condition)
  ())
