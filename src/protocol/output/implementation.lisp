(in-package #:cl-lore.protocol.output)


(defmethod process-element :around
    ((generator fundamental-output-generator)
     (output fundamental-output)
     (element cl-lore.protocol.structure:fundamental-node)
     parents)
  (let* ((traits (cl-lore.protocol.structure:read-traits element))
         (size (fill-pointer traits))
         (index 1))
    (if (zerop size)
        (call-next-method)
        (labels ((continuation ()
                   (if (= index size)
                       (call-next-method)
                       (apply-trait generator
                                    output
                                    (aref traits (finc index))
                                    parents
                                    #'continuation))))
          (apply-trait generator
                       output
                       (aref traits 0)
                       parents
                       #'continuation)))))


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element cl-lore.protocol.structure:tree-node)
                            parents)
  (let ((parents (cons element parents)))
    (iterate
      (for elt in-vector (cl-lore.protocol.structure:read-children element))
      (cl-lore.protocol.structure:process-element generator output elt parents)))
  element)


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element cl-lore.protocol.structure:leaf-node)
                            parents)
  (let ((data (access-content element)))
    (cl-lore.protocol.structure:process-element generator output data parents)))
