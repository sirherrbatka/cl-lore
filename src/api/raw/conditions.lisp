(in-package #:cl-lore.api.raw)


(define-condition fundamental-api-error (error)
  ((%text :initarg :text
          :reader read-text)))


(define-condition node-construction-error (fundamental-api-error)
  ())


(defmethod print-object ((o fundamental-api-error) stream)
  (format stream "~a" (read-text o)))
