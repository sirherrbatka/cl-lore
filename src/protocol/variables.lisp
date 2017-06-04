(in-package #:cl-lore)


(defvar *stack*)
(defvar *tmp-stack*)
(defvar *node-definitions*)
(defvar *register* nil)
(defvar *chunks*)
(defvar *fragments* (make-hash-table :test 'equal))
(defvar *documented-package*)
