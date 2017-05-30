(in-package #:cl-lore)


(defmacro with-intercepted-stack (callback &body body)
  (once-only (callback)
    `(let ((*stack* (make-temporary-stack-box *stack* ,callback)))
       ,@body))
 bb)
