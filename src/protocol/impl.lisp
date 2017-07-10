(in-package #:cl-lore.protocol)


(defmethod scan-element ((output fundamental-output) (element tree-node) parents)
  (let ((parents (cons element parents)))
    (iterate:iter
      (for elt in-vector (read-children element))
      (scan-element output elt parents)))
  output)



(defmethod process-element :before ((generator fundamental-output-generator)
                                    (output fundamental-output)
                                    (element fundamental-node)
                                    parents)
  (iterate
    (for trait in-vector (read-traits element))
    (before-trait generator output trait element parents)))


(defmethod process-element :after ((generator fundamental-output-generator)
                                   (output fundamental-output)
                                   (element fundamental-node)
                                   parents)
  (iterate
    (for trait in-vector (read-traits element))
    (after-trait generator output trait element parents)))


(defun todo ()
  (error "Not implemented!"))


(defun get-arg-list (fun)
  (swank-backend:arglist fun))

