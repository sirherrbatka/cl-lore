(in-package #:cl-lore.api.raw)


(define-condition fundamental-api-error (error)
  ())


(define-condition node-construction-error (fundamental-api-error)
  ())
