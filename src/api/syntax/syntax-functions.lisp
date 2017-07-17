(in-package #:cl-lore.api.syntax)


(defun begin (what)
  (cl-lore.api.raw:stack-push-tree
   what
   (cl-lore.api.raw:make-node what)))


(defun begin-document ()
  (cl-lore.api.raw:stack-push-tree
   "root"
   (cl-lore.api.raw:make-root)))


(defun end-document ()
  (let ((result (cl-lore.api.raw:stack-pop-tree "root")))
    (setf cl-lore.api.raw:*register* nil)
    result))


(defun end (what)
  (let ((value (cl-lore.api.raw:stack-pop-tree what)))
    (cl-lore.api.raw:stack-return value)))


(defun title (text)
  (setf (cl-lore.protocol.structure:access-title
         (cl-lore.api.raw:stack-front))
        (cl-lore.api.raw:make-leaf text cl-lore.api.raw:<title-trait>))
  text)


(defun label (text)
  (setf (cl-lore.protocol.structure:access-label
         (cl-lore.api.raw:stack-front))
        text)
  text)


(cl-lore.api.raw:def-syntax include (what)
  (ret (cl-lore.protocol.collecting:get-chunk
        cl-lore.api.raw:*chunks* what)))


(cl-lore.api.raw:def-syntax emph (text)
  (ret (cl-lore.api.raw:make-leaf
        text
        cl-lore.api.raw:<emphasis-trait>)))
