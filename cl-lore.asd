(in-package #:cl-user)


(asdf:defsystem cl-lore
  :name "cl-lore"
  :version "0.0.0"
  :license "MIT"
  :author "Lisp Mechanics"
  :maintainer "Lisp Mechanics"
  :depends-on (:iterate :alexandria :serapeum
               :scribble :cl-who :docstample
               :closer-mop :lass :cl-fad
               :cl-dot)
  :serial T
  :pathname "src"
  :components ((:file "package")
               (:module "protocol"
                :components ((:file "package")
                             (:file "mop")
                             (:file "nodes")
                             (:file "traits")
                             (:file "classes")
                             (:file "output")
                             (:file "control")
                             (:file "generics")
                             (:file "variables")
                             (:file "impl")))
               (:module "api"
                :components ((:file "package")
                             (:file "utility")
                             (:file "macros")
                             (:file "mapping")
                             (:file "syntax-functions")
                             (:file "make-functions")
                             (:file "interface-variables")))
               (:module "graphics"
                :components ((:file "package")
                             (:module "graph"
                              :components ((:file "package")
                                           (:file "class-graph")))))
               (:module "html"
                :components ((:file "package")
                             (:file "classes")
                             (:file "common")))
               (:module "mechanics"
                :components ((:file "package")
                             (:file "style")
                             (:file "classes")
                             (:file "variables")
                             (:file "implementation")))))

(let* ((dgraph (cl-dot:generate-graph-from-roots
                'example
                (list (find-class 'cl-ds.dicts.hamt:transactional-hamt-dictionary))
                '(:bgcolor :white))))
  (cl-dot:dot-graph dgraph #p"/home/shka/test.png" :format :png))

(let* ((data '(a b c #1=(b z) c d #1#))
       (dgraph (cl-dot:generate-graph-from-roots 'example (list data)
                                                 '(:rankdir "LR"))))
  (cl-dot:dot-graph dgraph "test-lr.png" :format :png))
