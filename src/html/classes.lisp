(in-package #:cl-lore.html)


(defclass html-output-generator (fundamental-output-generator)
  ())


(defclass html-output (fundamental-output)
  ((%out-stream :initform (make-string-output-stream)
                :reader read-out-stream)
   (%css :type list
         :accessor access-css
         :initarg :css
         :initform nil)))
