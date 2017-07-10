(in-package #:cl-lore.protocol.output)


(defgeneric process-element (generator output element parents))


(defgeneric save-output (where output))
