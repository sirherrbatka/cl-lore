(in-package #:cl-lore.graphics.graph)


(defun graph-object-node-impl (object)
  (let* ((class-name (class-name object))
         (string (format nil "~a:~a"
                         (~> class-name
                             symbol-package
                             package-name)
                         (~> class-name
                             symbol-name))))
    (make-instance 'cl-dot:node
                   :attributes `(:label ,string
                                 :fontsize 10
                                 :shape :box
                                 :style :filled
                                 :fontname "Fira Mono"))))


(defmethod cl-dot:graph-object-node ((graph (eql 'class))
                                     (object closer-mop:standard-class))
  (graph-object-node-impl object))


(defmethod cl-dot:graph-object-node ((graph (eql 'class))
                                     (object closer-common-lisp:structure-class))
  (graph-object-node-impl object))


(defmethod cl-dot:graph-object-points-to ((graph (eql 'class))
                                          (object closer-mop:standard-class))
  (mapcar (lambda (x)
            (make-instance 'cl-dot:attributed
                           :object x
                           :attributes '(:weight 1
                                         :arrowhead :empty)))
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
