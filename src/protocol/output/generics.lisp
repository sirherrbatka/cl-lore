(in-package #:cl-lore.protocol.output)


(defgeneric process-element (generator output element parents))
(defgeneric apply-trait (generator output trait parents continue))
(defgeneric save-output (where output))
(defgeneric make-output (generator &rest initargs))

