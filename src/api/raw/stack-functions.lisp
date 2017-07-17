(in-package #:cl-lore.api.raw)


(defun stack-empty-p ()
  (cl-lore.protocol.stack:controller-empty-p
   *stack*))


(defun stack-front ()
  (cl-lore.protocol.stack:controller-front
   *stack*))


(defun stack-pop-tree (desc)
  (cl-lore.protocol.stack:controller-pop-tree
   *stack*))


(defun stack-push-tree (desc tree)
  (cl-lore.protocol.stack:controller-push-tree
   *stack* desc tree))


(defun stack-pop-anything ()
  (cl-lore.protocol.stack:controller-pop-anything
   *stack*))


(defun stack-return (value)
  (cl-lore.protocol.stack:controller-return
   *stack* value))
