(in-package #:cl-lore.extensions.documentation.protocol)

(defclass lore-generator (docstample:fundamental-generator)
  ())


(defclass lore-visitor (docstample:fundamental-plist-visitor)
  ())


(def <lore-visitor> (make 'lore-visitor))
(def <lore-generator> (make 'lore-generator))


(defmethod docstample:get-visitor ((visitor lore-generator))
  <lore-visitor>)


(defmethod docstample:get-visiting-order list
    ((visitor lore-visitor)
     (type docstample:operator-node))
  '(:arguments-and-values :description :side-effects
    :exceptional-situations :examples :notes))


(defmethod docstample:get-visiting-order list
    ((visitor lore-visitor)
     (type docstample:record-node))
  '(:description))