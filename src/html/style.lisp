(in-package #:cl-lore.html)


(defparameter *function-color* "#3067ff")
(defparameter *strong-separation-color* "#000000")


(defparameter *function-style*
  `((.function-info
      :border 1px solid "#A9A9A9"
      :border-left 4px solid ,*function-color*
      :border-radius 0px 2px 2px 0px
      :margin-left 1em
      :margin-right 1em
      :padding 3px)))


(defparameter *header-style*
  `(((:or h1 h2 h3 h4 h5 h6 h7)
     :text-align center)))


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
