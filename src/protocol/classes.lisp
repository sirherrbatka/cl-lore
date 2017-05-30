(in-package #:cl-lore)


(defclass fundamental-element ()
  ((%decorators :initform (vect)
                :type vector
                :reader read-decorators)))


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


(defclass fundamental-decorator ()
  ())


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


(defclass top-stack-controller (abstract-stack-controller)
  ())


(defclass proxy-stack-controller (fundmental-stack-controller)
  ((%parent :initarg :parent
            :type fundamental-stack-controller
            :reader read-parent)
   (%callback :initarg :callback
              :type (-> (t) fundamental-decorator)
              :reader read-callback)))


(defclass internal-reference (fundamental-decorator)
  ((%label-name :initarg :label-name
                :type string
                :accessor access-label-name)))


(defclass file ()
  ((%content :initarg :content
             :accessor access-content)
   (%path :initarg :path
          :accessor access-path)))
