; *********************************************************************
; ** filename : spec-parser.lisp                                     **
; *********************************************************************  
; ** Diese Datei erzeugt den Parser fuer die SPEC-Dateien des RRLs   **
; *********************************************************************


(IN-PACKAGE "SAVE-RRL")


; *********************************************************************
; **-----------------------------------------------------------------**
; *********************************************************************
; ** Parser fuer SPEC-Dateien                                        **
; *********************************************************************
; **-----------------------------------------------------------------**
; *********************************************************************

; die folgenden Funktionen werden aus "log-parser" uebernommen
;
;  eot?, get-line, see-line


;**********************************************************************
;** function name :  load-spec                                       **
;** arguments     :  filename -- ein spec-file                       **
;** effect        :  liest das spec-file und erzeugt eine Liste der  **
;**                  eingelesenen strings                            **
;** return value  :  die Liste                                       **
;** edited        :  29.5.91                                         **
;** author        :  Stefan                                          **
;**********************************************************************
(defun load-spec (filename)
  ;** oeffne file zum Lesen
  (with-open-file (stream filename :direction :input)
                  (do ((line (read-line stream nil 'eof)
                             (read-line stream nil 'eof))
                       (liste nil))
		      ((eq line 'eof) (list (reverse liste)))
                      (setq liste (cons (string-downcase line) liste)))))

;**********************************************************************
;** function name :  spec-parser                                     **
;** arguments     :  text einer Spec-Datei                           **
;** effect        :  fuegt die extrahierte Information in die Spez-  **
;**                  ifikation der Log-Dateien                       **
;** return value  :  nil                                             **
;** edited        :  29.5.1991                                       **
;**********************************************************************
(defun spec-parser (text)
  (do ((line (see-line text) (see-line text))
       (entry nil nil)
      )
      ((eot? line) nil)
      ;** ueberlese Leerzeilen **
      (if (string= "" (string-trim " " line))
          (get-line text)
          (progn
                 (when *test*
                       (terpri)
                       (princ "Parsing : ") 
                       (princ line)
                 )
                 ;** laesst sich kein Eintrag finden, wird versucht **
		 ;** Gleichungen zu lesen **
                 ;** suche Eintrag **
                 (do ((table *rrl-spec-parse-table* (cdr table))
                      (found ; gibt an, ob Tabelleneintrag Teilstring ist
                             (search (caar *rrl-spec-parse-table*) line)
                             (search (caadr table) line)
                      )
                     )
                     ((or found (null table))
                      (if (null table)
                          ;; versuche Gleichungen zu lesen
			  ;; (setq entry 'read-equations-and-rules)
			  ;; Eschbach Wed Aug 17 15:40:12 MET DST 1994
			  ;; Gleichungen werden falsch gelesen, aber spec-equations
			  ;; werden sowieso nicht gebraucht !!
			  nil
                          (setq entry (cadar table))
                      ))
                 )
                 ;** fuehre Funktion aus **
                 (if entry
                     (funcall entry text)
                     ; else ueberlese Zeile
                     (get-line text)
                 )
          ) ;** progn **
      ) ;** if **
  ) ;** do **
) ;** spec-parser **
                      

; *********************************************************************
; ** Parse-Funktionen                                                **
;**********************************************************************

;**********************************************************************
;** function name :  read-arities                                    **
;** arguments     :  der zu lesende Text                             **
;** return value  :  nil                                             **
;** edited        :  29.5.1991                                       **
;**********************************************************************
(defun read-arities (text)
; Der zu lesende Text:
;   "The arities of the operators are:
;       succ: INT -> INT
;       ..."
  (get-line text)
  (do ((line (see-line text) (see-line text))
       (arity nil nil)
      )
      ((string= "" (string-trim " " line))
       )
      (setq arity (read-arity line))
      (when *test*
            (print arity)
      )
      (insert-spec *log-spec* 'function (list arity))
      ; fuege Sorten ein
      (insert-spec *log-spec* 'sort (fdef-eingabe-sorten arity)) 
      (insert-spec *log-spec* 'sort (fdef-ausgabe-sorten arity))
      (get-line text)
  )
)

;**********************************************************************
;** function name :  read-constructors                               **
;** arguments     :  der zu lesende Text                             **
;** return value  :  nil                                             **
;** edited        :  29.5.1991                                       **
;**********************************************************************
(defun read-constructors (text)
; Der zu lesende Text:
;   "The system has the following constructors:
;       Type 'INT': { 0, succ, pred }
;       ..."
  (get-line text)
  (do ((line (see-line text) (see-line text))
       (cons nil)
      )
      ((string= "" (string-trim " " line))
       (insert-spec *log-spec* 'constructor cons)
      )
      (when *test*
            (terpri)
      )
      (let ((index (search "{" line))
           )
           (when index
                 (do ((index1 (+ index 1) 
                              (+ index2 1))
                      (index2 (+ (min-nil
                                     (position #\, (subseq line (+ index 1)))
                                     (position #\} (subseq line (+ index 1)))
                                 )
                                 (+ index 1))
                              (+ (min-nil
                                     (position #\, (subseq line (+ index2 1)))
                                     (position #\} (subseq line (+ index2 1)))
                                 )
                                 (+ index2 1))
                      )
                     )
                     ((char-equal (char line index2) #\})
                      (when *test*
                            (princ (string-trim " " (subseq line index1 index2)))
                      )
                      (push (list (string-trim " " (subseq line index1 index2)))
                            cons)
                     )
                     (when *test*
                           (princ (string-trim " " (subseq line index1 index2)))
                           (princ " ")
                     )
                     (push (list (string-trim " " (subseq line index1 index2)))
                           cons)
                 )
           )
      )
      (get-line text)
  )
)

;**********************************************************************
;** function name :  read-equivalence                                **
;** arguments     :  der zu lesende Text                             **
;** return value  :  nil                                             **
;** edited        :  29.5.1991                                       **
;**********************************************************************
(defun read-equivalence (text)
; Der zu lesende Text:
;  "Equivalence relation among operators now is:
;   Equivalent set: { -, -- }
;   ..."
  (get-line text)
  (do ((line (see-line text) (see-line text))
       (liste nil nil)
      )
      ((string= "" (string-trim " " line))
       )
      (when *test*
            (terpri)
      )
      (let ((index (search "{" line))
           )
           (when index
                 (do ((index1 (+ index 1) 
                              (+ index2 1))
                      (index2 (+ (min-nil
                                     (position #\, (subseq line (+ index 1)))
                                     (position #\} (subseq line (+ index 1)))
                                 )
                                 (+ index 1))
                              (+ (min-nil
                                     (position #\, (subseq line (+ index2 1)))
                                     (position #\} (subseq line (+ index2 1)))
                                 )
                                 (+ index2 1))
                      )
                     )
                     ((char-equal (char line index2) #\})
                      (when *test*
                            (princ (string-trim " " (subseq line index1 index2)))
                      )
;                      (push (string-trim " " (subseq line index1 index2)) liste)
                     )
                     (when *test*
                           (princ (string-trim " " (subseq line index1 index2)))
                           (princ " ")
                     )
;                     (push (string-trim " " (subseq line index1 index2)) liste)
                 )
           )
      )
;      (insert-spec *log-spec* 'equivalence (reverse liste))
      (get-line text)
  )
)

;**********************************************************************
;** function name :  read-precedence                                 **
;** arguments     :  der zu lesende Text                             **
;** return value  :  nil                                             **
;** edited        :  29.5.1991                                       **
;**********************************************************************
(defun read-precedence (text)
; Der zu lesende Text:
;   "Precedence relation now is:
;      nf > nf2 succ pred
;      ..."
  (get-line text)
  (do ((line (see-line text) (see-line text))
       (liste nil nil)
       (pred nil)
      )
      ((string= "" (string-trim " " line))
       (insert-spec *log-spec* 'precedence pred)
      )
      ; lese erste Funktion
      (when *test*
            (terpri)
            (princ (string-trim " " (subseq line 0 (position #\> line))))
            (princ " > ")
      )
;** Eschbach
;** 07.05.92
;      (push (string-trim " " (subseq line 0 (position #\> line))) liste)
      (push (string-trim " " (subseq line 0 (search " > " line))) liste)
      
      ; lese alle folgenden Funktionen
;      (do* ((index1 (+ (position #\> line) 2)
      (do* ((index1 (+ (search " > " line) 3)
                    (+ index2 1))
            (index2 (+ (min-nil
                           (position #\  (subseq line index1))  
                           (- (length (subseq line index1)) 1)
                       )
                       index1)
                    (+ (min-nil
                           (position #\  (subseq line index1))
                           (- (length (subseq line index1)) 1)
                       )
                       index1)
            )
           )
           ((>= index1 (length line))
           )
           (when *test*
                 (princ (string-trim " " (subseq line index1 (+ index2 1))))
                 (princ " ")
           )
           (push (string-trim " " (subseq line index1 (+ index2 1))) liste)
      )
      (push (nreverse liste) pred)
      (get-line text)
  )
)

;**********************************************************************
;** function name :  read-status                                     **
;** arguments     :  der zu lesende Text                             **
;** return value  :  nil                                             **
;** edited        :  29.5.1991                                       **
;**********************************************************************
(defun read-status (text)
; Der zu lesende Text:
;   "Operators with status are:
;      < with right-to-left status.
;      ..."
  (get-line text)
  (do ((line (see-line text) (see-line text))
       (states nil)
      )
      ((string= "" (string-trim " " line))
       (insert-spec *log-spec* 'status states)
      )
      (let ((with (search "with" line))
            (status (search "status" line))
           )
           (when *test*
                 (terpri)
                 (princ (string-trim " " (subseq line 0 with)))
                 (princ " has ")
                 (princ (string-trim " " (subseq line (+ with 4) status)))
           )
           (push (list (string-trim " " (subseq line 0 with))
                       (let ((status (string-trim " " (subseq line (+ with 4) status)))
                            )
                            (cond ((string= status "left-to-right")
                                   "l")
                                  ((string= status "right-to-left")
                                   "r")
                                  ('TRUE
                                    (error "INTERNER FEHLER in Funktion read-status!")
                                  )
                            )
                       ))
                 states
           )
      )
      (get-line text)
  )
)

;**********************************************************************
;** function name :  read-ac-set                                     **
;** arguments     :  der zu lesende Text                             **
;** return value  :  nil                                             **
;** edited        :  29.5.1991                                       **
;**********************************************************************
(defun read-ac-set (text)
; Der zu lesende Text:
;   "Associative & commutative operator set = { nf }"
 (let* ((line (get-line text))
         (index (search "{" line))
        )
        (when index
              (when *test*
                    (terpri)
              )
              (do ((index1 (+ index 1) 
                           (+ index2 1))
                   (index2 (+ (min-nil
                                  (position #\, (subseq line (+ index 1)))
                                  (position #\} (subseq line (+ index 1)))
                              )
                              (+ index 1))
                           (+ (min-nil
                                  (position #\, (subseq line (+ index2 1)))
                                  (position #\} (subseq line (+ index2 1)))
                              )
                              (+ index2 1))
                    )
                    (liste nil)
                   )
                   ((char-equal (char line index2) #\})
                    (when *test*
                          (princ (string-trim " " (subseq line index1 index2)))
                    )
                    (insert-spec *log-spec* 'ac-operator
                                 (cons (string-trim " " (subseq line index1 index2))
                                       liste))
                   )
                   (when *test*
                         (princ (string-trim " " (subseq line index1 index2)))
                         (princ " ")
                   )
                   (setq liste (cons (string-trim " " (subseq line index1 index2))
                                     liste))
              )
        )
  )
)

;**********************************************************************
;** function name :  read-c-set                                      **
;** arguments     :  der zu lesende Text                             **
;** return value  :  nil                                             **
;** edited        :  29.5.1991                                       **
;**********************************************************************
(defun read-c-set (text)
; Der zu lesende Text:
;   "Commutative operator set = { ++, equal2 }"
 (let* ((line (get-line text))
         (index (search "{" line))
        )
        (when index
              (when *test*
                    (terpri)
              )
              (do ((index1 (+ index 1) 
                           (+ index2 1))
                   (index2 (+ (min-nil
                                  (position #\, (subseq line (+ index 1)))
                                  (position #\} (subseq line (+ index 1)))
                              )
                              (+ index 1))
                           (+ (min-nil
                                  (position #\, (subseq line (+ index2 1)))
                                  (position #\} (subseq line (+ index2 1)))
                              )
                              (+ index2 1))
                    )
                    (liste nil)
                   )
                   ((char-equal (char line index2) #\})
                    (when *test*
                         (princ (string-trim " " (subseq line index1 index2)))
                     )
                    (insert-spec *log-spec* 'c-operator
                                (cons (string-trim " " (subseq line index1 index2))
                                      liste))
                   )
                   (when *test*
                         (princ (string-trim " " (subseq line index1 index2)))
                         (princ " ")
                   )
                   (setq liste (cons (string-trim " " (subseq line index1 index2))
                                     liste))
              )
        )
  )
)

;**********************************************************************
;** function name :  read-equations-and-rules                        **
;** arguments     :  der zu lesende Text                             **
;** return value  :  nil                                             **
;** edited        :  29.5.1991                                       **
;**********************************************************************
(defun read-equations-and-rules (text)
  (insert-spec *log-spec* 'spec-equation 
               (list (read-equation (get-line text) text)))
)


;**********************************************************************
;**                   Test-Funktionen                                **
;**********************************************************************

(when *test*
  (defun test ()
    (setq *log-spec* (make-spec))
    (spec-parser (load-spec "~madprak2/tester/list-ext1/list-ext1.spec"))
    (print-spec *log-spec*)
  )
)

