(in-package :cl-lore.extensions.sequence-graphs.graphics)


(define-constant +vertical-span+ 30)
(define-constant +horizontal-span+ 40)


(defun draw-solid-arrow (scene x y length
                         &key (direction :right))
  (assert (member direction '(:left :right)))
  (let ((right (eq direction :right)))
    (make-group scene (:fill-opacity 1.0)
      (draw* (:rect :x (if right x (+ x 5))
                    :y y
                    :width (- length 10)
                    :height 3)
             :fill "black")
      (let* ((xtip (if right (+ length x) x))
             (ytip (+ y 1.5))
             (yend ytip)
             (span 5)
             (xend (if right (- xtip 10) (+ xtip 10))))
        (draw* (:path :d (path
                           (move-to xtip ytip)
                           (line-to xend (+ yend span))
                           (line-to xend (- yend span))
                           (line-to xtip ytip)))
               :fill "black"))))
  scene)


(defun draw-dashed-arrow (scene x y length
                          &key (direction :right))
  (assert (member direction '(:left :right)))
  (let ((right (eq direction :right)))
    (make-group scene (:fill-opacity 0.5)
      (iterate
        (for position
             from (if right x (+ x 20))
             below (+ x length (if right -20 0)) by 20)
        (draw* (:rect :x position
                      :y y
                      :width 10
                      :height 3)))
      (let* ((xtip (if right (+ length x) x))
             (ytip (+ y 1.5))
             (yend ytip)
             (span 4)
             (xend (if right (- xtip 10) (+ xtip 10)))
             (end (if right -6 6)))
        (draw* (:path :d (path
                           (move-to xend (+ yend span))
                           (line-to xtip ytip)
                           (line-to xend (- yend span))
                           (line-to (+ xend end) (- yend span))
                           (line-to (+ xtip end) ytip)
                           (line-to (+ xend end) (+ yend span))))
               :fill "black"))))
  scene)

(defun draw-axis (scene x y length name)
  (let* ((shift (/ (text-size name) 2))
         (text-box-size (+ 30 (* 2 shift))))
    (make-group scene (:fill-opacity 1.0)
      (text scene (:x (- x shift)
                   :y y
                   :style "font-family:'Iosevka'font-size:15.0px")
        name)
      (draw* (:rect :x (- x (/ text-box-size 2))
                    :y (- y 20)
                    :fill "none"
                    :stroke "black"
                    :stroke-opacity 0.2
                    :width text-box-size
                    :height 28))
      (iterate
        (for position
             from (+ 10 y)
             below (+ y length)
             :by 20)
        (draw* (:rect :x x
                      :y position
                      :width 3
                      :height 15
                      :fill-opacity 0.2
                      :fill "black")))))
  scene)


(defun draw-block (scene x y length)
  (make-group scene (:fill-opacity 1.0)
    (draw* (:rect :x (- x 6)
                  :y y
                  :height length
                  :width 16
                  :fill "white"
                  :stroke "black"))))


(defclass sequence-element ()
  ((%children :reader read-children
              :initarg :children
              :initform (make-array 0)
              :type vector)
   (%parent :initarg :parent
            :accessor access-parent
            :initform nil)
   (%vertical-position-start :accessor access-vertical-position-start
                             :type number
                             :initform 0)
   (%vertical-position-end :accessor access-vertical-position-end
                           :type number
                           :initform 0)))


(defclass axis ()
  ((%x-position :accessor access-x-position)
   (%y-position :accessor access-y-position
                :initform 0)
   (%name :reader access-name
          :initarg :name
          :initform "")
   (%box-size :reader read-box-size)))


(defclass block-element (sequence-element)
  ((%axis :accessor access-axis
          :initform nil)
   (%axis-name :initarg :axis-name
               :reader read-axis-name)
   (%minimal-height :allocation :class
                    :initform +vertical-span+
                    :reader read-minimal-height)))


(defclass call (sequence-element)
  ((%to :reader read-to)
   (%from :initarg :from
          :reader read-from)
   (%name :initarg :name
          :reader read-name)))


(defmethod initialize-instance :after ((elt call) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (slot-value elt '%to)
        (if (emptyp (read-children elt))
            nil
            (elt (read-children elt) 0))))


(defclass sync-call (call)
  ((%minimal-height :allocation :class
                    :reader read-minimal-height
                    :initform (* 6 +vertical-span+))))


(defclass async-call (call)
  ((%minimal-height :allocation :class
                    :reader read-minimal-height
                    :initform +vertical-span+)))


(defgeneric init-with-parent (element parent context parents))


(defmethod init-with-parent ((element sequence-element) (parent sequence-element) context parents)
  (let ((end (iterate
               (for child in-vector (read-children element))
               (finding child maximizing (access-vertical-position-end child)))))
    (setf (access-vertical-position-end parent)
          (+ +vertical-span+ 500 (access-vertical-position-end end)))))


(defmethod init-with-parent ((element call) (parent block-element) context parents)
  (setf (slot-value element '%from)
        (access-axis parent))
  (if (emptyp (read-children element))
      (setf (access-vertical-position-end parent)
            (access-vertical-position-end element))
      (call-next-method)))


(defmethod init-with-parent ((element block-element) (parent call) context parents) 
  (setf (access-vertical-position-start element)
        (access-vertical-position-start parent)

        (slot-value parent '%to)
        (access-axis element)))


(defun text-size (string)
  (* 7.5 (length string)))


(defun initialize-box-size (element)
  (setf (slot-value element '%box-size)
        (text-size (slot-value element '%name))))


(defmethod (setf access-name) :after (value (element axis))
  (initialize-box-size element))


(defmethod initialize-instance :after ((element axis) &rest arg &key &allow-other-keys)
  (declare (ignore arg))
  (initialize-box-size element))


(defmethod initialize-instance ((element sequence-element) &rest arg &key &allow-other-keys)
  (call-next-method)
  (map-children element
                (lambda (x)
                  (setf (access-parent x) element))))


(defmethod init-with-parent ((element block-element)
                             (parent (eql nil))
                             context
                             parents)
  nil)


(defgeneric map-children (element fn)
  (:method ((elt sequence-element) fn)
    (map nil
         fn
         (read-children elt))))


(defgeneric reduce-children (element fn &rest keys)
  (:method ((elt sequence-element) fn &rest keys)
    (apply #'reduce fn
           (read-children elt)
           keys)))


(defgeneric vertical-span (element)
  (:method ((elt sequence-element))
    (max (read-minimal-height elt) +vertical-span+))
  (:method ((elt async-call))
    (/ +vertical-span+ 2))
  (:method ((elt block-element))
    +vertical-span+))


(defgeneric scan-tree (root fn &key only-of-class))


(defmethod scan-tree ((root sequence-element) fn &key (only-of-class t))
  (when (typep root only-of-class)
    (funcall fn root))
  (map-children root
                (lambda (x)
                  (scan-tree x fn :only-of-class only-of-class))))


(defgeneric init-element (element vertical context parents)
  (:method ((element sequence-element) vertical context parents)
    (setf (access-vertical-position-start element)
          vertical)
    (let ((v vertical))
      (map-children element
                    (let ((parents (cons element parents)))
                      (lambda (x)
                        (init-element x
                                      v
                                      context
                                      parents)
                        (setf v (+ +vertical-span+ (access-vertical-position-end x))
                              vertical (access-vertical-position-end x)))))
      (if (emptyp (read-children element))
          (setf (access-vertical-position-end element)
                (+ vertical
                   (vertical-span element)))
          (setf (access-vertical-position-end element)
                vertical))
      (init-with-parent element (first parents) context parents)))
  (:method ((element block-element) vertical context parents)
    (call-next-method)
    (when (typep (access-parent element) 'sync-call)
      (incf (access-vertical-position-end element)
            15))
    (decf (access-vertical-position-start element)
          5)))


(defgeneric draw-element (element context))


(defgeneric draw-diagram (context output))


(defun depth-scan (input)
  (labels ((impl (ac elt)
             (if (emptyp (read-children elt))
                 (max (access-vertical-position-end elt))
                 (reduce-children elt #'impl :initial-value ac))))
    (impl 0 input)))


(defclass context (cl-lore.graphics:vector-image)
  ((%axis :accessor access-axis
          :initarg :axis
          :type list)
   (%scene :initarg :scene
           :accessor access-scene
           :initform nil)
   (%width :accessor access-width
           :type number
           :initform 0)
   (%height :accessor access-height
            :type number
            :initform 0)
   (%root :accessor access-root
          :initarg :root
          :initform nil)))


(defmethod cl-lore.graphics:file-name ((img context))
  (concatenate 'string (cl-lore.graphics:access-name img)
               ".svg"))


(defun init-root (obj)
  (unless (null (access-root obj))
    (scan-tree (access-root obj)
               (lambda (x)
                 (setf (access-axis x)
                       (find (read-axis-name x)
                             (access-axis obj)
                             :key #'access-name
                             :test #'string=)))
               :only-of-class 'block-element)
    (init-element (access-root obj)
                  (* 2 +vertical-span+)
                  obj
                  nil)))


(defun init-axis (obj)
  (let* ((axis (access-axis obj)))
    (iterate
      (for a in axis)
      (for box-size = (read-box-size a))
      (for p-box-size previous box-size)
      (sum (+ (/ box-size 2)
              +horizontal-span+
              (/ (or p-box-size 0) 2))
           into position)
      (setf (access-y-position a) +vertical-span+
            (access-x-position a) (float position)))
    (unless (null (access-root obj))
      (scan-tree (access-root obj)
                 (lambda (x)
                   (let* ((to (read-to x))
                          (from (read-from x))
                          (text-size (+ +horizontal-span+ (text-size (read-name x))))
                          (distance (abs (- (access-x-position to)
                                            (access-x-position from)))))
                     (when (< distance text-size)
                       (let* ((shifted-axis (iterate
                                              (for s in (list to from))
                                              (finding s maximizing (access-x-position s))))
                              (offset (abs (- text-size distance)))
                              (rest (iterate
                                      (for a on axis)
                                      (finding a such-that (eq (car a) shifted-axis)))))
                         (iterate
                           (for a in rest)
                           (incf (access-x-position a)
                                 offset))))))
                 :only-of-class 'call))))


(defun init-context (obj)
  (unless (null (access-root obj))
    (setf (access-height obj) (+ +vertical-span+
                                 (depth-scan (access-root obj)))))

  (setf (access-width obj) (+ (* 2 +horizontal-span+)
                              (let ((last (car (last (access-axis obj)))))
                                (+ (/ (read-box-size last) 2)
                                   (access-x-position last)
                                   +horizontal-span+)))

        (access-scene obj) (make-svg-toplevel 'svg-1.1-toplevel
                                              :height (access-height obj)
                                              :width (access-width obj))))


(defmethod draw-element ((element axis) (context context))
  (draw-axis (access-scene context)
             (float (access-x-position element))
             (float (access-y-position element))
             (float (access-height context))
             (access-name element)))


(defmethod draw-element ((element block-element) (context context))
  (draw-block (access-scene context)
              (access-x-position (access-axis element))
              (access-vertical-position-start element)
              (- (access-vertical-position-end element)
                 (access-vertical-position-start element))))


(defmethod draw-element ((element sync-call) (context context))
  (let* ((pos1 (access-x-position (read-from element)))
         (pos2 (access-x-position (read-to element)))
         (distance (abs (- pos1 pos2))))
    (draw-dashed-arrow (access-scene context)
                       (+ (min pos1 pos2) 15)
                       (access-vertical-position-end element)
                       (- distance 25)
                       :direction (if (< pos1 pos2) :left :right))
    (call-next-method)))


(defmethod draw-element ((element call) (context context))
  (let* ((pos1 (access-x-position (read-from element)))
         (pos2 (access-x-position (read-to element)))
         (distance (abs (- pos1 pos2)))
         (center (+ (min pos1 pos2) (/ distance 2.0))))
    (draw-solid-arrow (access-scene context)
                      (+ (min pos1 pos2) 15)
                      (access-vertical-position-start element)
                      (- distance 25)
                      :direction (if (< pos1 pos2) :right :left))
    (let* ((name (read-name element))
           (shift (text-size name)))
      (text (access-scene context)
          (:x (- center (/ shift 2))
           :y (- (access-vertical-position-start element)
                 6)
           :style "font-family:'Iosevka';font-size:15.0px"
           :fill "teal")
        name))))


(defmethod initialize-instance :after ((obj context) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (init-root obj)
  (init-axis obj)
  (init-context obj))


(defmethod draw-diagram ((obj context) output)
  (iterate
    (for a in (access-axis obj))
    (draw-element a obj))
  (unless (null (access-root obj))
    (scan-tree (access-root obj)
               (lambda (x)
                 (draw-element x obj))))
  (stream-out output (access-scene obj)))


(defmethod cl-lore.graphics:save-image ((obj context) path)
  (with-open-file
      (s
       (cl-fad:merge-pathnames-as-file path
                                       (cl-lore.graphics:file-name obj))
       :direction :output :if-exists :supersede)
    (draw-diagram obj s)
    obj))


(defgeneric seq (name options &rest children))


(defmethod seq ((name (eql :block)) options &rest children)
  (apply #'make-instance
         'block-element
         (append (list :children (coerce children 'vector))
                 options)))


(defmethod seq ((name (eql :sync)) options &rest children)
  (apply #'make-instance
         'sync-call
         (append (list :children (coerce children 'vector))
                 options)))


(defmethod seq ((name (eql :async)) options &rest children)
  (apply #'make-instance
         'async-call
         (append (list :children (coerce children 'vector))
                 options)))


(defun make-axis (name)
  (make-instance 'axis
                 :name name))


(defun make-context (axis root)
  (make-instance 'context
                 :axis axis
                 :root root))

