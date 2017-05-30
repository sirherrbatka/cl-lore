(in-package #:cl-lore)


(defgeneric scan-element (output element parents))
(defgeneric process-element (generator output element parents))
(defgeneric push-stack (desc obj stack))
(defgeneric save-output (output))
(defgeneric make-output (generator &rest initargs))
(defgeneric add-to-index (output element parents))
(defgeneric before-trait (generator output trait parents))
(defgeneric after-trait (generator output trait parents))
(defgeneric has-childrens (tree))

(defgeneric controller-return (controller value))
(defgeneric controller-push-tree (controller description tree))
(defgeneric controller-pop-tree (controller description))
(defgeneric controller-front (controller))
(defgeneric controller-empty-p (stack))
