(in-package "COMPILE-ASF")

;*******************************************************************************
;** function name : create-rrl-files                                          **
;** arguments     :                                                           **
;**   spec -- Zwischendarstellung (ohne Umbenenungsliste)                     **
;**   filename -- filename ohne Suffix (etwa .rrlkb, ...)                     **
;** effect        : erstellt zwei Kommandofiles fuer das RRL                  **
;** return value  : NIL                                                       **
;** edited        : 22.07.91                                                  **
;** changed       : 02.09.92 Eschbach                                         **
;**   Der Aufbau vom mr-file hat sich geaendert :                             **
;**     Definitionen				                              **
;**     Konstruktoren, AC-Operatoren, ...				      **
;**     makerule					                      **
;**     suffice                                                               **
;**     Beweismethode					                      **
;**     cover (die cover-sets werden ermittelt)				      **
;**     Eigenschaften					                      **
;**     makerule					                      **
;**     Beweisaufgaben                                                        **
;**   Fuer die Abstraktions-Methode ist es erforderlich, dass die cover-sets  **
;**   vor den Eigenschaften bereits ermittelt worden sind, ansonsten werden   **
;**   keine Gleichungen in die RRL-Variable $build-rules eingetragen.         **
;**   Desweiteren muss die Beweismethode vor den Eigenschaften auf cover-set  **
;**   gesetzt werden, dies ist wegen der RRL-Variablen $induc erforderlich.   **
;**   Desweitern wurde in beiden Files wegen Speicherplatzproblemen der       **
;**   undo-Modus zurueckgesetzt.                                              **
;*******************************************************************************
(defun create-rrl-files (speclist filename)
  (macrolet ((write-no-history
	      (stream)
	      `(format ,stream "~%option~%history~%no-history~%~%"))
	     (write-unlog
	      (stream)
	      `(format ,stream "~%unlog~%"))
	     )
  (labels ((write-art-mode 
	    (stream mode)
	    (format stream "~%option~%art~%~A~%" mode))
 
	   (create-kb-file 
	    (filename)
	    (trace-output 2 "writing ~A~%" (concatenate 'string filename ".rrlkb"))
	    (let ((stream (open (concatenate 'string filename ".rrlkb") :direction :output)))
	      (write-art-mode stream "on")	      
	      (erstelleinit filename stream)
	      (write-no-history stream)
	      (verarbeite_fkt (fkts speclist) stream)
	      (verarbeite_gl (gl speclist) (string " == ") stream)
	      (verarbeite_props (props speclist) stream (string " == ") speclist)
	      (erstelleproove (string " == ") stream)
	      (verarbeite1_th (th speclist) stream)
	      (erstellewrite filename stream)
	      (write-unlog stream)
	      (write-art-mode stream "off")
	      (close stream)))

	   (create-mr-file 
	    (filename)
	    (trace-output 2 "writing ~A~%" (concatenate 'string filename ".rrlmr"))
	    (macrolet ((write-cover 
			(stream)
			`(format ,stream "cover~%~%"))

		       (write-makerule
			(stream)
			`(format ,stream "makerule~%~%"))
	   
		       (write-properties
			(properties stream)
			`(progn (format ,stream "add~%")
			        (verarbeite2_th ,properties ,stream)
			        (format ,stream "]~%~%")))

		       (write-suffice 
			(stream)
			`(format ,stream "suffice~%~%"))
		       )
		  
	    (labels ((write-definitions 
		      (definitions stream)
		      (macrolet ((write-definition
				  (definition stream)
				  `(verforme (inh ,definition) " := " ,stream))
				 )
				(cond ((null definitions) (format stream "]~%~%"))
				      (t (write-definition (first definitions) stream)
					 (write-definitions (rest definitions) stream)))))

		     (write-prove-method
		      (method stream)
		      (cond ((equal method 'cover-set)
			     (format stream "option~%prove~%e~%~%"))
			    ((equal method 'inductionless-using-test-sets)
			     (format stream "option~%prove~%s~%~%"))
			    (t (error "unknown prove-method ~A ~%" method))))
	   
		     )
		     (let* ((stream (open (concatenate 'string filename ".rrlmr") :direction :output)))
		       (write-art-mode stream "on")
		       (erstelleinit filename stream)
		       (write-no-history stream)
		       (verarbeite_fkt (fkts speclist) stream)
		       (write-definitions (gl speclist) stream) ; alle Gleichungen sind Definitionen !
		       (verarbeite_props (props speclist) stream (string " == ") speclist)
		       (write-makerule stream)
		       (write-suffice stream)
		       (write-prove-method 'cover-set stream)
		       (write-cover stream)
		       (write-properties (th speclist) stream)
		       (write-makerule stream)
		       (verarbeite1_th (th speclist) stream)
		       (erstellewrite filename stream)
		       (write-unlog stream)
		       (write-art-mode stream "off")
		       (close stream))))) 
	   
	   )
	   (create-kb-file filename)
	   (create-mr-file filename))))


;*******************************************************************************
;** function name : verarbeite-props                                          **
;** arguments     : Propertieliste, Ausgabestrom, String, Zwischendarst.      **
;** effect        : uebertraegt die Properties in das File                    **
;** return value  :                                                           **
;** edited        : 22.07.91                                                  **
;*******************************************************************************
(defun verarbeite_props (propsliste stream symbol speclist)
   (terpri stream)
   (verarbeite_constr (constr propsliste) stream speclist)
   (verarbeite_ac (acs propsliste) stream)
   (verarbeite_com (coms propsliste) stream)
   (verarbeite_order (order propsliste) stream)
   (verarbeite_prec (precs propsliste) stream)
   (verarbeite_stat (stat propsliste) stream)
   (terpri stream)
   (terpri stream)
   (terpri stream))

(defun verarbeite_constr (constrliste stream speclist)
   (if (notempty constrliste)
       (schreibeconstr constrliste stream speclist)))

(defun schreibeconstr (constrliste stream speclist)
   (if (notempty constrliste)
       (progn (terpri stream)
	      (princ "operator" stream)
	      (terpri stream)
	      (princ "constructor" stream)
	      (terpri stream)
	      (princ (car (vorne constrliste)) stream)
	      (terpri stream)
	      (cond((0func? (vorne constrliste) speclist)    (princ " " stream))
                   ((equal (car (cdr (vorne constrliste))) (string "frei"))
			      		          (princ (string "yes") stream))
		   (t                             (princ (string "no") stream)))
	      (terpri stream)
	      (schreibeconstr (hinten constrliste) stream speclist))))

(defun 0func? (paar specliste)
   (if (equal (searchp (fkts specliste) paar) NIL)
       t
       nil))

(defun searchp (fktliste paar)
   (cond ((empty fktliste)                                                'Pech)
	 ((string= (car paar)(caaar (vorne fktliste))) (cadar (vorne fktliste)))
	 (t                                  (searchp (hinten fktliste) paar))))

(defun verarbeite_ac (acliste stream)
   (if (notempty acliste)
       (progn (terpri stream)
	      (princ "operator" stream)
	      (terpri stream)
	      (princ "acoperator" stream)
	      (terpri stream)
	      (schreibe acliste stream)
	      (terpri stream))))
		 
(defun verarbeite_com (comliste stream)
   (if (notempty comliste)
       (progn (terpri stream)
	      (princ "operator" stream)
	      (terpri stream)
	      (princ "commutativ" stream)
	      (terpri stream)
	      (schreibe comliste stream)
	      (terpri stream))))

(defun verarbeite_order (ordliste stream)
   (if (not (equal ordliste '(NIL))) 
       (progn (terpri stream)
	      (princ "option" stream)
	      (terpri stream)
	      (princ "order" stream)
	      (terpri stream)
              (if (string= (car ordliste) (string "lrpo"))
		  (princ "l" stream)
		  (princ "m" stream))
	      (terpri stream))))

(defun verarbeite_prec (precliste stream)
   (if (notempty precliste)
       (schreibeprec precliste stream)))

(defun schreibeprec (pliste stream)
   (if (notempty pliste)
       (progn (terpri stream)
	      (princ "operator" stream)
	      (terpri stream)
	      (princ "precedence" stream)
	      (terpri stream)
	      (schreibe (vorne pliste) stream)
	      (terpri stream)
	      (schreibeprec (hinten pliste) stream))))

(defun verarbeite_stat (statliste stream)
   (defun hilfstat (teilstatliste)
      (let ((sym (cond((string= (vorne(hinten teilstatliste))(string "l")) "lr")
		      ((string= (vorne(hinten teilstatliste))(string "r")) "rl")
		       (t                                                "m"))))
         (if (not (string= sym (string "m")))
	     (schreibestat (vorne teilstatliste) sym))))
   (defun schreibestat (opliste stat)
      (if (notempty opliste)
	  (progn (terpri stream)
		 (princ "operator" stream)
		 (terpri stream)
	         (princ "status" stream)
		 (terpri stream)
	         (princ (vorne opliste) stream)
		 (terpri stream)
	         (princ stat stream)
		 (terpri stream)
	         (schreibestat (hinten opliste) stat))))
   (if (notempty statliste)
       (progn (hilfstat (vorne statliste))
	      (verarbeite_stat (hinten statliste) stream))))

(defun schreibe (liste stream)
   (if (notempty liste)
       (progn (princ (vorne liste) stream)
	      (princ " " stream)
	      (schreibe (hinten liste) stream))))

;*******************************************************************************
;** function name : verarbeite-fkt                                            **
;** arguments     : Funktionenliste, Ausgabestrom                             **
;** effect        : schreibt die Funktionsdeklarationen in das File           **
;** return value  :                                                           **
;** edited        : 22.07.91                                                  **
;*******************************************************************************
(defun verarbeite_fkt (fktliste stream)
   (terpri stream)
   (terpri stream)
   (princ "ADD" stream)
   (terpri stream)
   (verarbeitehilffkt fktliste stream))

(defun verarbeitehilffkt (fktliste stream)
   (if (notempty fktliste)
       (progn (machedekl (vorne fktliste) stream)
	      (verarbeitehilffkt (hinten fktliste) stream))))

(defun machedekl (funkt stream)
   (if (eq (defb funkt) nil)
       (mache0fkt funkt stream)
       (machefkt funkt stream)))

(defun mache0fkt (funkt stream)
   (princ "[" stream)
   (princ (opfkt funkt) stream)
   (princ " : " stream)
   (princ (bildb funkt) stream)
   (princ "]" stream)
   (terpri stream))

(defun machefkt (funkt stream)
   (princ "[" stream)
   (princ (opfkt funkt) stream)
   (princ " : " stream)
   (uebertrage (defb funkt) stream)
   (princ " -> " stream)
   (princ (bildb funkt) stream)
   (princ "]" stream)
   (terpri stream))

(defun uebertrage (defb stream)
   (if (empty (rest defb))
       (princ (vorne defb) stream)
       (progn (princ (vorne defb) stream)
	      (princ ", " stream)
	      (uebertrage (hinten defb) stream))))

;*******************************************************************************
;** function name : verarbeite-gl                                             **
;** arguments     : Gleichungsliste, Zwischendarst., String, Ausgabestrom     **
;** effect        : uebertraegt Gleichungen (und Theoreme) in das File        **
;** return value  :                                                           **
;** edited        : 22.07.91                                                  **
;*******************************************************************************
(defun verarbeite_gl (glliste symbol stream)
   (machegl glliste symbol stream)
   (if (string= symbol (string " == "))
       (progn (princ "]" stream)
	      (terpri stream)
	      (terpri stream)
	      (terpri stream))
       (progn (verarbeite2_th (th speclist) stream)
	      (princ "]" stream)
	      (terpri stream)
              (terpri stream)
	      (terpri stream))))  
		 
(defun machegl (glliste symbol stream)
   (if (notempty glliste)
       (progn (verforme (inh (vorne glliste)) symbol stream)
	      (machegl (hinten glliste) symbol stream))))

(defun verforme (glinh symbol stream)
   (verforme1 (links glinh) (rechts glinh) symbol stream)
   (if (notempty (wenn glinh))
       (progn (princ " if " stream)
	      (verformewhengl (wenn glinh) stream)))
   (terpri stream))		 
		 
(defun verformewhengl (glinh stream)
   (if (empty (hinten (hinten glinh)))
       (verforme2 (links glinh) (rechts glinh) stream)
       (progn (verforme2 (links glinh) (rechts glinh) stream)
	      (princ " & " stream)
	      (verformewhengl (hinten (hinten glinh)) stream))))

(defun verforme1 (links rechts symbol stream)
   (verarbeiteterm links stream)
   (princ symbol stream)
   (verarbeiteterm rechts stream))
   
(defun verforme2 (links rechts stream)
   (cond ((stringeq links (string "true"))  (verarbeiteterm rechts stream))
	 ((stringeq rechts (string "true")) (verarbeiteterm links stream))
         ((stringeq links (string "false"))
		(progn (princ "not (" stream)
                       (verarbeiteterm rechts stream)
		       (princ ")" stream)))
	 ((stringeq rechts (string "false"))
		(progn (princ "not (" stream)
                       (verarbeiteterm links stream)
		       (princ ")" stream)))
	 (t     (progn (verarbeiteterm links stream)
		       (princ " = " stream)
		       (verarbeiteterm rechts stream)))))

(defun stringeq (obj1 obj2)
   (and (stringp obj1)
	(stringp obj2)
	(string= obj1 obj2)))

(defun verarbeiteterm (term stream)
   (cond ((atom term)              (princ term stream))
	 ((member (car (op term)) '("and" "or" "xor" "->" "equ") :test #'string=)
	  (progn (princ "(" stream)
		 (verarbeiteterm (arg1 term) stream)
		 (princ " " stream)
		 (princ (car (op term)) stream)
		 (princ " " stream)
		 (verarbeiteterm (arg2 term) stream)
		 (princ ")" stream)))
	 ((tuple? term)            (progn (princ "(" stream)
				          (verarbeitearg (arg term) stream)
					  (princ ")" stream)))
	 ((praefunktor? term)      (progn (princ (car (op term)) stream)
				          (princ "(" stream)
					  (verarbeitearg (arg term) stream)
				          (princ")" stream)))
         ((infunktor? term)        (progn (princ "(" stream)
				          (verarbeiteterm (arg1 term) stream)
					  (princ " " stream)
				          (princ (car (op term)) stream)
					  (princ " " stream)
					  (verarbeiteterm (arg2 term) stream)
					  (princ ")" stream)))))
					
(defun verarbeitearg (argsliste stream)
   (if (empty (hinten argsliste))
       (verarbeiteterm (vorne argsliste) stream)
       (progn (verarbeiteterm (vorne argsliste) stream)
	      (princ ", " stream)
	      (verarbeitearg (hinten argsliste) stream))))

(defun tuple? (term)
   (if (atom (op term))
       (eq (op term) '#\<)
       nil))

(defun infunktor? (term)
   (string= (cdr (car term)) (string "infix")))

(defun praefunktor? (term)
   (not (infunktor? term)))

;*******************************************************************************
;** function name : verarbeite1-th                                            **
;** arguments     : Theoremliste, Zwischendarst., Ausgabestrom                **
;** effect        : uebertraegt noch nicht bewiesene Theoreme in das File     **
;** return value  :                                                           **
;** edited        : 23.07.91                                                  **
;*******************************************************************************
(defun verarbeite1_th (thlist stream)
   (if (notempty thlist)
       (progn (bearbeite1 (vorne thlist) stream)
	      (verarbeite1_th (hinten thlist) stream))))

(defun oldbearbeite1 (theorem stream)
   (if (not (member (string "o") (ind theorem) :test #'string=))
       (progn (princ "prove" stream)
	      (terpri stream)
	      (verforme (glth theorem) (string " == ") stream)
	      (terpri stream))))

(defun bearbeite1 (theorem stream)
;** Eschbach
;** 18.05.92
   (if (and (not (member (string "o") (ind theorem) :test #'string=))
	    (not (member (string "h") (ind theorem) :test #'string=)))
       (progn (princ "prove" stream)
	      (terpri stream)
	      (verforme (glth theorem) (eqn-typ theorem) stream)
	      (terpri stream))))

(defun eqn-typ (theorem)
  (let ((type (caddr (caar theorem)))
       )
       (cond ((string= type "gl-gl")
              " == ")
             ((string= type "rgl")
              " --> ")
             (t " := ")
       ) ;** cond **
  ) ;** let **
)

;*******************************************************************************
;** function name : verarbeite2-th                                            **
;** arguments     : Theoremliste, Zwischendarst., Ausgabestrom                **
;** effect        : uebertraegt nicht mehr zu beweisende Theoreme in das File **
;** return value  :                                                           **
;** edited        : 23.07.91                                                  **
;*******************************************************************************
(defun verarbeite2_th (thlist stream)
   (if (notempty thlist)
       (progn (bearbeite2 (first thlist) stream)
	      (verarbeite2_th (rest thlist) stream))))

(defun bearbeite2 (theorem stream)
;** Eschbach
;** 18.05.92
  (if (or (member (string "o") (ind theorem) :test #'string=)
	  (member (string "h") (ind theorem) :test #'string=))
      (verforme (glth theorem) (eqn-typ theorem) stream)))

;*******************************************************************************
;** function name : erstelleinit                                              **
;** arguments     : Ausgabestrom                                              **
;** effect        : erzeugt Initialisierungsteil im File                      **
;** return value  :                                                           **
;** edited        : 23.07.91                                                  **
;*******************************************************************************
(defun erstelleinit (filename stream)
   (terpri stream)
   (princ "init" stream)
   (terpri stream)
   (terpri stream)
   (princ "log" stream)
   (terpri stream)
   (princ filename stream)
   (terpri stream))

;*******************************************************************************
;** function name : erstelleprove                                             **
;** arguments     : Ausgabestrom, String                                      **
;** effect        : erzeugt (in Abhaengigkeit vom String) Beweisteil im File  **
;** return value  :                                                           **
;** edited        : 23.07.91                                                  **
;*******************************************************************************
(defun erstelleproove (symbol stream)
   (if (string= symbol (string " == "))
       (progn (princ "kb" stream)
	      (terpri stream)
	      (terpri stream)
	      (princ "suff" stream)
	      (terpri stream)
	      (princ "option" stream)
	      (terpri stream)
	      (princ "prove" stream)
	      (terpri stream)
	      (princ "s" stream)
	      (terpri stream)
	      (terpri stream)
	      (terpri stream))
       (progn (princ "mr" stream)
	      (terpri stream)
	      (terpri stream)
	      (princ "option" stream)
	      (terpri stream)
	      (princ "prove" stream)
	      (terpri stream)
	      (princ "e" stream)
	      (terpri stream)
	      (terpri stream)
	      (terpri stream))))

;*******************************************************************************
;** function name : erstellewrite                                             **
;** arguments     : Ausgabestrom                                              **
;** effect        : erzeugt "write"-Befehl im File                            **
;** return value  :                                                           **
;** edited        : 23.07.91                                                  **
;*******************************************************************************
(defun erstellewrite (filename stream)
   (terpri stream)
   (terpri stream)
   (princ "write" stream)
   (terpri stream)
   (princ "spec-write" stream)
   (terpri stream)
   (princ filename  stream)
   (format stream "~%"))
 
;*******************************************************************************;*******************************************************************************  
(defun props (speclist)
   (car (cdr (cdr (cdr (cdr speclist))))))

(defun gl (speclist)
   (car (cdr (cdr (cdr speclist))))) 

(defun th (speclist)
   (car (cdr (cdr (cdr (cdr (props speclist)))))))

(defun fkts (speclist)
   (car (cdr speclist)))

(defun var (speclist)
   (car (cdr (cdr speclist))))

(defun empty (liste)
   (eq liste nil))

(defun notempty (liste)
   (not (empty liste)))

(defun vorne (liste)
   (car liste))

(defun hinten (liste)
   (cdr liste))

(defun opfkt (funkt)
   (car (car (car funkt))))

(defun defb (funkt)
   (car (cdr (car funkt))))

(defun bildb (funkt)
   (car (car (cdr (cdr (car funkt))))))

(defun type (funkt)
   (cdr (car (car funkt))))
   
(defun op (term)
   (car term))

(defun arg (term)
   (cdr term))

(defun arg1 (term)
   (car (arg term)))

(defun arg2 (term)
   (car (cdr (arg term))))

(defun ind (theorem)
   (car (cdr (car theorem))))

(defun glth (theorem)
   (car (cdr (car (car theorem)))))

(defun inh (gleichung)
   (car (cdr (car gleichung))))

(defun links (gleichung)
   (car gleichung))

(defun rechts (gleichung)
   (car (cdr gleichung)))

(defun wenn (gleichung)
   (cdr (cdr gleichung)))

(defun constr (propliste)
   (macheopliste (car propliste)))

(defun acs (propliste)
   (macheopliste (car (cdr propliste))))

(defun coms (propliste)
   (macheopliste (car (cdr (cdr propliste)))))

(defun macheopliste (obj)
   (if (empty obj)  
       nil
       (concatenate 'list (sucheop (car (car obj)))
		          (macheopliste (hinten obj)))))

(defun sucheop (bliste)
   (if (empty bliste)
       nil
       (cons (car bliste)
	     (sucheop (hinten bliste)))))

(defun order (propliste)
   (list (car (car (car (car (cdr (cdr (cdr propliste)))))))))

(defun precs (propsliste)
   (defun prechilf (liste)
      (if (empty liste)
	  nil
	  (concatenate 'list (car (cdr (car (car liste))))
		             (prechilf (cdr liste)))))
   (prechilf (car (cdr (cdr (cdr propsliste))))))

(defun stat (propsliste)
   (defun stathilf (liste)
      (if (empty liste)
	  nil
          (concatenate 'list (car (cdr (cdr (car (car liste)))))
		             (stathilf (cdr liste)))))
   (stathilf (car (cdr (cdr (cdr propsliste))))))


