(in-package #:cl-lore)


(defgeneric scan-element (output element parents))
(defgeneric process-element (generator output element parents))
(defgeneric push-stack (desc obj stack))
(defgeneric pop-stack (desc obj stack))
(defgeneric front-stack (stack))
(defgeneric push-children (tree-node children))
