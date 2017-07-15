(in-package #:cl-lore.extensions.documentation.protocol)


(defmethod cl-lore.protocol.output:process-element
    ((generator cl-lore.protocol.output:fundamental-output-generator)
     (output cl-lore.protocol.output:fundamental-output)
     (element lisp-documentation-node)
     parents)
  (cl-lore.protocol.output:process-element
   generator output
   (read-information element)
   parents))

