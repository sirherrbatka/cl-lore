(in-package #:cl-lore.graphics.graph)


(defclass fundamental-dot-graph ()
  ((%content :initarg :content
             :accessor access-content)))


(defclass vector-dot-graph (fundamental-dot-graph
                            cl-lore.graphics:vector-image)
  ())


(defclass raster-dot-graph (fundamental-dot-graph
                            cl-lore.graphics:raster-image)
  ())


(defgeneric file-format (image)
  (:method ((image vector-dot-graph))
    :svg)
  (:method ((image raster-dot-graph))
    :png))


(defgeneric file-extension (image)
  (:method ((image vector-dot-graph))
    ".svg")
  (:method ((image raster-dot-graph))
    ".png"))


(defmethod cl-lore.graphics:file-name ((image fundamental-dot-graph))
  (format nil "~a~a"
          (cl-lore.graphics:read-name image)
          (file-extension image)))


(defmethod cl-lore.graphics:save-image ((image fundamental-dot-graph)
                                        path)
  (cl-dot:dot-graph
   (access-content image)
   (cl-fad:merge-pathnames-as-file path
                                   (cl-lore.graphics:file-name image))
   :format (file-format image)))
