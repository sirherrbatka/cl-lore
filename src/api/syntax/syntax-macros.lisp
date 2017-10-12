(in-package #:cl-lore.api.syntax)


(defmacro document ((generator output chunks &key output-options) &body body)
  (with-gensyms (!document)
    (once-only (generator)
      `(let ((cl-lore.api.raw:*stack*
               (make-instance 'cl-lore.protocol.stack:top-stack-controller))
             (cl-lore.api.raw:*chunks* ,chunks)
             (,output (cl-lore.protocol.output:make-output ,generator ,@output-options)))
         (let ((,!document
                 (progn
                   (begin-document)
                   ,@body
                   (end-document))))
           (cl-lore.protocol.output:process-element
            ,generator
            ,output
            ,!document
            nil)
           ,output)))))


(defmacro chunk (chunks &body body)
  (with-gensyms (!chunk)
    `(let ((cl-lore.api.raw:*stack*
             (make 'cl-lore.protocol.stack:top-stack-controller))
           (cl-lore.api.raw:*chunks* ,chunks))
       (let ((,!chunk (progn
                        ,@body)))
         (cl-lore.api.raw:push-chunk ,!chunk)
         ,!chunk))))


(cl-lore.api.raw:def-without-stack text
    (cl-lore.api.raw:make-sequence-node
     cl-lore.api.raw:<paragraph-trait>))


(cl-lore.api.raw:def-without-stack row
    (cl-lore.api.raw:make-row))


(cl-lore.api.raw:def-without-stack title-row
    (cl-lore.api.raw:make-title-row))


(cl-lore.api.raw:def-without-stack column
  (cl-lore.api.raw:make-column))


(defmacro def-chunks (name)
  `(defparameter ,name
     (make 'cl-lore.protocol.collecting:chunks-collection)))


(defmacro syntax (&rest other-syntax)
  `(progn
     (named-readtables:in-readtable :scribble-both)
     (scribble:enable-sub-scribble-syntax)
     (use-package :cl-lore.api.syntax)
     ,@(mapcar (lambda (x)
                 `(use-package
                   ,(intern (symbol-name x) (find-package 'keyword))))
               other-syntax)))


(defmacro with-names ((&rest additional-names)
                      &body body)
  `(let ((cl-lore.api.raw:*node-definitions*
           (merge-tables <standard-names>
                         ,@additional-names)))
     ,@body))


(defmacro level (what &body body)
  (with-gensyms (!what)
    `(let ((,!what ,what))
       (begin ,!what)
       ,@body
       (end ,!what))))
