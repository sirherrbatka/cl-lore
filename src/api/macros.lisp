(in-package #:cl-lore)


(defmacro document (generator names output &body body)
  (with-gensyms (!document)
    (once-only (names generator)
      `(let ((*stack* (make-instance 'stack-box))
             (*node-definitions* ,names)
             (,output (make-output ,generator)))
         (begin-document)
         ,@body
         (end-document)))))

;; (let ((,!document (pop-stack *stack*)))
;;   (scan-element ,output ,!document nil)
;;   (process-element ,generator ,output ,!document nil))