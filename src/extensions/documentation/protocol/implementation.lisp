(in-package #:cl-lore.extensions.documentation.protocol)


(defmethod cl-lore.protocol.output:process-element
    ((generator fundamental-output-generator)
     (output fundamental-output)
     (element lisp-documentation-node)
     parents)
  (cl-lore.protocol.output:process-element
   generator output
   (read-information element)
   parents))

