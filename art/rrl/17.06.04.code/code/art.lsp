(in-package "USER")

;; speed of compilation process totally unimportant
;; speed of the object code extremely important
;; (proclaim '(optimize (compilation-speed 0) (speed 3)))

(defvar $art 'off)

(defvar $handle-and 'off)

(defun art? ()
  (eq $art 'on))

(defun handle-and? ()
  (eq $handle-and 'on))

;; Wenn RRL im ART-Modus arbeitet, wird bei bestimmten Anfragen von
;; RRL, die Frage an die Tastatur geleitet.
;; Damit wird verhindert, dass die jeweils naechste Zeile 
;; von einem ART-Kommando-File als Antwort interpretiert wird.
;; Eine typische Stelle ist etwa die Abarbeitung von makerule, wenn eine
;; Gleichung nicht orientiert werden kann.
(defmacro when-art-with-input-from-terminal (&body body)
  `(let ((port-buffer $in-port))
	 (when (art?) (setq $in-port nil))
	 (unwind-protect 
	     (progn ,@body)
	   (when (art?) (setq $in-port port-buffer)))))

;; Wird eine Gleichung als Kommentar ausgegeben, so beginnt
;; jede Zeile dieser Ausgabe mit einem ';',
;; d.h. auch wenn sich die Gleichung ueber mehrere
;; Zeilen erstreckt !
(defun write-comment-eqn (eqn &optional port)
  ;  Writes out equation EQN to port PORT as comment.
  (write-term-simple (lhs eqn) port)
  (if* (or (is-condi-eqn eqn) (not (is-assertion eqn))) then 
     (if (is-source-type eqn 'def) (princ " := " port)
       (princ " == " port))
     (write-comment-rhs (rhs eqn) (ctx eqn) port))
  (terpri port))

(defun write-comment-rhs (rhs ctx &optional port)
  (if* (truep rhs) then (princ 'true port) else (write-disjunctions rhs 2 port))
  (if* ctx then (princ "  if  " port)
      (if* (is-premise-set ctx) 
	  then (write-comment-premises (cdr ctx) port)
	  else (write-disjunctions ctx 3 port))))

(defun write-comment-premises (pres &optional port)
  (if* (cdr pres) then
    (terpri port) (princ ";        " port)
    (princ "{ " port)
    (write-one-pre (car pres) port)
    (sloop for xa in (cdr pres) do
      (princ "," port) 
      (terpri port)
      (princ ";          " port)
      (write-one-pre xa port))
    else
    (princ " { " port) 
    (write-one-pre (car pres) port))
    (princ " } " port))


;; In RRL kann unter 'option art' der ART-Modus 
;; an- bzw. ausgeschaltet werden.
(defun set-art-mode ()
  (ask-choice $art '(on off) 
	      "      on  -- enables art-mode"
	      "      off -- disables art-mode"
	      "Please make your choice: "))

;; In RRL kann unter 'option and' der Handle-And-Modus 
;; an- bzw. ausgeschaltet werden.
(defun set-handle-and ()
  (ask-choice $handle-and '(on off) 
	      "      on  -- enables handle-and"
	      "      off -- disables handle-and"
	      "Please make your choice: "))

;; New function added June1991
;; from conditionals.l 
(defun handle-and (ctx)
  (if* (eq (car ctx) '&&) then
      (let ((result1 '(and))
	    (result2 nil))
	(loop for elem in (cdr ctx) do
	      (if* (or (equal (cdr elem) '(nil)) 
		      (equal (cadr elem) '(true)))
		   ;;                                     (equal (cdr elem) '(nil used))
		  then (setq result1 (append result1 (list (car elem))))
		  (setq result2 (append result2 (list elem)))
		  else (setq result2 (append result2 (list elem)))))
	(if* (equal result1 '(and))
	    then ctx
	    else (if* (= (length result1) 2)
		     then ctx
		     ;; (append (list '&&) result2 (list (list (cadr result1) 'nil)))
		     else (append (list '&&) result2 (list (list (norm-ctx result1) 'nil))))))
    else ctx))

(defun make-rrl-image (&optional (name "nrrl"))
 "Creates an image for rrl. Note, that a big Common-Lisp
 produces a great image. Look in your lisp-directory and
 choose a little lisp, e.g. lisp-4-0-base* instead of lisp-4-0-clos-clx*, which
 contains clos and other memory-exhaustive things.
 In general you should compile rrl first with the whole optimization-power, 
 this can be achieved by (proclaim '(optimize (compilation-speed 0) (speed 3))).
 This instruction will switch the compiler into production mode, and allows
 all optimizations are possible. Then start a little lisp, load rrl in compiled
 form and simply call this function. This function works only under Lucid!"
  (disksave name  :restart-function 'start-rrl :full-gc t :verbose t))






