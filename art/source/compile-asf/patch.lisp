(defun is-bool-op (op) (memq op $bool-ops))

(defun display-type-arity (ops &optional port)
  (setq ops (loop for op in ops
                  if (not (or (memq op '(eq typed))
                              (is-bool-op op)
                              (assoc op $type-rela)))
                    collect op))
  (if ops then
      (terpri port)
     (cond  ((not (eq port $log-port) )
	   (princ "The arities of the operators are:" port) (terpri port)
	   )
	    )
      (display-arity2 ops port)
      (terpri port)))


