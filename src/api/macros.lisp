(in-package #:cl-lore.api)


;; (let ((,!document (pop-stack *stack*)))
;;   (scan-element ,output ,!document nil)
;;   (process-element ,generator ,output ,!document nil))


(defmacro def-chunks (name &optional docstample-index)
  `(defparameter ,name
     (make 'chunks-collection
           :docstample-index ,docstample-index)))


(defmacro with-chunks (var &body body)
  `(let ((*chunks* ,var))
     ,@body))


(defmacro scribble-syntax ()
  `(named-readtables:in-readtable :scribble))
