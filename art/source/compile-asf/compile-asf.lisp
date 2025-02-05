(in-package "COMPILE-ASF")

(format t "*default-baum-dir* : aendern !~%")
(defparameter *default-baum-dir* '(:absolute "home" "systeme" "art" "specs" "test"))

(defun set-spec-dir! (pathname)
  (declare (type pathname pathname))
  (setq *default-baum-dir* (pathname-directory pathname)))

(defun compile-asf (path)
  (format t "Eschbach Thu Jan 16 11:38:04 MET 1997")
  ;; (lucid::close-all-files) ;; falls Fehler, ist intern-stream noch offen !
  (let ((filename 
	 (cond ((pathnamep path)
		(subseq (namestring path) 0 (search ".asf" (namestring path) :from-end t)))
	       ((stringp path)
		(subseq (namestring (4th (modid2specident path)))
			0
			(search ".asf" (namestring (4th (modid2specident path))) :from-end t)))
	       (t (subseq (namestring (4th path))
			  0
			  (search ".asf" (namestring (4th path)) :from-end t))))))
  (create-rrl-files (first (renaming (parse path))) filename)))


  
  




