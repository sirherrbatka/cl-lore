(in-package #:cl-lore.protocol.stack)


(define-condition stack-condition (error)
  ())


(define-condition stack-operation-not-allowed (stack-condition)
  ((%operation :initarg :operation :reader read-operation)))


(define-condition invalid-stack-state (stack-condition)
  ())
