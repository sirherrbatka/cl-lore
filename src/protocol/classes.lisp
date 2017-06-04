(in-package #:cl-lore)


(defclass fundamental-node ()
  ((%decorators :initform (vect)
                :type vector
                :reader read-decorators)
   (%traits :type vector
            :initform (vect)
            :initarg :traits
            :accessor read-traits))
  (:metaclass lore-node-class))


(defclass fundamental-trait ()
  ())


(defclass emphasis-trait (fundamental-trait)
  ())


(defclass title-trait (fundamental-trait)
  ())


(defclass leaf-node (fundamental-node)
  ((%content :initarg :content
             :accessor access-content))
  (:metaclass lore-node-class))


(defclass function-node (fundamental-node)
  ((%name :type symbol
          :initarg :name
          :reader read-name)
   (%lambda-list :type list
                 :initarg :lambda-list
                 :reader read-lambda-list)
   (%docstring :type string
               :initarg :docstring
               :reader read-docstring))
  (:metaclass lore-node-class))


(defclass tree-node (fundamental-node)
  ((%children :initform (vect)
              :initarg :children
              :accessor read-children))
  (:metaclass lore-node-class))


(defclass titled-tree-node (tree-node)
  ((%title :initarg :title
           :accessor access-title
           :type leaf-node))
  (:metaclass lore-node-class))


(defclass chunk-node (titled-tree-node)
  ()
  (:metaclass lore-node-class))


(defclass documentation-node (tree-node)
  ((%package-name :initarg package-name
                  :type string
                  :accessor access-package-name))
  (:metaclass lore-node-class))


(defclass paragraph-trait (fundamental-trait)
  ((%title :initarg :title
           :accessor access-title
           :type leaf-node))
  (:metaclass lore-node-class))


(defclass root-node (titled-tree-node)
  ()
  (:metaclass lore-node-class))


(defclass fundamental-output-generator ()
  ())


(defclass fundamental-output ()
  ((%index :type list
           :initarg :index
           :initform nil
           :accessor access-index)
   (%labels :initform (make-hash-table :test 'equal)
            :reader read-labels)))


(defclass html-output-generator (fundamental-output-generator)
  ())


(defclass html-output (fundamental-output)
  ((%out-stream :initform (make-string-output-stream)
                :reader read-out-stream)))


(defclass fundamental-decorator ()
  ())


(defclass label (fundamental-decorator)
  ((%name :initarg :name
          :accessor access-name
          :type string)))


(defclass fundamental-stack-controller ()
  ())


(defclass abstract-stack-controller (fundamental-stack-controller)
  ((%stack :initform nil
           :accessor access-stack
           :type list)))


(defclass top-stack-controller (abstract-stack-controller)
  ((%count :initform 0
           :accessor access-count
           :type positive-fixnum)))


(defclass proxy-stack-controller (fundamental-stack-controller)
  ((%parent :initarg :parent
            :type fundamental-stack-controller
            :reader read-parent)
   (%callback :initarg :callback
              :type (-> (t) t)
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


(defclass chunks-collection ()
  ((%content :initform (make-hash-table :test 'equal)
             :reader read-content
             :type hash-table)
   (%docparser-index :initarg :docparser-index
                     :reader read-docparser-index
                     :type docparser:index)))
   
