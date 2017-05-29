(in-package #:cl-lore)


(defmacro intercepted-stack (operation on-result)
  (let ((old-stack *stack*)
        (*stack* (make 'stack-box))
        (mock (make 'tree-node)))
    (push-stack "mock" mock)
    (let ((res (progn ,@operation)))
      (if (has-children mock)
          (on-result ())))))
