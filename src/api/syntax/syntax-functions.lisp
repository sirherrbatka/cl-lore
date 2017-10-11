(in-package #:cl-lore.api.syntax)


(defun begin (what)
  (cl-lore.api.raw:controller-push-tree
   what
   (cl-lore.api.raw:make-node what)))


(defun begin-document ()
  (cl-lore.api.raw:controller-push-tree
   "root"
   (cl-lore.api.raw:make-root)))


(defun end-document ()
  (let ((result (cl-lore.api.raw:controller-pop-tree "root")))
    (setf cl-lore.api.raw:*register* nil)
    result))


(defun end (what)
  (let ((value (cl-lore.api.raw:controller-pop-tree what)))
    (cl-lore.api.raw:controller-return value)))


(defun title (text)
  (setf (cl-lore.protocol.structure:access-title
         (cl-lore.api.raw:controller-front))
        (cl-lore.api.raw:make-leaf text cl-lore.api.raw:<title-trait>))
  text)


(defmacro level (what &body body)
  (once-only (what)
    `(progn (begin ,what)
            ,@body
            (end ,what))))


(defun label (text)
  (setf (cl-lore.protocol.structure:access-label
         (cl-lore.api.raw:controller-front))
        text)
  text)


(cl-lore.api.raw:def-syntax include (what)
  (ret (cl-lore.api.raw:get-chunk what)))


(cl-lore.api.raw:def-syntax emph (text)
  (ret (cl-lore.api.raw:make-leaf
        text
        cl-lore.api.raw:<emphasis-trait>)))


(cl-lore.api.raw:def-syntax item (text)
  (ret (cl-lore.api.raw:make-item
        text)))
