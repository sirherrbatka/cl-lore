(in-package #:cl-lore.api.raw)


(defun controller-empty-p ()
  (cl-lore.protocol.stack:controller-empty-p
   *stack*))


(defun controller-front ()
  (cl-lore.protocol.stack:controller-front
   *stack*))


(defun controller-pop-tree (desc)
  (cl-lore.protocol.stack:controller-pop-tree
   *stack*))


(defun controller-push-tree (desc tree)
  (cl-lore.protocol.stack:controller-push-tree
   *stack* desc tree))


(defun controller-pop-anything ()
  (cl-lore.protocol.stack:controller-pop-anything
   *stack*))


(defun controller-return (value)
  (cl-lore.protocol.stack:controller-return
   *stack* value))
