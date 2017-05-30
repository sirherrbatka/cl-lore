(in-package #:cl-lore)


(defmacro without-stack (proxy-function &rest body))

(defmacro with-proxy-stack (proxy-function &rest body))
