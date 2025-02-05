(in-package "COMPILE-ASF")

(setq *semantic-actions*


`(
					; fuege alle listen zusammen und fuege gegebenenfalls den pfadnamen hinzu
  (64 . ,#'(lambda (token-st)
	     (let* (
		    (exp-glist (token-val (8th token-st)))
		    (exp-sortlist (1st exp-glist))
		    (exp-funlist (2nd exp-glist))
		    (hid-sortlist (token-val (6th token-st)))
		    (hid-funlist (token-val (5th token-st)))
		    (hid-varlist (token-val (4th token-st)))
		    (hid-eqnlist (token-val (3rd token-st)))
		    (hid-proplist (token-val (2nd token-st)))
		    )
	       (setq idlist nil)
	       (list (append (erweitere exp-sortlist (list pfadname
							   "export"
							   "sort"))
			     (erweitere hid-sortlist (list pfadname
							   "hidden"
							   "sort")))
		     (append (erweitere exp-funlist (list pfadname
							  "export"
							  "function"))
			     (erweitere hid-funlist (list pfadname
							  "hidden"
							  "function")))
		     (erweitere hid-varlist (list pfadname
						  "hidden"
						  "variable"))
		     (erweitere hid-eqnlist (list pfadname))
		     (list (erweitere (1st hid-proplist) (list pfadname))
			   (erweitere (2nd hid-proplist) (list pfadname))
			   (erweitere (3rd hid-proplist) (list pfadname))
			   (erweitere (4th hid-proplist) (list pfadname))
			   (erweitere (5th hid-proplist) (list pfadname))
			   )		;list
		     (token-val (7th token-st))
		     )			;list
	       )			;let*

	     ))
					;1 ein ident ist erkannt als wert kriegt er seinen string
  (1 . ,#'(lambda (token-st)
	    (token-string (1st token-st))
	    ))
					;2 zusammen fuegen von den export-listen
  (2 . ,#'(lambda (token-st)
	    (list (token-val (3rd token-st))
		  (token-val (2nd token-st)))
	    ))
					;3 importliste ist erkannt
  (3 . ,#'(lambda (token-st)
	    (token-val (1st token-st))
	    ))
					;4 eine spezifikations-beschreibung ist erkannt
  (4 . ,#'(lambda (token-st)
	    (token-val (1st token-st))
	    ))
					;5 sortenliste weiterreichen
  (5 . ,#'(lambda (token-st)
	    (token-val (1st token-st))
	    ))
					;6 sortenliste weiterreichen
  (6 . ,#'(lambda (token-st)
	    (token-val (1st token-st))
	    ))
					;7 sorten name weiterreichen
  (7 . ,#'(lambda (token-st)
	    (token-string (1st token-st))
	    ))
					;8 funktions-liste weiterreichen (und ein bischen platt machen
  (8 . ,#'(lambda (token-st)
	    (apply 'append
		   (token-val (1st token-st))
		   )			;apply
	    ))
					;9 eine funktions definition bearbeiten
  (9 . ,#'(lambda (token-st)
	    (do* ((list (token-val (5th token-st)) (cdr list))
		  (out (list(list (cons (car list)
					"functor")
				  (token-val (3rd token-st))
				  (token-val (1st token-st))))
		       (cons (list (cons (car list)
					 "functor")
				   (token-val (3rd token-st))
				   (token-val (1st token-st)))
			     out))
		  )
		 ((null (cdr list)) (reverse out))
		 ()
		 )
	    ))
					;10 einen prefix operator bearbeiten
  (10 . ,#'(lambda (token-st)
	     (list 
	      (list (cons (token-string (5th token-st))
			  "prefix")
		    (list (token-val (3rd token-st)))
		    (token-val (1st token-st))
		    )			;list
	      )				;erstes list
	     ))
					;11 einen infix operator bearbeiten
  (11 . ,#'(lambda (token-st)
	     (list
	      (list (cons (token-string (8th token-st))
			  "infix")
		    (list (token-val (5th token-st))
			  (token-val (3rd token-st)))
		    (token-val (1st token-st))
		    )
	      )				;erstes list

	     ))
					;12 funktorenliste weiterreichen
  (12 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;13 funktorname weiterreichen
  (13 . ,#'(lambda (token-st)
	     (token-string (1st token-st))
	     ))
					;14 funktoren -operatoren liste aufbauen (funktor hinzufuegen)
  (14 . ,#'(lambda (token-st)
	     (cons (token-val (2nd token-st))
		   (token-val (1st token-st)))
	     ))
					;15 funktoren -operatoren liste aufbauen (operator hinzufuegen)
  (15 . ,#'(lambda (token-st)
	     (cons (token-string (2nd token-st))
		   (token-val (1st token-st)))
	     ))
					;16 input-typen weiterreichen
  (16 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;17 output-typen weiterreichen
  (17 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;18 liste von sorten namen erkannt
  (18 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;19 variablen liste weiterreichen
  (19 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;20 variablen liste weiterreichen (und platt machen)
  (20 . ,#'(lambda (token-st)
	     (do* ((list (token-val (1st token-st)) (cdr list))
		   (out (car list) (append out (car list)))
		   )
		  ((null (cdr list)) out)
		  ()
		  )
	     ))
					;21 variablen definition erkannt
  (21 . ,#'(lambda (token-st)
	     (let ((sort (token-val (1st token-st))))
	       (mapcar #'(lambda (elem)
			   (list (list elem)  nil (list sort)))
		       (token-val (4th token-st))
		       ))
	     ))
					;22 variablen-namen-liste weiterreichen
  (22 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;23 variablen-namen weiterreichen
  (23 . ,#'(lambda (token-st)
	     (token-string (1st token-st))
	     ))
					;24 gleichungsliste weiterreichen
  (24 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;25 gleichung (typ1) aufbauen
  (25 . ,#'(lambda (token-st)
	     (let ((head (token-val (3rd token-st))))
	       (list (token-val (4th token-st))
		     (cons (1st head)
			   (cons (2nd head)
				 (token-val (2nd token-st))
				 ))
		     (3rd head)
		     )			;list
	       )			;let
	     ))
					;26 gleichung (typ2) aufbauen
  (26 . ,#'(lambda (token-st)
	     (let ((head (token-val (2nd token-st))))
	       (list (token-val (3rd token-st))
		     (cons (1st head)
			   (cons (2nd head)
				 (token-val (1st token-st))
				 ))
		     (3rd head)
		     )			;list
	       )			;let
	     ))
					;27 bedingung erkannt
  (27 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;28 def-gl erkannt
  (28 . ,#'(lambda (token-st)
	     (list (token-val (3rd token-st))
		   (token-val (1st token-st))
		   "def-gl")
	     ))
					;29 gl-gl erkannt
  (29 . ,#'(lambda (token-st)
	     (list (token-val (3rd token-st))
		   (token-val (1st token-st))
		   "gl-gl")
	     ))
					;30 r-gl erkannt
  (30 . ,#'(lambda (token-st)
	     (list (token-val (3rd token-st))
		   (token-val (1st token-st))
		   "r-gl")
	     ))
					;31 gl-gl erkannt
  (31 . ,#'(lambda (token-st)
	     (list (token-val (3rd token-st))
		   (token-val (1st token-st))
		   "gl-gl")
	     ))
					;32 r-gl erkannt
  (32 . ,#'(lambda (token-st)
	     (list (token-val (3rd token-st))
		   (token-val (1st token-st))
		   "r-gl")
	     ))
					;33 bedingungen erkannt
  (33 . ,#'(lambda (token-st)
	     (do  ((list (token-val (1st token-st)) (cdr list))
		   (out nil (cons (caar list)
				  (cons (cadar list)
					out)))
		   )
		  ((null list) (reverse out))
		  ()
		  )
	     ))
					;34 bedingungsgleichung erkannt
  (34 . ,#'(lambda (token-st)
	     (list (token-val (1st token-st))
		   (token-val (3rd token-st))
		   )			;list
	     ))
					;35 term erkannt
  (35 . ,#'(lambda (token-st)
	     (let ((term-a-op (token-val (2nd token-st)))
		   )
	       (cond ((null term-a-op)
		      (token-val (1st token-st)))
		     (t (list (2nd term-a-op)
			      (1st term-a-op)
			      (token-val (1st token-st)))
			)
		     )			;cond
	       )			;let

	     ))
					;36 halber term erkannt		 
  (36 . ,#'(lambda (token-st)
	     (list (token-val (2nd token-st))
		   (cons (token-string (1st token-st))
			 "infix")
		   )			;list
	     ))
					;37 funktor und arglist erkannt
  (37 . ,#'(lambda (token-st)
	     (cons (cons (token-string (4th token-st))
			 "functor")
		   (token-val (2nd token-st)))
	     ))
					;38 tupel erkannt
  (38 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;39 term in klammern erkannt
  (39 . ,#'(lambda (token-st)
	     (token-val (2nd token-st))
	     ))
					;operator mit term erkannt
  (40 . ,#'(lambda (token-st)
	     (list (cons (token-string (2nd token-st))
			 "prefix")
		   (token-val (1st token-st)))
	     ))
					;41 variable oder nullstellige funktion erkannt
  (41 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;42 liste von termen erkannt
  (42 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;43 uups kommt nicht vor
  (43 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;44 tupel erkannt und weitergereicht
  (44 . ,#'(lambda (token-st)
	     (cons #\< (cons
			(token-val (4th token-st))
			(token-val (2nd token-st))
			))
	     ))
					;45 property liste zusammenfuegen
  (45 . ,#'(lambda (token-st)
	     (list (token-val (6th token-st))
		   (token-val (5th token-st))
		   (token-val (4th token-st))
		   (token-val (3rd token-st))
		   (token-val (2nd token-st)))

	     ))
					;46 konstruktorenliste weiterrreichen
  (46 . ,#'(lambda (token-st)
	     (list ;;;;neu
	      (token-val (1st token-st))
	      )				;list
	     ))
					;47 konstruktorenliste erkannt
  (47 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;48 konstruktor erkannt (funktor)
  (48 . ,#'(lambda (token-st)
	     (list (token-val (2nd token-st))
		   (cond ((null (token-val (1st token-st)))
			  nil)
			 (t "frei"))
		   )			;list
	     ))
					;49 konstruktor erkannt (operator)
  (49 . ,#'(lambda (token-st)
	     (list (token-string (2nd token-st))
		   (cond ((null (token-val (1st token-st)))
			  nil)
			 (t "frei"))
		   )			;list
	     ))
					;50 c-operatorenliste weiterreichen
  (50 . ,#'(lambda (token-st) 
	     (list;;neu
	      (token-val (1st token-st))
	      )				;list
	     ))
					;51 ordnungs-definition erkannt
  (51 . ,#'(lambda (token-st)
	     (list;;neu
	      (list (token-val (3rd token-st))
		    (token-val (2nd token-st))
		    (token-val (1st token-st)))
	      )				;erstes list

	     ))
					;52 "lrpo"erkannt
  (52 . ,#'(lambda (token-st)
	     "lrpo"
	     ))
					;53 precedece-definition erkannt
  (53 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;54 kommt nicht vor
  (54 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;55 gesamt status-def erkannt
  (55 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;56 eine status-def erkannt
  (56 . ,#'(lambda (token-st)
	     (list (token-val (3rd token-st))
		   (token-val (1st token-st)))
	     ))
					;57 status-ident1 erkannt
  (57 . ,#'(lambda (token-st)
	     (token-string (1st token-st))
	     ))
					;58 theorem definition erkannt
  (58 . ,#'(lambda (token-st)
					;(format t "gelesene theoreme vor remove : ~a ~%********~%"  (token-val (1st token-st)))
	     (remove nil (token-val (1st token-st)))
	     ))

(59 . ,#'(lambda (token-st)
	   (list (token-val (3rd token-st))
		 (token-val (2nd token-st)))))

		   					;59 ein theorem erkannt
;;; nicht-importiert & nicht-vererbt ==> alle theoreme aufnehmen
;;; importiert & nicht-vererbt ==> nur "e"  theoreme aufnehmen
;;; nicht-importiert & vererbt ==> nur "o" "h" theoreme aufnehmen
;;; importiert & vererbt ==> nur "oe" "he" theoreme aufnehmen
;;; alle nicht "o" theoreme (d.h.: die noch nicht bewiesen sind) werden nach "unten" weitergeschoben
;;; alle noch nicht bewiesenen Thms befinden sich also auf der untersten stufe
 #| (59 . ,#'(lambda (token-st)
	     (cond ((and (not *wird-importiert-flag*) (not *wird-geerbt*))
		    (list (token-val (3rd token-st))
			  (token-val (2nd token-st))
			  )
		    )
		   ((and *wird-importiert-flag* (not *wird-geerbt*)) 
		    (if (member "e" (token-val (2nd token-st)) :test #'string= )
			(list (token-val (3rd token-st))
			      (token-val (2nd token-st))
			      )
		      nil		;else-fall
		      )
		    );;or 2te bedingung
		   ((and (not *wird-importiert-flag*) *wird-geerbt*)
		    (if (or (member "h" (token-val (2nd token-st)) :test #'string= )
			    (member "o" (token-val (2nd token-st)) :test #'string= )
			    )
			(list (token-val (3rd token-st))
			      (token-val (2nd token-st))
			      )
		      nil;;else-fall
		      )
		    );;3te bedingung
		   ((and *wird-importiert-flag* *wird-geerbt*)
		    (if (and (or (member "o" (token-val (2nd token-st)) :test #'string= )
				 (member "h" (token-val (2nd token-st)) :test #'string= )
				 )
			     (member "e" (token-val (2nd token-st)) :test #'string= )
			     )
			(list (token-val (3rd token-st))
			      (token-val (2nd token-st))
			      )
		      nil ;;;else-fall
		      )
		    ) ;;; and 4te cond bedingung
		   (t nil)
		   );; cond
	     );;lambda
	);;59 |#

					;60 eine flagliste weitergericht
  (60 . ,#'(lambda (token-st)
	     (token-val (2nd token-st))
	     ))
					;61 eine flagliste erkannt
  (61 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))
					;62 ein flag erkannt
  (62 . ,#'(lambda (token-st)
	     (token-string (1st token-st))
	     ))
					;63 ac-operatorliste erkannt
  (63 . ,#'(lambda (token-st)
	     (list ;;;; neu
	      (token-val (1st token-st))
	      )				;list
	     ))
					;66 ein tagg erkannt
  (66 . ,#'(lambda (token-st)
	     (token-string (2nd token-st))
	     ))
  (67 . ,#'(lambda (token-st)
	     (token-val (1st token-st))
	     ))


  )					;gaaaaaaanz oben

);erstes setq


      
