;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;                                                   ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;      haupt- und check-funktionen                  ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;                                                   ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "COMPILE-ASF") 

;; Eschbach Sun Feb  2 18:37:38 MET 1997
#+:cmu (import 'ext:run-program)


;(proclaim '(special *wird-importiert-flag*))
;(proclaim '(special  *wird-geerbt*))

;; Eschbach Wed Sep  8 12:38:19 MET DST 1993
(defvar *trace-level* 20)
(defvar *trace-output-stream* t)

;; Eschbach Wed Sep  8 12:38:19 MET DST 1993
(defun trace-output (level str &rest args)
  (if (<= level *trace-level*)
      (format *trace-output-stream* str (car args))))

(defvar *wird-importiert-flag* 
  "globale variable die dem parser anzeigt ob ein file 
  momentan importiert wird oder ob es das root-file oder ein
  abhaengiges file ist")
(defvar *wird-geerbt* nil
  "globale variable, die dem parser anzeigt op ein file
   geerbt wird")
(defvar  *schon-geparst* nil
  "globales flag in welchem die schon geparsten files aufgehoben werden"
  )
(defvar alist nil
 "globale assoc liste in der die bisher geparsten zwischendarstellungen stehen
  als key dient der pfad")


(setq *build-in-booleans* 
       '((("bool" ("boolean" nil nil nil) "export" "sort"))
         (((("and"."infix") ("bool" "bool") ("bool")) ("boolean" nil nil nil)
	   "export" "function")
	  ((("or"."infix") ("bool" "bool") ("bool")) ("boolean" nil nil nil)
	   "export" "function")
	  ((("xor"."infix") ("bool" "bool") ("bool")) ("boolean" nil nil nil)
	   "export" "function")
	  ((("equ"."infix") ("bool" "bool") ("bool")) ("boolean" nil nil nil)
	   "export" "function")
	  ((("not"."functor") ("bool") ("bool")) ("boolean" nil nil nil)
	   "export" "function")
	  ((("false"."functor") nil ("bool")) ("boolean" nil nil nil)
	   "export" "function")
	  ((("true"."functor") nil ("bool")) ("boolean" nil nil nil)
	   "export" "function")
	((("=" . "infix") ("bool" "bool") ("bool")) ("boolean" nil nil nil)
	   "export" "function")
	   ;;;; "=" wurde nachtraeglich eingefuegt 29 4 1992
	  )
	  nil
	  nil
	  (nil nil nil nil nil)
	  nil
	  )
  );setq 





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;           hauptfunktion                           ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; parst ein file und schreibt den fast-parse-wert in eine aliste             ;;;
;;; die ausgabe ist die flache zwischen-darstellung                            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; eingabe : ein lisp pfadname oder ein string oder ein pfadnamentupel        ;;;
;;; ausgabe : die zwischendarstellung von dem file das im argument spezifiziert;;;
;;;           wurde                                                            ;;;
;;; globale variable : *schon-geparst*                                         ;;;
;;;                    *modified-prakt-grammar                                 ;;;
;;;                    *fehler*                                                ;;;
;;; funktionsaufrufe : iparse fast-parse                                       ;;;
;;; bemerkungen : die funktion arbeitet eigentlich nur 100%-ig wenn            ;;;
;;;               das argument ein pfadnamen-tupel ist                         ;;;
;;;               ist das argument ein string so wird nur dieser string        ;;;
;;;               geparst (ohne imports ,denn in  diesem Fall wird nur         ;;;
;;;               fastparse aufgerufen)                                        ;;;
;;;               ist das argument ein normaler pfad  ist es nicht moeglich    ;;;
;;;               in voller allgemeiheit die asf-files in dem Pfad zu finden   ;;;
;;;               die ihre information vollstaendig an das zu parsende file    ;;;
;;;               vererben                                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun parse (pfad)
  (setq alist nil)
  (setq *no-error* t)

  ;; Eschbach Reiffers Mon Aug  1 15:32:36 MET DST 1994
  (setq *wird-geerbt* nil)
  
  (setq *wird-importiert-flag* nil)
    (let (;(*package* (find-package 'compile-asf))
	out)
    ;(declare (special *package*))
    (setq out
	  (cond ((pathnamep pfad)
		 (setq pfad (list nil nil nil pfad) *schon-geparst* nil)
		 (prog1 (iparse pfad)
		   (setq alist nil)
		   )
		 )
		((stringp pfad) (setq *schon-geparst* nil)
		 (prog1 
		     (iparse (modid2specident pfad))
		   (setq alist nil)
		   )
		 )
		(t
		 (prog1 (iparse pfad)
		   (setq alist nil)
		   )
		 )
		)
	  )				;setq
    (and *no-error* (filter_spec out))
    )
  )



(defun oldparse (pfad)
  (setq old-package *package*)
  (in-package 'user)
  (setq alist nil)
  (cond ((pathnamep pfad) 
	 (setq pfad (list nil nil nil pfad) *schon-geparst* nil)
	 (prog1 (iparse pfad)
	        (setq alist nil)
		(setq *package* old-package)
		)
	  )
	((stringp pfad) (setq *schon-geparst* nil)
	                (prog1 
		        (iparse (modid2specident pfad)
			    )
			(setq *package* old-package)
			)
	 )
	(t
	 (prog1 (iparse pfad)
	        (setq alist nil)
		(setq *package* old-package)
		)
	 )
	)

  )

(defun miparse (pfad)
  ;(if (atom pfad) (setq pfad (list nil nil nil pfad)))
  ;(setq alist nil)
  (setq pfadname pfad *bool-flag* nil); 
  (or (cond ((and (not (mismatch "boolean" (car pfad) :test #'char-equal))
		  (null (2nd pfad))
		  (null (3rd pfad)))
	     (trace-output 2 "linking build-in booleans ~%")
	;     *build-in-booleans*
	     (setq *bool-flag* *build-in-booleans*)
	     nil
	     ))
;       (cdr (assoc (intern (namestring (4th pfad))) alist))
       (if (null *bool-flag*)
          (trace-output 2 "parsing ~s ~%" (concatenate 'string 
						 (pathname-name (4th pfad)) "." 
						 (pathname-type (4th pfad))))
	  );if
      (let* ((akt-file (fast-parse (4th pfad) :grammar *art-grammar))
	     (akt-file+bool nil)
	     (files (mmerge (abhaengig pfad)))
	     (complete (mmerge (6th akt-file)))
		              ;die files die auf dem pfad liegen muessen richtig
			      ;geparst werden sind also auch in der assoc vorhanden
	     ); 1st elem von let*
	    (setq akt-file+bool (construct *bool-flag* akt-file))
	    (ueberpruefe akt-file+bool complete files)
	    (setq alist (acons (intern (namestring (4th pfad))) akt-file alist))
	    (setq complete (construct1 complete akt-file));fuegt alle listen zusammen
	    (if (6th akt-file)
	 	(setf (nth 5 complete) (list (cons  pfad (nth 5 complete))))
		(setf (nth 5 complete) (list pfad))
		);if
	    complete
	    );let
      );or
  );defun


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;funktion fastparser
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;dient nur dazu einen parsefehler zu erkennen und ggfs
;die variable *no-error* auf nil zu setzen
;
;
; changed : 08.09.92 Eschbach
;   Es wird zusaetzlich fuer jedes Modul ein internes File angelegt, welches,
;   falls dieses File aktuell ist, geladen wird. Somit wird im guenstigen Fall
;   der Parser nicht aufgerufen. 
(defun fastparser (&rest arglist)
  (macrolet ((exist-file? 
	      (pathname)
	      `(probe-file (namestring ,pathname)))

	     (actual-intern-file?
	      (intern-pathname extern-pathname)
	      `(<= (file-write-date (namestring ,extern-pathname))
		   (file-write-date (namestring ,intern-pathname))))

	     (read-intern-file 
	      (intern-pathname extern-pathname)
	      `(let* ((stream (open ,intern-pathname :direction :input))
		      (out (read stream)))
		 (trace-output 2 "reading ~A~%" (concatenate 'string 
						 (pathname-name ,intern-pathname) "." 
						 (pathname-type ,intern-pathname)))
		 (close stream)
		 (setq alist (acons (intern (namestring ,extern-pathname )) out alist)) 
		 out))

	     (parse-extern-file
	      (intern-pathname extern-pathname)
	      `(let ((out (apply #'fast-parse (list ,extern-pathname)))
		     (stream (open ,intern-pathname :direction :output)))
		 (if (eq out 'parse-error)
		     (setq *no-error* nil)
		   (progn
		     (format t "writing ~A~%" (namestring ,intern-pathname))
		     (print out stream)
		     (close stream)
		     (setq alist (acons (intern (namestring ,extern-pathname )) out alist)) 
		     out))))
	     )
  (let* ((extern-pathname (first arglist))
	 (intern-pathname (concatenate 'string 
				       (subseq (namestring extern-pathname) 0 
					       (search "." (namestring extern-pathname) :from-end t)) ".intern")))
    (filter-theorems (or (cdr (assoc (intern (namestring extern-pathname)) alist))
			 (cond ((exist-file? intern-pathname)
				(cond ((actual-intern-file? intern-pathname extern-pathname)
				       (read-intern-file intern-pathname extern-pathname))
				      (t (parse-extern-file intern-pathname extern-pathname))))
			       (t (parse-extern-file intern-pathname extern-pathname))))))))

;;; nicht-importiert & nicht-vererbt ==> alle theoreme aufnehmen
;;; importiert & nicht-vererbt ==> nur "e"  theoreme aufnehmen
;;; nicht-importiert & vererbt ==> nur "o" "h" theoreme aufnehmen
;;; importiert & vererbt ==> nur "oe" "he" theoreme aufnehmen
;;; alle nicht "o" theoreme (d.h.: die noch nicht bewiesen sind) werden nach "unten" weitergeschoben
;;; alle noch nicht bewiesenen Thms befinden sich also auf der untersten stufe
;;;;darf nicht destruktiv sein !!!
(defun filter-theorems (modul)
  (let ((props (5th modul)))
    (list (1st modul)(2nd modul)(3rd  modul)(4th  modul)
	  (list (1st props)(2nd props)(3rd props)(4th props)
		(remove-if #'(lambda (x)
			       (let((flags (2nd (1st x))))
				 (cond ((and (not *wird-importiert-flag*) (not *wird-geerbt*))
					nil
					)
				       ((and *wird-importiert-flag* (not *wird-geerbt*))
					(if (member "e" flags :test #'string=) nil t)
					)
				       ((and (not *wird-importiert-flag*) *wird-geerbt*)
					(if (or (member "o" flags :test #'string=) (member "h" flags :test #'string=)) nil t)
					);;beweisaufgaben alle unten !!!
				       ((and *wird-importiert-flag* *wird-geerbt*)
					(if (and (or (member "o" flags :test #'string= ) (member "h" flags :test #'string= ))
						 (member "e" flags  :test #'string= )
						 )
					    nil
					  t
					  )
					)
				       (t (error "somthing strange happened (please contact robert or carlo)"))
				       ) ;cond
				 );;let
			       );;lambda
			   (5th props) 
			   );;delete
		)			;little list
	  (6th modul)
	  )				;big list
    );;let
  );;defun
			    
		

(defun fastparser-old (&rest arglist)
  (let ((out (apply #'fast-parse arglist))
	)
       (if (eq out 'parse-error)
	   (setq *no-error* nil )
	 out)
    )
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                           ;;;
;;; funktion :das im pfad-tupel angegebene asf-file wird geparst              ;;;
;;;           die zwischendarst von allen noetigen files wird in einer        ;;;
;;;           aliste abgelegt ; der wert ist die flache zwischen-darst        ;;;
;;; Eingabe : ein pfad-tupel                                                  ;;;
;;; wert    : flache zwischendarstellung                                      ;;;
;;; globale variable : *bool-flag*                                            ;;;       
;;;                    *build-in-booleans*                                    ;;;
;;;                    *schon-geparst*                                        ;;;
;;;                    alist                                                  ;;;
;;;                    pfadname                                               ;;;
;;; funktionsaufrufe : fast-parse                                             ;;;
;;;                    construct                                              ;;;
;;;                    construct1                                             ;;;
;;;                    mmerge                                                 ;;;
;;;                    ueberpruefe                                            ;;;
;;;                    abhaengig                                              ;;;
;;;                    2nd 3rd 4th                                            ;;;
;;;bemerkungen      :                                                         ;;;
;;;                                                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun iparse (pfad )
#|
  (format t "~&***************~% parse gerade ~a~% wird-importiert ~a~% wird-geerbt ~a~%**********~%"
	  (4th pfad) *wird-importiert-flag* *wird-geerbt*
	  )
|#
  (setq pfadname pfad *bool-flag* nil)	;(ein paar seiteneffekte :-) 
  (cond ((and (not (mismatch "boolean" (car pfad) :test #'char-equal))
	      (null (2nd pfad))
	      (null (3rd pfad)))
	 (trace-output 2 "linking build-in booleans ~%")
	 (setq *bool-flag* *build-in-booleans*)
	 ))
  (if (null *bool-flag*)
      (progn
	(if (cdr (assoc (intern (namestring (4th pfad))) alist))
	    (trace-output 2 "using ~a ~%" (concatenate 'string 
						       (pathname-name (4th pfad)) "." 
						       (pathname-type (4th pfad))))
	  (trace-output 2 "parsing ~a ~%" (concatenate 'string 
						       (pathname-name (4th pfad)) "." 
						       (pathname-type (4th pfad)))))
					;( );if

	(let* (*wird-geerbt-dummy*
	           ;;;;;;; hier noch mal filter theoreme aufrufen , Reiffers Eschbach 10 9 92
	       ;;(akt-file (or (cdr (assoc (intern (namestring (4th pfad))) alist)) (fastparser (4th pfad) :grammar *art-grammar)))
	       (akt-file  (fastparser (4th pfad) :grammar *art-grammar))  
	       (akt-file+bool nil)
	       (akt-file+alles nil)
	       (files  (prog2 (setq *wird-geerbt-dummy* *wird-geerbt* *wird-geerbt* t)
			   (mmerge (abhaengig pfad) nil)
			 (setq *wird-geerbt* *wird-geerbt-dummy* )
			 )
		       )
	       (complete (if *wird-importiert-flag*
			     (mmerge (6th akt-file) t)
			   (prog2 (setq *wird-importiert-flag* t)
			       (mmerge (6th akt-file) t)
			     (setq *wird-importiert-flag* nil))
			   )
			 )
	       )			; 1st elem von let*
	  (setq akt-file+bool (construct *bool-flag* akt-file))
	  (if *schon-geparst*
	      (setq akt-file+alles (construct *schon-geparst* complete))
	    (setq akt-file+alles complete)
	    )				;if
	  (ueberpruefe akt-file+bool akt-file+alles files)
	;;;optimierung einschalten --> naechste zeile hinzunehmen cr re 10 9 92
					;(if (null (cdr (assoc (intern (namestring (4th pfad))) alist))) (setq alist (acons (intern (namestring (4th pfad))) akt-file alist)))
	  (setq complete (construct complete files))
	  (setq complete (construct1 complete akt-file))
	  (if (or (6th akt-file) files)
	      (setf (nth 5 complete) (list (cons  pfad (nth 5 complete))))
	    (setf (nth 5 complete) (list pfad))
	    )				;if
					;	(setq *bool-flag* nil)
        ;;;(format t "in iparse ~A~%" (5th complete))
;;;;#####
	  complete
	  )				;let
	)				;progn
    (list  nil nil nil nil nil (list pfad)) ;elsefall von erstem if
    )					; erstes if
  )					;defun





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;      weitere funktionen                          ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                           ;;;
;;; funktion : parst eine liste von files mit allen inputs und liefert        ;;;
;;;            die zwischendarst als wert                                     ;;;
;;; Eingabe  : eine list mit pfad-tupeln und ein flag welches t oder nil ist  ;;;
;;; Wert     : die flache zwischendarst von allen files die in der            ;;;
;;;            eingabeliste angegeben sind                                    ;;;
;;; globale variable : *schon-geparst*                                        ;;;
;;;                    alist                                                  ;;;
;;; funktionsaufrufe : iparse                                                 ;;;
;;;                    construct                                              ;;;
;;;                    4th 6th                                                ;;;
;;; bemerkungen      : wenn das flag nil ist das file auf oberster ebene      ;;;
;;;                    dann wird *schon-geparst* nil gesetzt um den           ;;;
;;;                    naechsten teilbaum aufzunehmen                         ;;;
;;;                                                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mmerge (files flag)
  (do* (*wird-geerbt-dummy* ;;;;changed 26 5 1992
	(file-list files (cdr file-list))
	(out nil)
	(akt-file nil)
	(glist nil)
	(zwili nil nil)
	(old-boolflag *bool-flag* (or old-boolflag *bool-flag*))
	);1st elem do*
       ((null file-list) (setq *bool-flag*
			       (or old-boolflag *bool-flag*))
			  out)
       (if (not flag) (setq *schon-geparst* nil))
       (setq akt-file (car file-list))
       (setq *bool-flag* nil) ;;;;;;; neu
       (setq zwili (cdr (assoc (intern (namestring (4th akt-file))) alist)))
       (cond ( zwili 
	      (setq *schon-geparst* (filter-theorems (construct zwili *schon-geparst*)))
	      (setq zwili (list nil nil nil nil nil (cons akt-file (6th zwili))))
	      ))
       (if zwili (trace-output 2 "using ~a ~%" (concatenate 'string 
						 (pathname-name (4th akt-file)) "." 
						 (pathname-type (4th akt-file)))))
#|
       (setq glist (or  zwili
			;;;(prog2 (setq *wird-geerbt-dummy* *wird-geerbt* *wird-geerbt* nil)
			       (iparse  akt-file)
			    ;;;   (setq *wird-geerbt *wird-geerbt-dummy* );;;;changed 26 5 1992 
			     ;;;  )change changed 4 6 1992
			)
	     )|#
       ;(setq glist (iparse akt-file :already-parsed zwili))
       (setq glist (iparse akt-file))
       (setq out (construct out glist))
       );do*
  );defun


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; funktion: nimmt eine in der alist vorhandene zwischendarst und loest die
;;;           abhaengigkeiten (alle importierten files sind schon geparst worden!!)
;;;
;;;
;;;
;;;
;;;
;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun useparsed (zwili)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                           ;;;
;;; funktion : testet ob in den funktions-definitionen keine nicht            ;;;
;;;            vorhandene sorte gebraucht wurde                               ;;;
;;; eingabe : drei zwischen-darstellungen                                     ;;;
;;; Wert    : keinen                                                          ;;;
;;; globale variable : keine                                                  ;;;
;;; funktionsaufrufe : filter                                                 ;;;
;;;                    gueltig-fun                                            ;;;
;;;                    gueltig-var                                            ;;;
;;;                    1st 2nd 3rd                                            ;;;
;;; bemerkungen : in der ersten zwidarst werden die funktionen geprueft       ;;;
;;;               mit hinzunahme der sorten aus den argumenten 2,3            ;;;
;;;               wobei in arg3 die zwidarst ist aus denen man auch die       ;;;
;;;               "hidden" sorten sieht (ia die files auf dem pfad zu der     ;;;
;;;               zu testenden zwi-darst)                                     ;;;
;;;               in arg3 steht die zwi-darst von den files von denen man     ;;;
;;;               nur die "export"-sachen sieht (ia alle importierten files)  ;;;
;;;                                                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun ueberpruefe (file complete files)
  (let* ((pfad (3rd (1st (1st file))))
	 (sortlist (append (1st file)
			   (1st files)
			   (filter (1st complete)) ;liefert alles ohne hidden
			   );append
		   );sortlist
	 (funlist  (gueltig-fun (2nd file) sortlist)
		  );funlist
	 (varlist  (gueltig-var (3rd file) sortlist)
		   );varlist
	 );1st elem von let
	t); wenn kein error dann alles klar
  );defun

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                           ;;;
;;; funktion : entfernt alle "hidden"s aus einer liste (die wie sorten-liste  ;;;
;;;            aufgebaut ist) (sortlist funlist varlist)                      ;;;
;;; eingabe  : liste in form ((id herkunft "hidden"/"export" type)...)        ;;;
;;; ausgabe  : liste in der alle elemente die an dritter stelle  "hidden"     ;;;
;;;            haben entfernt (durch nil ersetzt)                             ;;;
;;;                                                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun filter (liste)
  (mapcar #'(lambda (elem)
		    (if (string= (3rd elem) "hidden")
			 nil
			 elem))
	  liste);mapcar
  );defun



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                           ;;;
;;; funktion : ueberprueft ob ein string als sorten-name vorkommt             ;;;
;;;                                                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun is_sort (token sortlist)
  (member token sortlist :test #'(lambda (x y)
				   (string= x (car y))))
  ); defun


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                           ;;;
;;; funktion : ueberprueft ob eine variable eine vorhandene sorte gebraucht   ;;;
;;; wert : keinen                                                             ;;;
;;; globale variable : *fehler*                                               ;;;
;;; funktionsaufrufe : is_sort 1st 2nd 3rd 4th                                ;;;
;;; bemerkung :schreibt nur eine fehlermeldung aus das praogramm laeuft       ;;;
;;;            weiter                                                         ;;;
;;;                                                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun gueltig-var (evarlist sortlist)
  (dolist (x evarlist)
	  (or (is_sort (car (3rd (car x))) sortlist)
	      (format t "ERROR in der Variablen-definition ~%im file ~s~%~
		      bei der variable ~s~%~
		      die Sorte ~s ist nicht vorhanden~%" (4th (2nd x)) (caar x)
		      (car (3rd (car x))))
	      );or
	  );dolist
  );defun


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                           ;;;
;;; funktion : ueberprueft ob eine funktion nur vorhandene sorte gebraucht    ;;;
;;; wert : keinen                                                             ;;;
;;; globale variable : *fehler*                                               ;;;
;;; funktionsaufrufe : is_sort 1st 2nd 3rd 4th                                ;;;
;;; bemerkung :schreibt nur eine fehlermeldung aus das praogramm laeuft       ;;;
;;;            weiter                                                         ;;;
;;;                                                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun gueltig-fun (efunlist sortlist)
  (dolist (fun efunlist)
	  (dolist (x (append (2nd (1st fun))
			     (3rd (1st fun))))
		  (or (is_sort x sortlist)
		      (format t "ERROR in der  Funktionendefiniton~%~
			      im file ~s ~% bei der funktion ~s~%~
			      die Sorte ~s ist nicht vorhanden ~%"
			      (4th (2nd fun))
			      (caaar fun)
			      x)
		      )			;or
		  )			;dolist
	  )				;dolist
  )					;defun



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                            ;;;
;;;funktion : zusammenfuegen von 2 zwischendarst                               ;;;
;;;eingabe  : 2 zwischendarst                                                  ;;;
;;;wert     : eine zwischendarst                                               ;;;
;;;funktionsaufrufe :1st 2nd 3rd 4th 5th 6th                                   ;;;
;;;bemerkung : construct und construct1 unterscheiden sich nur dadurch dass    ;;;
;;;            bei construct das 6-te elem der beiden zwischdarst zusammen     ;;;
;;;            appendet werden (die abhaengigkeitsbaeume) dadurch werden im    ;;;
;;;            prinzip mehrere imports verknuepft                              ;;;
;;;            construct1 wird allerdings nur aufgerufen wenn der baum ansich  ;;;
;;;            schon komplett ist und nur noch die Wurzel fehlt                ;;;
;;;                                                                            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun construct (complete akt-file )
  ;(format t "construct : ~A ~% ~A ~%" (5th complete) (5th akt-file))
  (list (append (1st complete) (1st akt-file))
	(append (2nd complete) (2nd akt-file))
	(append (3rd complete) (3rd akt-file))
	(append (4th complete) (4th akt-file))
	(if (null (5th complete))
	    (5th akt-file)
            (if (null (5th akt-file))
		(5th complete)
;** haenge einzelne properties aneinander !
		(mapcar #'append (5th complete) (5th akt-file)))

	    );if
	(append (6th complete) (6th akt-file))
;	(or (6th complete) (6th akt-file) )
;	(6th complete)
	);list
  );defun

(defun construct1 (complete akt-file )
  (list (append (1st complete) (1st akt-file))
	(append (2nd complete) (2nd akt-file))
	(append (3rd complete) (3rd akt-file))
	(append (4th complete) (4th akt-file))
	(if (null (5th complete))
	    (5th akt-file)
            (mapcar 'append (5th complete) (5th akt-file))
	    );if
;	(append (6th complete) (6th akt-file))
;	(or (6th complete) (6th akt-file) )
	(6th complete)
	);list
  );defun

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                            ;;;
;;; funktion : berechnet eine liste mit allen pfad-tupeln die diejenigen       ;;;
;;;            files spezifizieren welche auf dem pfad zu dem angegebenen      ;;;
;;;            file liegen                                                     ;;;
;;; eingabe : pfad-tupel                                                       ;;;
;;; wert : liste mit abhaengigen pfad-tupeln (nicht das file selber)           ;;;
;;; bemerkung :funktionniert nur bei files in dem default-baum ansonsten       ;;;
;;;            wird nil zurueckgegeben                                         ;;;
;;;                                                                            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun abhaengig (pfad)
  (let ((rdir (reverse (pathname-directory (4th pfad))))
	(filename (pathname-name (4th pfad)))
	)
       (cond ((null (1st pfad)) nil)
	     ((and (null (2nd pfad)) (null (3rd pfad))) nil)
	     ((null (3rd pfad))
	      (list (list (1st pfad)
			  ()
			  nil
			  (make-pathname :directory (reverse (cdr rdir))
					 :name (concatenate 'string
							    (cadr rdir)
							    ".asf")
					 )
			  );inneres list
		    );big list
	      );null ..
	     (t (do* ((x  (1- (3rd pfad))
			 (1- x)
			 );x
		      (irdir (cdr rdir) (cdr irdir))
		      (out (list (list
				  (1st pfad)
				  (2nd pfad)
				  (1- (3rd pfad))
				  (make-pathname :directory (reverse irdir)
						 :name (concatenate 
							'string
							(car irdir)
							".asf"))
				  );inneres list
				 );dickes list

			   (cons (list
				  (1st pfad)
				  (2nd pfad)
				  x
				  (make-pathname :directory (reverse irdir)
						 :name (concatenate
							'string
							(car irdir)
							".asf"))
				  );inneres list
				 out);cons
			   );out
		      );erstes elem von do
		     ((= x 0) (if (2nd pfad)
				  (cons
				   (list (1st pfad)
					 nil
					  nil
					  (make-pathname :directory (reverse (cdr irdir)
									     )
							 :name (concatenate 'string
									    (cadr irdir)
									    ".asf")
							 );make-pathname
					 );list
				   (cons (list (1st pfad)
					       (2nd pfad)
					       nil
					       (make-pathname :directory (reverse 
									   irdir)
							      :name (concatenate 
								     'string
								     (car irdir)
										 ".asf")
							      );make-pathname
					       );inneres list
					 (cdr out)
					 );cons
				   );cons
				  (cons 
				   (list (1st pfad)
					 nil
					 nil
					 (make-pathname :directory (reverse irdir
									    )
							:name (concatenate 'string
									   (car irdir)
									   ".asf")
							);make-pathname
					 );list
				   (cdr out)
				   );cons
				  );if
		      );abbruch von do
		     ( ));do
		);cond t-fall
	     );cond
       );let
  );defun


	     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;jetzt ein paar editierhilfen

(defun edi (pfad editor hintergrund welches)
  (let* ((pfadi (cond ((pathnamep pfad) (namestring pfad))
		      ((stringp pfad)
		       (namestring
			(4th (modid2specident pfad))))
		      (t
		       (namestring (4th pfad)))
		      )
		)
	 (pfado (if welches (concatenate 
			     'string
			     (subseq pfadi
				     0
				     (search ".asf"
					     pfadi
					     :from-end T))
			     "."
			     welches
			     )
		  pfadi
		  )
		)

	 (command (concatenate 'string editor pfado  hintergrund))
	 )
    ;; Eschbach Thu Jan 16 11:42:24 MET 1997
    #+:lucid (lucid::shell command)
    #+:cmu
    (progn
      (format t "Eschbach Sun Feb  2 18:59:07 MET 1997~%")
      (format t "use the following pathname, e.g., auto <pathname> in RRL~%")
      (format t "pathname : ~a~%" pfado))
    )
  )
			
(defun vi (pfad &optional (welches nil))
  (edi pfad "vi\ " "" welches))

(defun sunedit (pfad &optional (welches nil))
  (edi pfad "textedit\ " "&" welches))

(defun xedit (pfad &optional (welches nil))
  (edi pfad "xedit\ " "&" welches))

(defun xvi (pfad &optional (welches nil))
  (edi pfad "xterm  -g 100x60+20+30  -n \"art     vi\" -e vi\ " "&" welches))

(defun emacs (path &optional (suffix nil))
  (edi path "emacs\ " "&" suffix))

(defun sunvi (pfad &optional (welches nil))
  (edi pfad "cmdtool vi\ " "&" welches)
  )

(defun ue (pfad &optional (welches nil))
  (edi pfad "ue\ " "" welches))

(defun xue (pfad &optional (welches nil))
  (edi pfad "xterm -g 100x60+25+35 -e ue\ " "&" welches)
  )

(defun sunue (pfad &optional (welches nil))
  (edi pfad "cmdtool ue\ " "&" welches))

(defun rrl (pfad &optional (welches "rrlkb"))
  (edi pfad "~art/source/compile-asf/lrrl\ " "" welches))

;; Eschbach Wed Jan 29 18:22:26 MET 1997
;; Eschbach, Thu Jan  7 11:08:28 MET 1999
;; path 
(defun xrrl (path &optional (kind "rrlmr"))
  (format t "using /home/systeme/art/rrl/rrl~%")
  (edi path "xterm -sb -g 100x60+30+40 -n \"art rrl\" -e /usr/progress/art/source/compile-asf/lrrl\ " "&"  kind)
  #+:cmu (run-program "xterm"
		      '("-sb" "-g" "100x60+30+40" "-n" "art-rrl" "-e"
			"/home/systeme/art/rrl/rrl")
		      :wait nil))

