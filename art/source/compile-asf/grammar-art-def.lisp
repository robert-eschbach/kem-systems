;; Eine modifizierte Grammatik fuer die im Praktikum verwendeten Spezifikationssprache

(in-package "COMPILE-ASF")

(defparameter *art-grammar (make-grammar)) 

(setf (grammar-scanner *art-grammar) 'scanner-art)  

(setf (grammar-terminals *art-grammar) 
  '(nil ident ignore operator tag spec-ident -> |:=| == --> dp-f ))  

(setq *keywords 
  '(specification begin end exports imports sorts functions 
    variables equations when properties constructors ac-operators
    c-operators ordering lrpo precedence status theorems l  r m e o f
    -> --> ==))

(setf (grammar-terminals *art-grammar)  
  (union (grammar-terminals *art-grammar) *keywords))

(defun get-keywords () *keywords)

(setf (grammar-token-fn-tab *art-grammar)
  `((name . ,#'(lambda (token)   
                 (default-keyword-translation token (get-keywords) nil 'ident 'name :package (find-package "COMPILE-ASF"))))
    (number . ,#'(lambda (token)
			 (setf (token-type token) 'ident)
			 (setf (token-val token) (token-string token))))
    (dp-f . ,#'(lambda (token) t))
    (operator . ,#'(lambda (token)   
			   (cond ((eq (elt (token-string token) 0 ) #\')
				  (setf (token-string token)
					(subseq (token-string token)
						1))))
                     (default-keyword-translation token (get-keywords) nil nil nil  :package (find-package "COMPILE-ASF"))))
    (pfadname . ,#'(lambda (token)
			  (setf (token-type token) 'spec-ident)
			  (pathname2specident (token-string token))))
    (modid . ,#'(lambda (token)
		       (setf (token-type token) 'spec-ident)
		       (modid2specident (token-string token))))
   )) 

(setf (grammar-start-sym *art-grammar) 'specification-def)  

(setf (grammar-fn-tab *art-grammar) *semantic-actions*)

(unless (eq (tread-grammar-rule-base 
	     (merge-pathnames art::*compile-asf-path* #P"grammar-art.syntax") 
	     *art-grammar)
            'parse-error)
  (tpgen2 :grammar *art-grammar))


