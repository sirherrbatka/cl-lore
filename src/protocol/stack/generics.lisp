(in-package #:cl-lore.protocol.stack)


(defgeneric controller-return (controller value))
(defgeneric controller-push-tree (controller description tree))
(defgeneric controller-pop-tree (controller description))
(defgeneric controller-pop-anything (controller))
(defgeneric controller-front (controller))
(defgeneric controller-empty-p (stack))
