(in-package #:cl-lore.api)


(defun make-node (descriptor &rest initargs)
  (let ((function (gethash (string-downcase descriptor)
                           *node-definitions*)))
    (when (null function)
      (error "Descriptor ~a does not reference any node in the *node-definitions*"
             descriptor))
    (apply function initargs)))


(defun depth (parents type)
  (reduce (lambda (prev next)
            (if (typep next type)
                (1+ prev)
                prev))
          parents
          :initial-value 0))
