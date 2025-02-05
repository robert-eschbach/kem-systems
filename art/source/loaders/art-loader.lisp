(defpackage "ART"
  (:use "COMMON-LISP"))

(in-package "ART")

(import '(common-lisp-user::*load-binary-pathname-types* 
          common-lisp-user::*load-source-pathname-types*) 'art) 

;; speed of compilation process unimportant
;; speed of the object code extremely important
(proclaim '(optimize (compilation-speed 0) (speed 3)))

(defparameter *scapa-path*  #P"/home/systeme/wisent/system/")
(defparameter *art-path*    #P"/home/systeme/art/")

(defparameter *source-path* (merge-pathnames "source/" *art-path*))

(defparameter *loader-path* (merge-pathnames "loaders/" *source-path*))

(defparameter *packages-path* (merge-pathnames "packages/" *source-path*))

(defparameter *files-to-compile* '())
(defparameter *do-not-compile* '("scpa-load"))

(defparameter *art-files*
  `(("packages"           ,*packages-path*)
    ("scpa-load"          ,*scapa-path*)
    ("compile-asf-loader" ,*loader-path*)   
    ("save-rrl-loader"    ,*loader-path*)
    ))

(defun art-loader ()
  (format t "==========================================================~%")
  (format t " ART : starting load and compile files ...~%")
  (format t "==========================================================~%")
  (loop for file in *art-files* do   
	(if (string= (first file) "scpa-load") 
	    (load (merge-pathnames (first file) (second file)))
	  (load-and-remember-to-compile (merge-pathnames (first file) (second file)))))
  (when *files-to-compile* 
    (format t "==========================================================~%")
    (format t " ART : compile files ...~%")
    (format t "==========================================================~%")
    (loop for file in *files-to-compile* do
	  (compile-file file)
	  (load file))
    (setq *files-to-compile* nil)))


(defun load-and-remember-to-compile (pathname 
		   &key (load-source-pathname-types (first *load-source-pathname-types*))
			(load-binary-pathname-types (first *load-binary-pathname-types*)))
  (let ((source-pathname (pathname (concatenate 'string (namestring pathname) "."
						load-source-pathname-types)))
	(binary-pathname (pathname (concatenate 'string (namestring pathname) "."
						load-binary-pathname-types))))
    (cond ((not (probe-file source-pathname))
	   (error "File ~A doesn't exist.~%" source-pathname))
	  ((not (probe-file binary-pathname))
	   (when (not (member pathname *files-to-compile* :test #'equal))
	     (push pathname *files-to-compile*))
	   (load source-pathname))
	  ((> (file-write-date source-pathname)
	      (file-write-date binary-pathname))
	   (push pathname *files-to-compile*)
	   (load source-pathname))
	  (t (load binary-pathname)))))

(art-loader)

(defun art-help ()
  (format t "~%~%------------------- ~%")
  (format t "ART : Informationen ~%")
  (format t "------------------- ~%")
  (format t "Das oberstes Spezifikations-Verzeichnis ist zur Zeit auf ~%")
  (format t "~A gesetzt. ~%" 
	  (make-pathname :directory compile-asf::*default-baum-dir*))
  (format t "Es stehen folgende Hauptfunktionen zur Verfuegung :~%")
  (format t "(1) compile-asf ~%")
  (format t "    Uebersetzung von ASF nach RRL~%")
  (format t "(2) xrrl ~%")
  (format t "    Aufruf von RRL~%")
  (format t "(3) save-rrl ~%")
  (format t "    Rueckuebersetzung von RRL nach ASF~%")
  (format t "(4) xvi ~%")
  (format t "    Aufruf des Editors VI~%")
  (format t "(5) set-spec-dir! ~%")
  (format t "    setzt das oberste Spezifikations-Verzeichnis~%")  
  (format t "All diese Funktionen befinden sich im package 'user.~%")
  (format t "ad (1) : Ein typischer Aufruf ist etwa '(compile-asf ~s)', hier  ~%" "naturals^1")
  (format t "wird die erste Implementation der Spezifikation naturals  ~%")
  (format t "uebersetzt. ~%")
  (format t "ad (2) Mit '(xrrl ~s)' wird das zur  ~%" "naturals^1")
  (format t "cover-set gehoerende File in RRL abgearbeitet.~%")
  (format t "ad (3) Mit '(save-rrl ~s)' wird das von RRL angelegte Protokoll nach ASF  ~%" "naturals^1")
  (format t "zurueckuebersetzt. ~%")
  (format t "ad (4) : Mit '(xvi ~s)' kann man sich das enstprechende ASF-File ~%" "naturals^1" "asf")
  (format t "und mit '(xvi ~s ~s)' das zur Cover-Set Induction ~%" "naturals^1" "rrlmr")
  (format t "gehoerende File mit dem Editor VI anschauen.~%")
  (format t "ad (5) : Moechte man das oberste Spezifikations-Verzeichnis aendern, geschieht ~%")
  (format t "dies durch die Funktion 'set-spec-dir!'. Ein typischer Aufruf ist etwa ~%")
  (format t "'(set-spec-dir! ~s)' ~%" "~/specs/test/")
  (format t "Diese Informationen werden durch den Aufruf von (art::art-help) ausgegeben.~%~%")
  (format t "Eschbach , 26.08.93~%")
  )

(art-help)


