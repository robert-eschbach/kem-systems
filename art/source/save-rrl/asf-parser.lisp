; *********************************************************************
; ** filename : asf-parser.lisp                                      **
; *********************************************************************  
; ** Diese Datei uebernimmt die interne Listenstruktur der ASF-Spezi-**
; ** fikation.                                                       **
; *********************************************************************


(IN-PACKAGE "SAVE-RRL")



;**********************************************************************
;** function name :  asf-parser                                      **
;** arguments     :  Liste des einer ASF-Spezifikation nach Umbe-    **
;**                  nennung                                         **
;** effect        :  fuegt in Spec-Datenstruktur ein                 **
;** return value  :                                                  **
;** edited        :  31.5.1991                                       **
;**********************************************************************
(defun asf-parser (asf-liste)
  ; Sorten
  (do ((l (nth 0 asf-liste) (cdr l))
       (sorts nil (cons (caar l) sorts))
      )
      ((null l)
       (insert-spec *asf-spec* 'sort sorts)
      )
  )
  ; Funktionen
  (do ((l (nth 1 asf-liste) (cdr l))
       (funkts nil (cons (list (caaaar l)
                               (cadaar l)
                               (car (cddaar l))
                               (cdaaar l)
                         )
                         funkts))
      )
      ((null l)
       (insert-spec *asf-spec* 'function funkts)
      )
  )
  ; Variablen
  (do ((l (nth 2 asf-liste) (cdr l))
       (vars nil (cons (list (caaaar l)
                               (caar (cddaar l))
                               (cadar l))
                       vars))
      )
      ((null l)
       (insert-spec *asf-spec* 'variable vars)
      )
  )
  ; Gleichungen
  (do ((l (nth 3 asf-liste) (cdr l))
       (equs nil)
      )
      ((null l) 
       (insert-spec *asf-spec* 'add-equation equs)
      )
      (let ((terme (cadaar l))
           )
           (push (list (car terme)
                       (let ((equ (caddr (caar l)))
                            )
                            (cond ((equal equ "gl-gl") "==")
                                  ((equal equ "def-gl") ":=")
                                  ((equal equ "r-gl") "-->")
                            )
                       )
                       (cadr terme)
                       (cddr terme)	; coditionals
                 )
                 equs
           )
      )
  )
  ; Properties
    ; Konstruktoren
    (do ((l (nth 0 (nth 4 asf-liste)) (cdr l))
         (cons nil)
        )
        ((null l)
         (insert-spec *asf-spec* 'constructor cons)
        )
        (do ((k (caar l) (cdr k))
            )
            ((null k) )
            (if (null (cadr (get-entry *asf-spec* 'function (caar k))))
                (push (list (caar k) 'frei) cons)
                (push (car k) cons)
            )
        )
    )
    ; AC-Operatoren
    (do ((l (nth 1 (nth 4 asf-liste)) (cdr l))
         (ops nil)
        )
        ((null l)
         (insert-spec *asf-spec* 'ac-operator ops)
        )
        (dolist (k (caar l)) (push k ops))
    )
    ; C-Operatoren
    (do ((l (nth 2 (nth 4 asf-liste)) (cdr l))
         (ops nil)
        )
        ((null l)
         (insert-spec *asf-spec* 'c-operator ops)
        )
        (dolist (k (caar l)) (push k ops))
    )
    ; Ordnung
    (do ((l (nth 3 (nth 4 asf-liste)) (cdr l))
        )
        ((null l) )
        ; Option "lrpo"
        (when (caaar l)
              (insert-spec *asf-spec* 'option (list (caaar l)))
        )
        ; Praezedenz
;        (do ((k (cadaar l) (cdr k))
;            )
 ;           ((null k) )
            (insert-spec *asf-spec* 'precedence  (cadaar l) ) ;(car k))
;        )
        ; Status
        (do ((k (caddr (caar l)) (cdr k))
            )
            ((null k) )
            (do ((m (caar k) (cdr m))
                 (result nil)
                )
                ((null m)
                 (insert-spec *asf-spec* 'status result)
                )
                (push (list (car m) (cadar k)) result)
            )
        )
    )
    ; Theoreme
    (do ((l (nth 4 (nth 4 asf-liste)) (cdr l))
         (equs nil)
        )
        ((null l)
         (insert-spec *asf-spec* 'prove equs)
        )
        (let ((terme (cadr (caaar l)))
             )
             (push (list (car terme)
                         (let ((equ (caddr (caaar l)))
                              )
                              (cond ((equal equ "gl-gl") "==")
                                    ((equal equ "def-gl") ":=")
                                    ((equal equ "r-gl") "-->")
                              )
                         )
                         (cadr terme)
                         (cddr terme)
                         (cadaar l)
                   )
                   equs
             )
        )
    )
)

;**********************************************************************
;**                   Test-Funktionen                                **
;**********************************************************************

(when *test*
  (defvar test-list nil)

  (setq test-list 
    '(
      ; Sorten
      (("BOOL" nil nil nil) ("NAT " nil nil nil) ("NSTRING" nil nil nil)
      )
      ; Funktionen
      (((("0" . "functor") nil ("NAT")) nil nil nil)
       ((("succ" . "functor") ("NAT") ("NAT")) nil nil nil)
       ((("pred" . "functor") ("NAT") ("NAT")) nil nil nil)
       ((("+" . "functor") ("NAT" "NAT") ("NAT")) nil nil nil)
       ((("gcd" . "functor") ("NAT" "NAT") ("NAT" "NAT")) nil nil nil)
       ((("true" . "functor") ("NAT") ("NAT")) nil nil nil)
      )
      ; Variablen
      (((("x") nil ("BOOL")) nil nil nil)
       ((("y") nil ("BOOL")) nil nil nil)
       ((("i") nil ("NAT")) nil nil nil)
       ((("j") nil ("NAT")) nil nil nil)
      )
      ; Gleichungen
      ((("23" ((("and" . "functor") "true" "x") (("and" . "functor") "x" "true")) "gl-gl") nil)
       (("24" ((("and" . "functor") "false" "x") "false" (("and" . "functor") "true" "x") (("and" . "functor") "x" "true")) "gl-gl") nil)
      )
      ; Properties
      (
       ; Konstruktoren
       (((("true" nil) ("false" nil)) nil)
        ((("0" "frei") ("succ" "frei") ("pred" "frei")) nil)
       )
       ; AC-Operatoren
       ((("and" "or") nil)
        (("+") nil)
       )
       ; C-Operatoren
       ((("equal" "=") nil)
       )
       ; Ordnung
       ((("lrpo"
          (("succ" "eq" "not" "or") ("and" "nand" "nor" "xor"))
          ((("succ" "not" "eq") "l") (("nor") "m"))
         )
         nil)
        ((nil
          (("false" "true"))
          ((("true") "l") (("false" "nor") "m"))
         )
         nil) 
       )
       ; Theoreme
       ((((nil ((("and" . "functor") "true" "x") (("and" . "functor") "x" "true")) "gl-gl") ("e" "o")) nil)
        (((nil ((("and" . "functor") "false" "x") "false" (("and" . "functor") "true" "x") (("and" . "functor") "x" "true")) "gl-gl") nil) nil)
       )
      )
    )
  )

  (defun test ()
    (setq *asf-spec* (make-spec))
    (asf-parser test-list)
    (print-spec *asf-spec*)
  )
)
