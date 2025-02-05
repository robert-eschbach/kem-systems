ADD
      [0 : -> NAT ]
      [* : NAT, NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [SUCC : NAT -> NAT ]
(X + 0) := X
(X + SUCC(Y)) := SUCC((X + Y))
(X * 0) := 0
(X * SUCC(Y)) := (X + (X * Y))
]
OPERATOR
CONSTRUCTOR
0 
OPERATOR
CONSTRUCTOR
SUCC 
YES
OPTION
ORDER
L
MAKERULE
QUIT
SUFFICE

; Note: the system may be not canonical.

; Specification of '+' is completely defined.

; Specification of '*' is not known to be completely defined.
; Following left hand sides of rules are proposed: 
;    (X * SUCC(X1)) ---> something
OPTION
PROVE
E
COVER

; Specification of '+' is completely defined.

; Specification of '*' is not known to be completely defined.
; Following left hand sides of rules are proposed: 
;    (X * SUCC(X1)) ---> something
QUIT
