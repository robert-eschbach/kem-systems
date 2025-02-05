(in-package "COMPILE-ASF")   


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;                                                          ;;;;;;;;;;
;;;;;;;;;;                   allerlei Hilfsfunktionen               ;;;;;;;;;;
;;;;;;;;;;                                                          ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;; erst mal eine definition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;in lisp2 dann muss das directory etwas anders aussehen als in lisp3
; *default-baum-dir* gibt das directory an wo der spezifikatonsbaum steht

(setq vers (LISP-IMPLEMENTATION-VERSION))
;(setq *default-baum-dir* 
;     (if (search "3.0" vers) '(:ROOT "hilbert" "usr" "users" "madprak2" "tester")
;	 '("hilbert" "usr" "users" "madprak2" "tester")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun 1st (x)
  (car x)
  )
(defun 2nd (x)
  (cadr x)
  )
(defun 3rd (x)
  (caddr x)
  )
(defun 4th (x)
  (cadddr x)
  )
(defun 5th (x)
  (cadddr (cdr x))
  )
(defun 6th (x)
  (cadddr (cddr x))
  )
(defun 7th (x)
  (cadddr (cdddr x))
  )
(defun 8th (x)
  (cadddr (cddddr x))
  )
(defun 9th (x)
  (cadddr (cddddr (cdr x)))
  )
(defun 10th (x)
  (cadddr (cddddr (cddr x)))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;diese funktion wird verwendet um hinter jedem element den pfadnamen 
;einzufuegen 
;siehe auch datei funtab
;
(defun erweitere (elist tail)
  (mapcar #'(lambda (elem)
	      (cons elem tail))
	  elist)
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;diese funktion sollte noch mal ueberholt werden
;spalte-aufrufe eliminieren!!!
;der eingabeparameter ist ein string der den pfadnamen enthaelt
;

(defun pathname2specident (ipathname)
  (let* ((pathname (complete (mapcar #'(lambda(x)
					 (coerce x 'string))
				     (spalte (coerce ipathname 'list)
					     #\/))));;;pathname-directory pathname-name...
	 (laenge (length pathname))
	 (rpath (reverse pathname))
	 (prop (if (search ".prop" (car rpath))
		       (subseq (car rpath) 
		               (+ 6 (search ".prop_" (car rpath) :from-end t))
		               (search ".asf" (car rpath) :from-end t)
			       )
		   nil))
	 (impl (if (search ".impl_" (car rpath))
		   (subseq (car rpath)
			   (+ 6 (search ".impl_" (car rpath)))
			   (or (search ".prop_" (car rpath) :from-end t)
			       (search ".asf" (car rpath) :from-end t))
			   )
		   ))

	 (specname (subseq (car rpath)
			   0
			   (or (search ".impl_"  (car rpath) :from-end t)
			       (search ".prop_" (car rpath) :from-end t)
			       (search ".asf" (car rpath) :from-end t))
			   )
		   )

	 ) ; erstes arg von let*
	(list specname (atoi impl) (atoi prop) 
	      ;; Eschbach Thu Jan 16 12:48:10 MET 1997
	      (make-pathname :directory
			     (cons :absolute (cdr (reverse (cdr rpath))))
			     ;;(if (search "2.1.1" (LISP-IMPLEMENTATION-VERSION))
			     ;;		   (reverse (cdr rpath))
			     ;;		 (cdr (reverse (cdr rpath))))

	       :name (car rpath))
	      ); list
	);let
  );defun


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;die funktion probiert anhand eines relativen pfadnamens den absoluten 
;pfad zu generieren
;relative pfadnamen werden immer relativ zum *default-baum-dir* angegeben
;der eingabeparameter ist eine liste der directories auf dem pfad
;das letzte element der liste ist der datei-name oder nil
;bei nil wird an das letzte directory ".asf" angehaengt um den
;pfadnamen zu erhalten
;der wert der funktion haengt von der lisp version ab
;im allgemeinen ist es eine liste der directories auf dem pfad
;wobei letzte element der liste der dateiname ist
;bei lisp3 wird am anfang noch :ROOT  eigefuegt um anzugeben dass es sich
;um einen absoluten pfad handelt
;bei lisp2 entfaellt dies
;
(defun complete (ipath)
       (if (< 0 (length (car ipath)))
	   ;kein absoluter pfad
	   (setq ipath (append *default-baum-dir* ipath))
	   (if (search "3.0.4" vers) 
	       (setq ipath (cons ':ROOT (cdr ipath)))
	       (if (search "2.1.1" vers)
		   (setq ipath (cdr ipath))
		   );mini-if
	       ;else-fall ist neu 14 11 1991 fehler beim absoluten pfad
	       ) ;else
	   );if
       (let ((rpath (reverse ipath))
	     )
       (if (= 0 (length (car rpath)))
	   ;kein file angegeben
	   (setq ipath (reverse (cons (concatenate 'string (2nd rpath) ".asf")
			              (cdr rpath))))
	   );if
       );let
  ipath

  );defun


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;die funktion macht aus einem modid ein vollstaendiges pfadtupel 
;eine modid ist ein string und kann  wie folgt beschrieben werden
;name[^[X][^[Y]]]
;Wobei X die Nummer der Implementierung ist
;Wobei Y die Stufe der Property ist
;zB:
;"bool" steht fuer default-baum-dir/bool/bool.asf
;"bool^^2" steht fuer default-baum-dir/bool/bool.prop1/bool/prop2/bool.prop2.asf
;"bool^2^1"
;steht fuer default-baum-dir/bool/bool.impl1/bool.impl1.prop1/bool.impl1.prop1.asf
;
(defun modid2specident (imodid)
  (let* ((modid (mapcar #'(lambda (x)
				  (coerce x 'string)
				  )
			(spalte (coerce imodid 'list) #\^)
			)
		)
	 (specname (1st modid))
	 (impl (if (and (2nd modid) (not (string= (2nd modid) "")))
		   (concatenate 'string 
			        ".impl_"
			        (2nd modid))
		   nil ;;;else
		   );if
	       );impl
	 (prop (if (and (3rd modid) (not (string= (3rd modid) "")))
		   (concatenate 'string
			        ".prop_"
			        (3rd modid))
		   nil ;else
		   );if
	       );prop
	 (filename (concatenate 'string specname impl prop ".asf"))
	 (tiefe (atoi (3rd modid)))

	 (directory 
		  (and prop
		    (do* ((ai  tiefe (1- ai))
			  (dir (list (concatenate 
				      'string
				      specname
				      impl
				      (subseq prop 0 (1+ (search "_" prop 
								 :from-end t)))
				      (itoa ai)))
			       (cons (concatenate
				      'string
				      specname
				      impl
				      (subseq prop 0 (1+ (search "_" prop 
								 :from-end t)))
				      (itoa ai))
				     dir)
			       )
			  )
			 ((>= 1 ai) dir)
			 );do*
		    );and
	  );directory
	 );erstes elem von let*
	(list specname 
	      (and impl (atoi (2nd modid)))
	      (and prop (atoi (3rd modid)))
	      (make-pathname  :directory (append *default-baum-dir*
					         (list specname)
					         (and impl (list 
							    (concatenate 
							     'string
							     specname
							     impl)))
					         (and prop directory)
					    )
			 :name (concatenate 'string 
					    specname
					    impl
					    prop
					    ".asf"))
	      );list
	);let*
  );defun

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;die funktion wird gebraucht  um eine liste an allen 
;vorkommen von elem aufzuteilen in
;eine liste von kleineren listen
;
(defun spalte (eliste elem)
  (do ((liste eliste (cdr liste))
       (out nil)
       (tout nil)
       );erstes arg von do
      ((null  liste) (append out (list (reverse tout))))
      (cond ((eq (car liste) elem)
	     (setq out (append out (list  (reverse tout))))
	     (setq tout nil)
	     );erstes arg von cond
	    (t (setq tout (cons (car liste) tout)))
	    );cond
      );do
  );defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; diese funktion hat als eingabe einen string und liefert als wert
; den dazugehoerigen integer (ASCII-to-integer)
;
(defun atoi (x)
  (and  (stringp x)
       (do ((nullc (char-code #\0))
	    (max (length x))
	    (pos 0 (1+ pos))
	    (val 0 (+ (* 10  val)
		      (- (char-code (char x pos)) nullc)
		      )
		 );val
	    )
	   ((>= pos max) val)
	   );do
       );and
  );defun


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;die funktion erwartet als eingabe einen integerwert und liefrt als
;wert den entsprechenden ASCII string (integer-to-ASCII)
;
(defun itoa (x)
  (and  (numberp x)
	(do* ((nullc (char-code #\0))
	      (pos 1 (* 10  pos))
	      (val (list (code-char
			  (+ nullc (mod x 10))
			  ))
		   (cons (code-char (+ nullc (mod (floor x pos) 10)))
			  val))
	     )
	    ((> pos x) (coerce (cdr val) 'string))
	    )
	)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ab hier stehen funktionen die in dem fertigen programm nicht mehr verwendet werden

(defun mmodid2specident (imodid)
  (let* ((modid (spalte (coerce imodid 'list) #\^))
	(name  (coerce (car modid)'string))
	(impl (if (null (2nd modid))
		  nil
		  (coerce (append (1st modid) 
			      '(#\. #\i #\m #\p #\l #\_) 
			      (2nd modid))
		      'string)
		  );if
	      )
	(prop (if (null (3rd modid))
		  nil
		  (coerce (append (1st modid)
			      '(#\. #\p #\r #\o #\p #\_)
			      (3rd modid))
		      'string)
		  );if
	      )
	 (pathname nil)
	 (oname name)
	 (oimpl impl)
	 (oprop prop)
	);erstes arg von let
	(cond ((and (null prop) (null impl))
	       (setq name (concatenate name ".asf"))
	       (setq path (make-pathname :directory *default-baum-dir*
					 :name name))
	       )
	      ((null prop)
	       (setq pathname (make-pathname :directory (append 
						     *default-baum-dir*
						     (list name))
					 :name (concatenate 'string impl ".asf")
					 )
		     );setq 
	       )
	      ((null impl)
	       (setq pathname (make-pathname :directory (append
							 *default-baum-dir*
							 (list name))
					     :name (concatenate 'string prop ".asf"))
		     );setq
	       )
	      (t
	       (setq pathname (make-pathname :directory (append
							 *default-baum-dir*
							 (list name impl))
					     :name (concatenate 'string prop ".asf"))
		     );setq
	       );t
	      );cond
	(list oname oimpl oprop pathname)
	);let
  );defun



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mpathname2specident (pathname)
  (let* ((pathlist (spalte (coerce pathname 'list) #\/))
	 (laenge (length pathlist))
	 (name nil) 
	 (impl nil)
	 (prop nil)
	 (last3 nil) 
	 (last2 nil)
	 (last1 nil)
	)
	(cond ((> laenge 2)
	       (setq last3 (nth (- laenge 3) pathlist))
	       (setq last2 (nth (- laenge 2) pathlist))
	       (setq last1 (nth (- laenge 1) pathlist) ))
	      ((= laenge 2)
	       (setq last3  (nth (- laenge 2) pathlist))
	       (setq last2 (nth (- laenge 1) pathlist))
	       )
	      (t 
	       (setq last3 (nth (- laenge 1) pathlist) ))
	      );cond
	(cond ((null last1)
	       (setq last1 (append last2 '( #\. #\a #\s #\f)))
	       (setq last2 last3)
	       (if (< 3 laenge)
	           (setq last3 (nth (- laenge 4) pathlist))
		   (setq last3 nil)
		   );if
	       );erstes arg von cond
	      );cond
	(cond ((equal (entferneab '(#\. #\p #\r #\o #\p #\_) last1) last1)
	       ;keine prop
	       (cond ((equal (entferneab '(#\. #\i #\m #\p #\l #\_) last1) last1);
		      ;keine impl
		      (setq name (coerce (entferneab '(#\. #\a #\s #\f) last1)
					 'string)
			    impl nil
			    prop nil)
		      )
		     (t (setq impl (coerce (entferneab '(#\. #\a #\s #\f)
						       (entfernebis 
							'( #\i #\m #\p #\l #\_) 
							last1))
					  'string)
			      name (coerce  last2
					   'string)
			      prop nil)
			);t

		     );cond
	       ) ;erstes elem von cond
	      (t (cond ((equal (entferneab '(#\. #\i #\m #\p #\l #\_) last2) last2);
			;keine impl
			(setq name (coerce last2
					   'string) 
			      impl nil
			      last1 (coerce 
				     (entferneab '(#\. #\a #\s #\f)
				                  (entfernebis '( #\p #\r #\o #\p)
							       last1) 
						 )
					    'string)
			      ))
		       (t (setq name (coerce last3
					     'string)
				impl (coerce (entferneab '(#\. #\a #\s #\f)
							 (entfernebis 
							  '( #\i #\m #\p #\l #\_)
						          last2))
					     'string)
				prop (coerce (entferneab '(#\. #\a #\s #\f)
							  (entfernebis 
							   '( #\p #\r #\o #\p)
							   last1))
					      'string)
				);setq 
			  );t
		       );cond
		 );t
	      );cond
	;;;noch ueberpruefen obpfad oder ffile
	(setq pathname (cond ((null (car pathlist))
			      ;absoluter pfad
			      (merge-pathnames pathname)
			      )
			     (t (setq pathlist (mapcar #'(lambda (x)
								 (coerce x 'string)
								 )
						       pathlist))
				)
			     );cond
	      );setq
						 
	(list name impl prop pathname)
	);let
  );defun

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun filter_spec_aux (liste)
  (remove-duplicates liste :test #'tree-equal)
  )
(defun filter_spec (darst)
  (list (filter_spec_aux (1st darst))
	(filter_spec_aux (2nd darst))
	(filter_spec_aux (3rd darst))
	(filter_spec_aux (4th darst))
	(mapcar #'filter_spec_aux (5th darst))
	(6th darst)
	)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun entferneab (xlist list)
   (subseq list 0 (search xlist list :from-end t ))
   );defun


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun entfernebis (xlist list)
   (subseq list  (search xlist list :from-end t ))
   );defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;urspruenglich um bei der definition von funktionen verwendet um jede 
;funktion einzeln mit ein umd ausgabesorte abzuspeichern
;wa.grammar.spec <9>
;funtab ;9
;wird in der fertigen version jedoch nicht mehr verwendet
;
(defun broesel_auf (funidlist ilist olist)
  (mapcar #'(lambda (elem)
		    (list elem ilist olist)
		    )
	  funidlist)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;diese funktion wird in der fertigen version nicht mehr verwendet
(defun modid2modid (imodid)
  (let* ((modid (spalte (coerce imodid 'list) #\^))
	(name  (coerce (car modid)'string))
	(impl (coerce (append (1st modid) 
			      '(#\. #\i #\m #\p #\l #\_) 
			      (2nd modid))
		      'string)
	      )
	(prop (coerce (append (1st modid)
			      '(#\. #\p #\r #\o #\p #\_)
			      (3rd modid))
		      'string)
	      )
	);erstes arg von let
       (list name impl prop)
       );let
  );defun

