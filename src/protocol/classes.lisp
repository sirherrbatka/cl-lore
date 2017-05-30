(in-package #:cl-lore)


(defclass fundamental-element ()
  ())


(defclass fundamental-text-trait ()
  ())


(defclass emphasis-trait ()
  ())


(defclass title-trait ()
  ())


(defclass leaf-node (fundamental-element)
  ((%content :initarg :content
             :accessor access-content)
   (%traits :type list
            :initform nil
            :initarg :traits
            :accessor access-traits)))


(defclass tree-node (fundamental-element)
  ((%children :initform (vect)
              :initarg :children
              :accessor read-children)))


(defclass root-node (tree-node)
  ())


(defclass paragraph-node (tree-node)
  ())


(defclass section-node (tree-node)
  ((%title :initarg :title
           :accessor access-title)))


(defclass fundamental-output-generator ()
  ())


(defclass fundamental-output ()
  ((%index :type list
           :initarg :index
           :initform nil
           :accessor access-index)
   (%labels :initform (make-hash-table :test 'equal)
            :reader read-labels)))


(defclass fundamental-decorator (fundamental-element)
  ((%content :initarg :content
             :accessor access-content)))


(defclass label (fundamental-decorator)
  ((%name :initarg :name
          :accessor access-name
          :type string)))


(defclass fundamental-stack-controller ()
  ())


(defclass abstract-stack-controller ()
  ((%stack :initform nil
           :accessor access-stack
           :type list)))


(defclass internal-stack-controller (fundamental-stack-controller)
  ())


(defclass top-stack-controller (abstract-stack-controller)
  ())


(defclass proxy-stack-controller ()
  ((%parent :initarg :parent
            :type fundamental-stack-controller
            :reader read-parent)
   (%callback :initarg :callback
              :type (-> (t) fundamental-decorator)
              :reader read-callback)))


(defclass proxy-internal-stack-controller (proxy-stack-controller internal-stack-controller)
  ())


(defclass proxy-abstract-stack-controller (proxy-stack-controller abstract-stack-controller)
  ())


(defclass temporary-stack-box (stack-box)
  ((%children :initform (vect)
              :reader read-children
              :type vector)
   (%parent-stack :type stack-box
                  :initarg :parent-stack
                  :reader read-parent-stack)
   (%decorator-callback :type (-> (t) fundamental-decorator)
                        :initarg :decorator-callback
                        :reader read-decorator-callback)))


(defun make-temporary-stack-box (parent callback)
  (make 'temporary-stack-box
        :parent-stack parent
        :decorator-callback callback))


(defclass internal-reference (fundamental-decorator)
  ((%label-name :initarg :label-name
                :type string
                :accessor access-label-name)))


(defclass file ()
  ((%content :initarg :content
             :accessor access-content)
   (%path :initarg :path
          :accessor access-path)))
