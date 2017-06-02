(in-package #:cl-lore)


(defmacro document (generator names output &body body)
  (with-gensyms (!document)
    (once-only (names generator)
      `(let ((*stack* (make-instance 'abstract-stack-controller))
             (*node-definitions* ,names)
             (,output (make-output ,generator)))
         (let ((,!document
                 (progn
                   (begin-document)
                   ,@body
                   (end-document))))
           (process-element ,generator ,output ,!document nil)
           (~> ,output
               read-out-stream
               get-output-stream-string))))))

;; (let ((,!document (pop-stack *stack*)))
;;   (scan-element ,output ,!document nil)
;;   (process-element ,generator ,output ,!document nil))
