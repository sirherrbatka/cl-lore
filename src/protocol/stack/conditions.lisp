(in-package #:cl-lore.protocol.stack)


(define-condition fundamental-stack-condition (error)
  ())


(define-condition stack-operation-not-allowed (fundamental-stack-condition)
  ((%operation :initarg :operation :reader read-operation)))


(define-condition invalid-stack-state (fundamental-stack-condition)
  ())
