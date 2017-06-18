(in-package #:cl-lore.api)


(defmacro document (generator names output chunks &body body)
  (with-gensyms (!document)
    (once-only (names generator)
      `(let ((*stack* (make-instance 'abstract-stack-controller))
             (*node-definitions* ,names)
             (*chunks* ,chunks)
             (,output (make-output ,generator)))
         (let ((,!document
                 (progn
                   (begin-document)
                   ,@body
                   (end-document))))
           (process-element ,generator ,output ,!document nil)
           ,output)))))

(defmacro chunk (chunks names &body body)
  (with-gensyms (!chunk)
    `(let ((*stack* (make 'top-stack-controller))
           (*node-definitions* ,names)
           (*chunks* ,chunks))
       (let ((,!chunk (progn
                        ,@body)))
         (push-chunk *chunks* ,!chunk)
         ,!chunk))))

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
