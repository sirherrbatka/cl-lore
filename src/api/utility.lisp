(in-package #:cl-lore.api)


(defmacro without-stack (proxy-function &rest body)
  (let ((stack (if (print proxy-function)
                   `(make 'proxy-stack-controller :callback ',proxy-function)
                   `(make 'proxy-stack-controller))))
    `(let ((*tmp-stack* *stack*) (*stack* ,stack))
       ,@body)))


(defmacro with-proxy-stack (proxy-function &rest body)
  (let ((stack (if proxy-function
                   `(make 'proxy-stack-controller :parent *stack* :callback ',proxy-function)
                   `(make 'proxy-stack-controller :parent *stack*))))
    `(let ((*tmp-stack* *stack*) (*stack* ,stack))
       ,@body)))


(defmacro def-syntax (name lambda-list &body body)
  `(defun ,name ,lambda-list
     (flet ((ret (arg)
              (controller-return *stack* arg)))
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
            (let ((*stack* 'nil))
              ,@(mapcar
                 (lambda (x) `(let ((var ,x))
                                (when (typep var 'cl-lore.protocol:tree-node)
                                  (error "Trying to insert tree node into bottom level node."))
                                (cl-lore.protocol:push-child ,!node var)))
                 body))
            (cl-lore.protocol:controller-return *stack* ,!node))))))
