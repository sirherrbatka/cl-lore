(in-package #:cl-lore.protocol.stack)


(define-condition fundamental-stack-condition (error)
  ((%text :type string
          :initarg :text
          :reader read-text)))


(define-condition stack-operation-not-allowed (fundamental-stack-condition)
  ((%operation :initarg :operation :reader read-operation)))


(define-condition invalid-stack-state (fundamental-stack-condition)
  ())


(defmethod print-object ((object fundamental-stack-controller) stream)
  (format stream "~a" (read-text object)))
