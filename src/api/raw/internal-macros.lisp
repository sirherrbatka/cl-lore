(in-package #:cl-lore.api.raw)


(defmacro def-syntax (name lambda-list &body body)
  `(defun ,name ,lambda-list
     (flet ((,(intern "RET" (symbol-package name)) (arg)
              (cl-lore.api.raw:controller-return arg)))
       ,@body)))


(defmacro def-without-stack (name construct)
  `(defmacro ,name (&body body)
     (let ((construct ',construct))
       (with-gensyms (!node)
         `(let ((,!node ,construct))
            (let ((cl-lore.api.raw:*stack* 'nil))
              ,@(mapcar
                 (lambda (x) `(let ((var ,x))
                                (when (typep var 'cl-lore.protocol.structure:tree-node)
                                  (error "Trying to insert tree node into bottom level node."))
                                (cl-lore.protocol.structure:push-child ,!node var)))
                 body))
            (cl-lore.api.raw:controller-return ,!node))))))
