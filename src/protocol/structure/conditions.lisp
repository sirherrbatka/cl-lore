(in-package #:cl-lore.protocol.structure)


(define-condition fundamental-structure-condition (error)
  ())


(define-condition modification-not-allowed (fundamental-structure-condition)
  ())


(define-condition invalid-node-condition (fundamental-structure-condition)
  ())
