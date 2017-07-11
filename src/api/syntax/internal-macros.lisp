(in-package #:cl-lore.api.syntax)


(defmacro def-syntax (name lambda-list &body body)
  `(defun ,name ,lambda-list
     (flet ((ret (arg)
              (cl-lore.protocol.stack:controller-return
               cl-lore.api.raw:*stack* arg)))
       ,@body)))


(defmacro def-with-stack (name function lambda-list &body body)
  (let ((fname (intern (string-upcase (concat "%" (symbol-name name))))))
    `(progn
       (def-syntax ,fname ,lambda-list ,@body)
       (defmacro ,name (&body body)
         `(with-proxy-stack ,,function (,',fname ,@body))))))


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
            (cl-lore.protocol.stack:controller-return cl-lore.api.raw:*stack* ,!node))))))
