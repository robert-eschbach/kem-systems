(in-package "ART")

(defparameter *compile-asf-path* (merge-pathnames "compile-asf/" *source-path*))

(defparameter *compile-asf-files*
  `(("scanner-art"      ,*compile-asf-path*)
    ("semantic-actions" ,*compile-asf-path*)
    ("grammar-art-def"  ,*compile-asf-path*)
    ("compile-asf"      ,*compile-asf-path*)
    ("parser-help"      ,*compile-asf-path*)
    ("parser-main"      ,*compile-asf-path*)
    ("renaming"         ,*compile-asf-path*)
    ("create-rrl-files" ,*compile-asf-path*)))

(defun compile-asf-loader ()
  (loop for file in *compile-asf-files* do      
	(load-and-remember-to-compile (merge-pathnames (first file) (second file)))))

(compile-asf-loader)