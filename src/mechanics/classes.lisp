(in-package #:cl-lore.mechanics)


(defclass mechanics-html-output-generator (html-output-generator)
  ())


(defclass lore-mechanics-visitor (docstample:fundamental-plist-visitor)
  ())


(defmethod docstample:get-visiting-order list
    ((visitor lore-mechanics-visitor)
     (type docstample:operator-node))
  '(:arguments-and-values :description :side-effects
    :exceptional-situations :examples :notes))


(defmethod docstample:get-visiting-order list
    ((visitor lore-mechanics-visitor)
     (type docstample:record-node))
  '(:description))
