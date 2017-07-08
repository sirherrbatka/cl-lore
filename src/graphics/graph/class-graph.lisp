(in-package #:cl-lore.graphics.graph)


(defmethod cl-dot:graph-object-node ((graph (eql 'example))
                                     (object closer-mop:standard-class))
  (make-instance 'cl-dot:node
                 :attributes `(:label ,(class-name object)
                               :shape :box)))

(defmethod cl-dot:graph-object-points-to ((graph (eql 'example))
                                          (object closer-mop:standard-class))
  (mapcar (lambda (x)
            (make-instance 'cl-dot:attributed
                           :object x
                           :attributes '(:weight 3)))
          (remove (find-class 'standard-object)
                  (closer-mop:class-direct-superclasses object)
                  :test #'eq)))
