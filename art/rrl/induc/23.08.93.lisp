(defun show-rrl (&optional (stream t))
  (format stream "RRL-SYSTEM~%")
  (format stream "~%")
  (format stream "equations :~%")
  (write-eqns $eqn-set stream)
  (format stream "~%")
  (format stream "rules :~%")
  (write-rules $rule-set stream)
  (format stream "~%")
  (format stream "depth of simplification : ~A~%" $over-rewrite)
  (format stream "~%")
  (format stream "premises :~%")
  (write-premises $premises-set stream)
  (format stream "~%")
  (format stream "var-premises :~%")
  (write-premises $var-premises  stream))



  