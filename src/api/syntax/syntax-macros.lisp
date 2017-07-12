(in-package #:cl-lore.api.syntax)


(defmacro document ((generator names output chunks &key output-options) &body body)
  (with-gensyms (!document)
    (once-only (names generator)
      `(let ((cl-lore.api.raw:*stack* (make-instance 'cl-lore.protocol.stack:abstract-stack-controller))
             (*node-definitions* ,names)
             (cl-lore.api.raw:*chunks* ,chunks)
             (,output (make-output ,generator ,@output-options)))
         (let ((,!document
                 (progn
                   (begin-document)
                   ,@body
                   (end-document))))
           (process-element ,generator ,output ,!document nil)
           ,output)))))


(defmacro chunk (chunks names &body body)
  (with-gensyms (!chunk)
    `(let ((cl-lore.api.raw:*stack* (make 'top-stack-controller))
           (*node-definitions* ,names)
           (cl-lore.api.raw:*chunks* ,chunks))
       (let ((,!chunk (progn
                        ,@body)))
         (push-chunk cl-lore.api.raw:*chunks* ,!chunk)
         ,!chunk))))


(cl-lore.api.raw:def-without-stack text
    (cl-lore.api.raw:make-tree
     cl-lore.api.raw:<paragraph-trait>))


(defmacro syntax (&rest other-syntax)
  `(progn
     (named-readtables:in-readtable :scribble)
     (use-package :cl-lore.api.syntax)
     ,@(mapcar (lambda (x)
                 `(use-package ,x))
               other-syntax)))
