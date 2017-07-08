(in-package #:cl-lore.graphics.graph)


(defmethod cl-dot:graph-object-node ((graph (eql 'class))
                                     (object closer-mop:standard-class))
  (make-instance 'cl-dot:node
                 :attributes `(:label ,(class-name object)
                               :shape :box)))

(defmethod cl-dot:graph-object-points-to ((graph (eql 'class))
                                          (object closer-mop:standard-class))
  (mapcar (lambda (x)
            (make-instance 'cl-dot:attributed
                           :object x
                           :attributes '(:weight 3)))
          (remove (find-class 'standard-object)
                  (closer-mop:class-direct-superclasses object)
                  :test #'eq)))


(defun make-class-inheritance (class-name &optional attributes)
  (make 'vector-dot-graph
        :content (cl-dot:generate-graph-from-roots
                  'class
                  (list (find-class class-name))
                  attributes)
        :name (format nil "~A-~A"
                      (~> class-name symbol-package package-name)
                      class-name)))
