(in-package #:cl-lore.mechanics)


(defparameter *function-color* '(rgba 77 119 203 0.7))
(defparameter *macro-color* '(rgba 153 51 204 0.7))
(defparameter *class-color* '(rgba 224 153 82 0.7))
(defparameter *struct-color* "#ff2222")
(defparameter *generic-color* '(rgba 46 83 157 0.7))
(defparameter *strong-separation-color* "#000000")
(defparameter *medium-separation-color* "#7a7a7a")
(defparameter *weak-separation-color* "#c5c5c5")


(defun frame-style (name label-color)
  `((,name
     :border 1px solid ,*weak-separation-color*
     :border-left 4px solid ,label-color
     :border-radius 0px 2px 2px 0px
     :margin-left 1em
     :margin-top 0.5em
     :margin-bottom 0.5em
     :margin-right 1em
     :padding 3px)))


(defparameter *function-style*
  (frame-style '.function-info *function-color*))


(defparameter *generic-style*
  (frame-style '.generic-info *generic-color*))


(defparameter *macro-style*
  (frame-style '.macro-info *macro-color*))


(defparameter *class-style*
  (frame-style '.class-info *class-color*))


(defparameter *centered*
  `((img.centered
     :display block
     :max-width 95%
     :margin-right auto
     :margin-left auto)))


(defparameter *struct-style*
  (frame-style '.struct-info *struct-color*))


(defparameter *top-level-style*
  `((html :font-family "Source Sans Pro" sans-serif
          :background "#f5f5f5"
          :color "#191919"
          :margin-top 0.05em
          :margin-bottom 0.05em)))


(defparameter *doc-paragraph*
  `((.doc-paragraph
     :font-size 100%
     :margin-top 3px
     :marign-bottom 3px)))


(defparameter *header-style*
  `(((:or h1 h2 h3 h4 h5 h6 h7)
     :text-align center
     :padding 1px
     :margin-bottom 0.5em
     :margin-top 1em
     :letter-spacing 0.1em)
    (h1 :font-size 180%
        :font-weight 510
        :border-bottom 1px solid ,*medium-separation-color*
        :margin-left 3em
        :margin-right 3em)
    (h2 :font-size 160%
        :font-weight 510)
    (h3 :font-size 140%
        :font-weight 510)
    (h4 :font-size 120%
        :font-weight 510)
    ((:or h5 h6 h7)
     :font-size 120%
     :letter-spacing 0.1em
     :font-weight 500)))


(defparameter *doc-name*
  `((.doc-name
     :letter-spacing 0.1em)))

(defparameter *big-title*
  `((.big-title
     :text-align center
     :letter-spacing 1em
     :padding 5px
     :font-size 200%
     :text-shadow 2px 2px 2px "#aaa"
     :border-bottom 2px solid ,*strong-separation-color*)))


(defparameter *mechanics-html-style*
  (append *header-style*
          *function-style*
          *struct-style*
          *generic-style*
          *class-style*
          *big-title*
          *macro-style*
          *top-level-style*
          *doc-paragraph*
          *doc-name*
          *centered*))
