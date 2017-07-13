(in-package #:cl-lore.extensions.documentation.protocol)


(defclass lore-visitor (docstample:fundamental-plist-visitor)
  ())


(defmethod docstample:get-visiting-order list
    ((visitor lore-visitor)
     (type docstample:operator-node))
  '(:arguments-and-values :description :side-effects
    :exceptional-situations :examples :notes))


(defmethod docstample:get-visiting-order list
    ((visitor lore-visitor)
     (type docstample:record-node))
  '(:description))
