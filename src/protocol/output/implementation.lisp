(in-package #:cl-lore.protocol.output)


(defmethod process-element :around
    ((generator fundamental-output-generator)
     (output fundamental-output)
     (element cl-lore.protocol.structure:fundamental-node)
     parents)
  (let* ((traits (cl-lore.protocol.structure:read-traits element))
         (size (length traits))
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
    (cl-lore.protocol.structure:map-children
     (lambda (elt)
       (process-element generator output elt parents))
     element))
  element)


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element cl-lore.protocol.structure:leaf-node)
                            parents)
  (let ((data (cl-lore.protocol.structure:access-content element)))
    (process-element generator output data parents)))


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element cl-lore.protocol.structure:item-node)
                            parents)
  (contextual-process-element generator
                              output
                              element
                              (car parents)
                              parents))
