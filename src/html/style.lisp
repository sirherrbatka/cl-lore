(in-package #:cl-lore.html)


(defparameter *function-color* "#3067ff")
(defparameter *strong-separation-color* "#000000")


(defparameter *function-style*
  `((.function-info
      :border 1px solid "#A9A9A9"
      :border-left 4px solid ,*function-color*
      :padding-top 3px
      :padding-right 3px
      :padding-bottom 3px
      :padding-left 3px)))


(defparameter *header-style*
  `((h1 :text-align center)
    (h2 :text-align center)
    (h3 :text-align center)
    (h4 :text-align center)
    (h5 :text-align center)
    (h6 :text-align center)
    (h7 :text-align center)))


(defparameter *big-title*
  `((.big-title
     :text-align center
     :letter-spacing 1em
     :font-size 200%
     :border-bottom 2px solid ,*strong-separation-color*)))


(defparameter *mechanics-style*
  (append *header-style*
          *function-style*
          *big-title*))
