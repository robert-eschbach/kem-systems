OPTION
HISTORY
NO-HISTORY
ADD
      [0 : -> NAT ]
      [>= : NAT, NAT -> BOOL ]
      [< : NAT, NAT -> BOOL ]
      [- : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [SUCC : NAT -> NAT ]
(X + 0) := X
(X + SUCC(Y)) := SUCC((X + Y))
(0 - X) := 0
(X - 0) := X
(SUCC(X) - SUCC(Y)) := (X - Y)
(X * 0) := 0
(X * SUCC(Y)) := (X + (X * Y))
(X < 0) := FALSE
(0 < SUCC(X)) := true 
(SUCC(X) < SUCC(Y)) := (X < Y)
(X >= X) := true 
(0 >= SUCC(Y)) := FALSE
(SUCC(X) >= Y) := (X >= Y) if NOT((SUCC(X) = Y))
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
OPERATOR
PRECEDENCE
* + 
MAKERULE
SUFFICE

; Note: the system may be not canonical.

; Specification of '+' is completely defined.

; Specification of '*' is completely defined.

; Specification of '-' is completely defined.

; Specification of '<' is completely defined.

; Specification of '>=' is not known to be completely defined.
; Following left hand sides of rules are proposed: 
;    (SUCC(X) >= SUCC(X1)) ---> something
OPTION
PROVE
E
COVER

; Specification of '+' is completely defined.

; Specification of '*' is completely defined.

; Specification of '-' is completely defined.

; Specification of '<' is completely defined.

; Specification of '>=' is not known to be completely defined.
; Following left hand sides of rules are proposed: 
;    (SUCC(X) >= SUCC(X1)) ---> something
Y
ADD
]
MAKERULE
WRITE
SPEC-WRITE
/HOME/SYSTEME/ART/SPECS/TEST/NATURALS/NATURALS.IMPL_1/NATURALS.IMPL_1
Y
