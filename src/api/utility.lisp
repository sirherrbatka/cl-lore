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


(defmacro def-without-stack (name)
  `(defmacro ,name (&body body)
     (let ((name ,(symbol-name name)))
       (with-gensyms (!front)
         `(progn
            (begin ,name)
            (let ((,!front (controller-front *stack*))
                  (*stack* nil))
              ,@(mapcar (lambda (x) `(push-child ,!front ,x))
                        body))
            (end ,name))))))
