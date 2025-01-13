(in-package 'common-lisp-user)

(defun load-art ()
  (load "/home/systeme/art/source/loaders/art-loader"))

(format t "type '(load-art)' to load ART~%")

#+:cmu 
(progn 
  (defparameter *load-binary-pathname-types* *load-object-types*)
  (defparameter *load-source-pathname-types* *load-source-types*)
  (export '(*load-binary-pathname-types* *load-source-pathname-types*)))






