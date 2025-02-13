(in-package "SAVE-RRL")

(defmacro fdef-name (fdef)
  `(car ,fdef)
)

(defmacro fdef-eingabe-sorten (fdef)
  `(cadr ,fdef)
)

(defmacro fdef-ausgabe-sorten (fdef)
  `(caddr ,fdef)
)

(defmacro fdef-code (fdef)
  `(cadddr ,fdef)
)

(defmacro fdef-set-name (fdef new-name)
  `(rplaca ,fdef ,new-name)
)

(defmacro fdef-set-code (fdef new-code)
  `(rplacd (cddr ,fdef) (list ,new-code))
)

(defmacro find-function (function f-liste)
  `(assoc ,function ,f-liste :test 'equal)
)

(defmacro var-name (var)
  `(car ,var)
)

(defmacro var-sorte (var)
  `(cadr ,var)
)

(defmacro var-spec (var)
  `(caaddr ,var)
)

(defmacro var-set-name (var name)
  `(rplaca ,var ,name)
)

(defmacro find-var (var var-liste)
  `(assoc ,var ,var-liste :test 'equal)
)

(defmacro equ-t1 (equ)
  `(car ,equ)
)

(defmacro equ-gl (equ)
  `(cadr ,equ)
)

(defmacro equ-t2 (equ)
  `(caddr ,equ)
)

(defmacro equ-conds (equ)
  `(cadddr ,equ)
)

(defmacro equ-flags (equ)
  `(cadddr (cdr ,equ))
)

(defmacro term-function (term)
  `(caar ,term)
)

(defmacro term-code (term)
  `(cdar ,term)
)

(defmacro term-args (term)
  `(cdr ,term)
)

(defmacro term-set-code (term code)
  `(rplacd (car ,term) ,code)
)




