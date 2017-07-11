(in-package #:cl-lore.api.syntax)


(defun begin (what)
  (cl-lore.protocol.stack:controller-push-tree
   cl-lore.api.raw:*stack*
   what
   (cl-lore.api.raw:make-node what)))


(defun begin-document ()
  (cl-lore.protocol.stack:controller-push-tree
   cl-lore.api.raw:*stack*
   "root"
   (cl-lore.api.raw:make-root)))


(defun end-document ()
  (let ((result (cl-lore.protocol.stack:controller-pop-tree
                 cl-lore.api.raw:*stack* "root")))
    (setf cl-lore.api.raw:*register* nil)
    result))


(defun end (what)
  (let ((value (cl-lore.protocol.stack:controller-pop-tree
                cl-lore.api.raw:*stack* what)))
    (cl-lore.protocol.stack:controller-return
     cl-lore.api.raw:*stack* value)))


(defun title (text)
  (setf (cl-lore.protocol.structure:access-title cl-lore.api.raw:*register*)
        (cl-lore.api.raw:make-leaf text cl-lore.api.raw:<title-trait>))
  text)


(defun label (text)
  (setf (cl-lore.protocol.structure:access-label cl-lore.api.raw:*register*)
        text)
  text)


(cl-lore.api.raw:def-syntax include (what)
  (ret (cl-lore.protocol.collecting:get-chunk
        cl-lore.api.raw:*chunks* what)))


(cl-lore.api.raw:def-syntax emphasis (text)
  (ret (cl-lore.api.raw:make-leaf
        text
        cl-lore.api.raw:<emphasis-trait>)))
