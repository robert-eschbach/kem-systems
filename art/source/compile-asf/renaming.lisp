(in-package "COMPILE-ASF")

(defmacro name (x)
  `(caaar ,x))

(defmacro insort (x)
  `(cadar ,x))

(defmacro name*car (x)
  `(caaaar ,x))

(defmacro outsort (x)
  `(caddar ,x))

(defmacro name*cdr (x)
  `(caaadr ,x))

(defmacro pfad (x)
  `(fourth ,x))
	   
(defmacro vorname (x)
  `(caar ,x))
    
(defmacro fun_var (x)
  `(cadddr ,x))

           
(defmacro terme (x)    
  `(cadar ,x))
      
(defmacro export* (x)
  `(caddr ,x))

(defmacro terme*car (x)
  `(cadaar ,x))     

(defmacro export*car (x)
  `(caddar ,x))

(defvar *builtinexport*)
(defvar *builtinhidden*)
(defvar *fehler-output*)
(defvar *fehler-flag*)

(setq *builtinexport*
	'( ((("and"."infix") (" bool" "bool") ("bool")) ("boolean" nil nil nil)
		      "export" "function")
           ((("or"."infix") (" bool" "bool") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("xor"."infix") (" bool" "bool") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("equ"."infix") (" bool" "bool") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("not"."functor") (" bool") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("false"."functor") (" nil") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("true"."functor") (" nil") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("nil"."functor") (" nil") ("bool")) ("boolean" nil nil nil)
	               "export" "function")
	   ((("all"."functor") (" nil") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("exist"."functor") (" nil") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("eq"."functor") (" nil") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("="."infix") (" nil") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("cond"."functor") (" nil") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("if"."functor") (" nil") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
)        )

(setq *builtinhidden*
	'( ((("and"."infix") ("bool" "bool") ("bool")) ("boolean" nil nil nil)
		      "hidden" "function")
	   ((("or"."infix") ("bool" "bool") ("bool")) ("boolean" nil nil nil)
		      "hidden" "function")
	   ((("xor"."infix") ("bool" "bool") ("bool")) ("boolean" nil nil nil)
		       "hidden" "function")
	   ((("equ"."infix") ("bool" "bool") ("bool")) ("boolean" nil nil nil)
		       "hidden" "function")
	   ((("not"."functor") ("bool") ("bool")) ("boolean" nil nil nil)
		       "hidden" "function")
	   ((("false"."functor") nil ("bool")) ("boolean" nil nil nil)
		       "hidden" "function")
	   ((("true"."functor") nil ("bool")) ("boolean" nil nil nil)
		       "hidden" "function")
	   ;; Eschbach Thu Aug  4 17:14:11 MET DST 1994
	   ((("cond"."infix") ("univ" "univ" "univ") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	   ((("="."infix") ("univ" "univ") ("bool")) ("boolean" nil nil nil)
		       "export" "function")
	))


(setq *fehler-output* t)

(defun specpfad (tupel)
   (cond ((null (car tupel)) tupel)
	 ((and (null (second tupel)) (null (third tupel))) tupel)
	 (t (let ( (pfadl (if (null (third tupel))
			      (anfang (pathname-directory (fourth tupel)) 0)
			      (anfang (pathname-directory (fourth tupel)) (third tupel))
                 ) )      )
	         (list (car tupel) nil nil
	               (make-pathname :directory (cdr pfadl)
	                              :name (strcat (car pfadl) ".asf")
)  )     )  )    )     )

(defun anfang (l n)
   (cond  ((null l) (1+ n))
	  (t (let ( (x (anfang (cdr l) n)) )
	          (cond ((null x) 0)
	                ((listP x) (cons (car x) (rplaca x (car l))))
		        ((= x 0) (list (car l) (car l)))
		        (t (1- x))
)  )      )  )    )

(defun argsorten (sortenl)
   (let ( (sorten (apply #' append sortenl)) )
	(if (= (length sortenl) (length sorten)) sorten nil)
)  )

(defun originB (l)
   (namestring (fourth (specpfad l))
)  )

(defun origin (l)
  (if (null l) ""
    (namestring (fourth (specpfad (cadr l))))))

(defun originkp (l)
   (pathname-name (fourth (specpfad (cadr l)
)  )              )       )

(defun abbruch (module steuerstring &optional x y)
   (format *fehler-output* "FEHLER in Spezifikation: ~A~%" module)
   (format *fehler-output* steuerstring x y)
   (setq *fehler-flag* t)
)

(defun member2 (string zugriff liste &key (test #' string=))
   (remove string liste :test-not test :key zugriff)
)

(defun member3 (string liste subl)
  (let ((elemente (cons (car (member string liste :test #'string= :key #'(lambda(x) (name x))))
			(mapcar #' cdr (member2 string #' car subl)))))
	(if (or (car elemente) (cdr elemente)) elemente)))

(defun member4 (nomen module l subl pra)
   (let ( ( konflikt (member3 nomen l subl)))
	(if konflikt
	    (cons (car konflikt) (member2 module #' id konflikt :test pra
)  )    )   )                    )

(defun member4b (nomen module l subl pra)
   (cond ((member4 nomen module l subl pra))
	 (t (member4 nomen module *builtinhidden* nil #'(lambda (x y) t))
)  )     )


(defun member5 (nomen sorten module weiter l subl baum)
   (let ( (konflikt (member4 nomen module l subl #'
			     (lambda (x y) (cond ((string= x (origin y)))
						 ((string= "export" weiter)
	           			          (if (string= "hidden" (export* y))
						      (ueber (origin y) x baum) t   )  )
						 (t (if (string= "export" (export* y))
							(ueber x (origin y) baum) nil )
        ) )         )        )             )     )
	(cond ((null (cdr konflikt))  konflikt)
	      (t (cons (car konflikt)
		       (member2 sorten #'(lambda(x) (insort x)) (cdr konflikt) :test #'sortenvergleich)
)  )    )     )  )


(defun member5b (nomen sorten module l subl baum)
   (let ( (elem1 (member5 nomen sorten module "hidden" l subl baum))
	  (e2 nil                                                  ) )
	(cond ((cdr elem1) elem1)
	      ((setq e2 (car (member nomen *builtinhidden* :test #'string= :key #'(lambda(x) (name x)))))
	       (if (sortenvergleich sorten (insort e2)) (list e2 e2) elem1) )
	      (t elem1)
)  )    )

(defun id (x) x)

(defun sortenvergleich (l1 l2)
   (eval (list* 'and (= (length l1) (length l2)) (mapcar #'string= l1 l2)
)  )     )

(defun ueber (mod1 mod2 baum)
   (cond ((null baum) nil)
	 (( pathnameP (pfad (car baum))) (ueber mod1 mod2 (cdr baum)))
	 ((> 2 (length (car baum))) (ueber mod1 mod2 (cdr baum)))
	 ((string= mod1 (originB (caar baum))) (or (suche mod2 (cdar baum))
				                   (ueber mod1 mod2 (cdr baum
         )                                     )   )                )
	 ((string= mod2 (originB (caar baum))) (ueber mod1 mod2 (cdr baum)))
	 (t (or (ueber mod1 mod2 (cdr baum)) (ueber mod1 mod2 (cdar baum
)  )     )  )                                )                )

(defun suche (string baum)
   (cond ((null baum) nil)
	 ((pathnameP (pfad baum)) (string= string (originB baum)))
	 (t (or (suche string (car baum)) (suche string (cdr baum))
)  )     )  )

(defun neualt (subl)
   (remove-if #'(lambda (x) (eq (car x) (cdr x)))
	      (pairlis (mapcar #'(lambda(x) (name*cdr x)) subl) (mapcar #' car subl)
)  )          )

(defun rename (element l subl)
   (prog1 (cons (cons (name element) element) subl)
          (rplaca (vorname element) (verlaengere (name element) (originkp element) l)
)  )      )

(defun renamevar (element l subl)
   (cond ((member (subseq (name element) 0 1) '("u" "v" "w" "x" "y" "z") :test #'string=)
	  (cons (cons (name element) element) subl) )
	 ((member (strcat "x" (name element)) l :test #'string= :key #'(lambda(x) (name x)))
	  (prog1 (cons (cons (name element) element) subl)
		 (rplaca (vorname element) (verlaengereHvar (name element) l 1)) ) )
	 (t (prog1 (cons (cons (name element) element) subl)
		   (rplaca (vorname element) (strcat "x" (name element))
)  )     )  )      )

(defun strcat (x y)
   (concatenate 'string x y))

(defun verlaengere (nomen module l)
   (verlaengereH (strcat nomen (strcat "." (subseq module 0 1)))
		 (strcat (subseq module 1) (subseq module 0 1))
		 l
)  )

(defun verlaengereH (nomen module l)
   (if (member nomen l :test #' string= :key #'(lambda(x) (name x)))
       ( verlaengereH (strcat nomen (subseq module 0 1))
		      (strcat (subseq module 1) (subseq module 0 1))
		      l )
       nomen
)  )

(defun verlaengereHvar (nomen l n)
   (if (member (format nil "x~s~a" n nomen) l :test #' string= :key #'(lambda(x) (name x)))
       (verlaengereHvar nomen l (1+ n))
       (format nil "x~s~a" n nomen)
)  )

(defun range (term module lneu subl baum &key (inside t))
   (let ( (prename  (if (stringP (car term)) term (caar term))      )
	  (argliste (if (stringP (car term)) nil  (cdar term))      )
	  (fun      #' (lambda (x) (range x module lneu subl baum)) ) )
	(cond ((null argliste) (substitutvar prename module lneu subl baum :inside nil))
	      ((equal prename #\<) (if inside (abbruch module
					               "Tupel als Argumente verboten~%")
				              (apply #' append (maplist fun argliste
              )                    )          )                )
	      (t (substitut prename (argsorten (maplist fun argliste))
			    module lneu subl baum :inside nil
)  )    )     )  )

(defun substitut (prename sorten module l subl baum &key (inside t))
   (let ( (elemente (member5b (car prename) sorten module l subl baum)) )
	(cond ((null sorten) (outsort (car elemente)))
	      ;; Eschbach 
	      ;; 08.05.92
	      ;; Thu Aug  4 17:14:11 MET DST 1994     
	      ((null elemente)
	       (if  (and (not (equal "=" (car prename)))
			 (not (equal "cond" (car prename))))
	       (abbruch module "die Funktion/Variable ~A ist nicht deklariert~%"
			(car prename) )))
	      ((null (cdr elemente))
               (if (not (equal "=" (car prename)))
                   (progn 
	             (abbruch module "die Funktion/Variable ~A wird falsch angewendet~%"
			  (car prename))
	             (outsort (car elemente))
                   )))
	      ((and inside (< 1 (length (outsort (cadr elemente)))))
	       (abbruch module
		        "die Funktion ~A darf nicht in Argumentposition benutzt werden~%"
	                (car prename) ) )
	      (t (rplaca prename (name (cadr elemente))) (outsort (cadr elemente))
)  )    )     )

(defun substitutvar (prename module l subl baum &key (inside t))
   (let ( (elemente (member5b (car prename) nil module l subl baum)) )
	(cond ((null elemente) 
	       (if (not (equal "=" (car prename)))
;** Eschbach
;** 08.05.92
	       (abbruch module "die Funktion/Variable ~A ist nicht deklariert~%"
			(car prename) )))
	      ((null (setq elemente (cadr elemente)))
               (if (not (equal "=" (car prename)))
	       (abbruch module "die Funktion/Variable ~A wird falsch angewendet~%"
			(car prename))))
	      ((and inside (< 1 (length (outsort elemente))))
	       (abbruch module
		        "die Funktion ~A darf nicht in Argumentposition benutzt werden~%"
	                (car prename) ) )
	      (t (rplaca prename (name elemente)) (outsort elemente)
)  )    )     )

(defun equtest (termlist module l subl baum)
   (if termlist
       (let ( (r1 (range      termlist  module l subl baum :inside nil) )
              (r2 (range (cdr termlist) module l subl baum :inside nil) )  )
            (if (or (null r1) (null r2) (sortenvergleich r1 r2))
                nil
                (abbruch module "Typkonflikt zwischen ~S und ~S~%"
		         (car termlist) (cadr termlist) )  )
	    (equtest (cddr termlist) module l subl baum)
)  )   )

(defun veraendere (l baum)
   (do* ( (lalt     l                              (cdr lalt)           )
	  (lneu     *builtinexport*                (cons element lneu ) )
	  (subl                                                         )
	  (element  (car l)                        (car lalt)           )
	  (nomen    (name element)                 (name element)       )
	  (module   (origin element)               (origin element)     )
	  (sorten   (insort element)               (insort element)     )
	  (weiter   (export* element)               (export* element)     )
	  (overload (member5 nomen sorten module weiter lneu subl baum)
		    (member5 nomen sorten module weiter lneu subl baum) ) )
	( (null lalt) subl)
	(cond ((null overload) (if (string= "variable" (fun_var element))
				   (setq subl (renamevar element l subl)) ) )
	      ((cdr overload)
	       (abbruch module "~A wurde schon in Spezifikation \"~A\" deklariert~%"
		       nomen (origin (cadr overload)) ) )
	      ((and (string= "hidden" (export*car overload))
		    (string= "function" (fun_var element)))
	       (setq subl (rename (car overload) l subl)) )
	      ((string= "function" (fun_var element)) (setq subl (rename element l subl)))
	      (t (setq subl (renamevar element l subl)
)  )    )     )  )

(defun equcheck (eqn glist subl baum)
   (cond ((null eqn))
	 (t (equtest (terme*car eqn) (origin (car eqn)) glist subl baum)
	    (equcheck (cdr eqn) glist subl baum)
)  )    )

(defun renaming (l)
   (let ( (baum    (sixth l)              )
	  (funvar (append (second l) (third l)) )
	  (subl2  nil                           )
	  (subl   nil                           ) )
        (trace-output 2 "renaming ~%")
	
	;; Eschbach Tue Aug  2 22:01:23 MET DST 1994
	(trace-output 2 "checking sorts ~%")
	(setq *test* l)
	(check-sorts l)
	
	(trace-output 2 "checking functions ~%")
	(setq *fehler-flag*   nil
	      subl   (veraendere funvar baum)
	      subl2  (member2 "function" #' (lambda (x) (fun_var (cdr x))) subl) )
	(trace-output 2 "checking equations ~%")
	(equcheck  (fourth l) funvar subl baum)
	(trace-output 2 "checking properties~%")
	(propcheck (fifth   l) funvar (second l) subl subl2 baum)
; 	(format *fehler-output* "end~%")
	(if *fehler-flag* (error "korrigiere Fehler !") 
	  ;; Eschbach Tue Aug 24 11:47:25 MET DST 1993
	  ;; Ausgabe der Umbenennung
	  (progn
	    (dolist (new-old (neualt subl))
		    (format *output-stream* "rename function ~a to ~a~%" (cdr new-old) (car new-old)))
	    (cons l (neualt subl))
	    )
)  )    )

(defun check-sorts (spec)
  "check wether sort-names contains only uppercase letters
Eschbach Tue Aug  2 22:16:45 MET DST 1994"
  (declare (type list spec))
  (dolist (sort (first spec))
	  (unless (string= (car sort) (string-upcase (car sort)))
		  (error "only uppercase letters allowed : ~A ~%" (car sort)))))
	
  

(defun propcheck (propl funvar func subl1 subl2 baum)
   (do ( (props (cdr propl)                           (cdr props)  )
	 (prop  (car propl)                           (car props)  )
	 (funl  (list #'acc #'acc #'pred #'theo #'id) (cdr funl)   )
	 (f     #' constru                            (car funl)   ) )
       ((null funl)       )
       (dolist (funmod prop)
	       (let ( (module (origin funmod) )
		      (funop    (car  funmod) ) )
		    (if (eq #' theo f) (funcall f funop module funvar subl1 baum)
				       (funcall f funop module func   subl2 baum)
)  )   )       )    )

(defun acc (funop module glist subl baum)
   (cond (funop (subprop      funop  module glist subl baum)
		(acc     (cdr funop) module glist subl baum)
)  )     )

(defun constru (funop module glist subl baum)
   (cond (funop (subprop (car funop) module glist subl baum)
		(constru (cdr funop) module glist subl baum)
)  )     )

(defun pred (funop module glist subl baum)
   (let ( (funop1 (cadr  funop))
	  (funop2 (caddr funop)) )
	(dolist (x funop1)
		(acc x module glist subl baum) )
	(dolist (x funop2)
		(acc (car x) module glist subl baum) )
)  )

(defun theo (funop module glist subl baum)
   (equtest (terme funop) module glist subl baum) )

(defun subprop (prename module glist subl baum)
   (let ( (elemente (cdr (member4b (car prename) module glist subl
				   #' (lambda (x y) (if (string= x (origin y))
				                        t
						        (ueber   x (origin y) baum)
        ) )         )    )           )             )
	(cond ((null elemente) (abbruch module 
	                                "~A wurde nicht deklariert~%" (car prename)) )
	      ((= 1 (length elemente)) (rplaca prename (name*car elemente)))
	      ((setq elemente (member2 module #' origin elemente))
	       (if (= 1 (length elemente))
		   (rplaca prename (name*car elemente))
	           (abbruch module 
		            "~A kann nicht eindeutig identifiziert werden~%" (car prename)
              ))   )
	      (t (abbruch module 
		          "~A kann nicht eindeutig identifiziert werden~%" (car prename)
)  )    )     )  )

