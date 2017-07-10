(in-package #:cl-lore.protocol)


(defgeneric scan-element (output element parents))
(defgeneric push-decorator (element decorator))
(defgeneric process-element (generator output element parents))
(defgeneric write-list (generator output list))
(defgeneric push-stack (desc obj stack))
(defgeneric save-output (output path))
(defgeneric make-output (generator &rest initargs))
(defgeneric add-to-index (output element parents))
(defgeneric before-trait (generator output trait owner parents))
(defgeneric after-trait (generator output trait owner parents))


(defgeneric push-chunk (chunks chunk))
(defgeneric get-chunk (chunks title))
(defgeneric query (chunks type id))

(defgeneric process-operator-plist (generator output &key &allow-other-keys))
