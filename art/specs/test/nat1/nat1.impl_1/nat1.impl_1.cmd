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
OPERATOR
PRECEDENCE
>= < 
OPERATOR
STATUS
*
RL
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
PROVE
(X + Y) == (Y + X)

; All subgoals are proved so 
; (0 + X) == X
;  is an inductive theorem.

; All subgoals are proved so 
; (SUCC(Y) + X) == SUCC((Y + X))
;  is an inductive theorem.

; All subgoals are proved so 
; (X + Y) == (Y + X)
;  is an inductive theorem.
; Following equation
;    (X + Y) == (Y + X)
;    is an inductive theorem in the current system.
PROVE
(X * (Y + Z)) == ((X * Y) + (X * Z))

; All subgoals are proved so 
; (X + (Z + Z1)) == (Z + (X + Z1))
;  is an inductive theorem.

; All subgoals are proved so 
; (X * (Y + Z)) == ((X * Y) + (X * Z))
;  is an inductive theorem.
; Following equation
;    (X * (Y + Z)) == ((X * Y) + (X * Z))
;    is an inductive theorem in the current system.
PROVE
(X < SUCC(0)) == (X = 0)

; All subgoals are proved so 
; (X < SUCC(0)) == (0 = X)
;  is an inductive theorem.
; Following equation
;    (X < SUCC(0)) == (0 = X)
;    is an inductive theorem in the current system.
PROVE
((X + Y) = 0) == ((X = 0) AND (Y = 0))

; All subgoals are proved so 
; ((X + Y) = 0) == FALSE  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    ((X + Y) = 0) == (0 = X) & (0 = Y)
;    is an inductive theorem in the current system.
PROVE
((X + Y) = Y) == (X = 0)

; All subgoals are proved so 
; ((X + Y) = Y) == (0 = X)
;  is an inductive theorem.
; Following equation
;    ((X + Y) = Y) == (0 = X)
;    is an inductive theorem in the current system.
PROVE
((X + Z) = (Y + Z)) == (X = Y)

; All subgoals are proved so 
; ((Y + Z) = (X + Z)) == (Y = X)
;  is an inductive theorem.
; Following equation
;    ((Y + Z) = (X + Z)) == (Y = X)
;    is an inductive theorem in the current system.
PROVE
((X * Y) = 0) == ((X = 0) OR (Y = 0))

; All subgoals are proved so 
; (0 * Y) == 0
;  is an inductive theorem.

; All subgoals are proved so 
; ((X * Y) = 0) == (0 = Y)  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    ((X * Y) = 0) == ((0 = X) OR (0 = Y))
;    is an inductive theorem in the current system.
PROVE
((X * Y) = X) == (Y = SUCC(0)) if NOT((X = 0))

; All subgoals are proved so 
; ((X * Y) = X) == (SUCC(0) = Y)  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    ((X * Y) = X) == (SUCC(0) = Y)  if   { not((0 = X)) } 
;    is an inductive theorem in the current system.
PROVE
((X * Y) = X) == ((Y = SUCC(0)) OR (X = 0))
; Following equation
;    ((X * Y) = X) == ((0 = X) OR (SUCC(0) = Y))
;    is an inductive theorem in the current system.
PROVE
((X * Y) = SUCC(0)) == ((X = SUCC(0)) AND (Y = SUCC(0)))

; All subgoals are proved so 
; ((X + Z) = SUCC(0)) == FALSE  if  
;        { not((SUCC(0) = Z)),
;          not((SUCC(0) = X)) } 
;  is an inductive theorem.

; All subgoals are proved so 
; ((X * Y) = SUCC(0)) == FALSE  if   { not((SUCC(0) = X)) } 
;  is an inductive theorem.
; Following equation
;    ((X * Y) = SUCC(0)) == (SUCC(0) = X) & (SUCC(0) = Y)
;    is an inductive theorem in the current system.
PROVE
(Y < SUCC(Y))

; All subgoals are proved so 
; (Y < SUCC(Y))
;  is an inductive theorem.
; Following equation
;    (Y < SUCC(Y))
;    is an inductive theorem in the current system.
PROVE
(0 >= U) == (U = 0)

; All subgoals are proved so 
; (0 >= U) == (0 = U)
;  is an inductive theorem.
; Following equation
;    (0 >= U) == (0 = U)
;    is an inductive theorem in the current system.
PROVE
(SUCC(X) < Y) == TRUE if ((X < Y) AND NOT((SUCC(X) = Y)))

; All subgoals are proved so 
; (0 < X) == TRUE  if   { not((0 = X)) } 
;  is an inductive theorem.

; All subgoals are proved so 
; (SUCC(X) < Y) == TRUE  if  
;        { (X < Y),
;          not((SUCC(X) = Y)) } 
;  is an inductive theorem.
; Following equation
;    (SUCC(X) < Y) == TRUE  if  
;        { (X < Y),
;          not((SUCC(X) = Y)) } 
;    is an inductive theorem in the current system.
PROVE
(U >= Z) == NOT((U < Z))

; All subgoals are proved so 
; NOT((U < U))
;  is an inductive theorem.

; All subgoals are proved so 
; (SUCC(X) < Z) == (X < Z)  if   { not((SUCC(X) = Z)) } 
;  is an inductive theorem.

; All subgoals are proved so 
; (U >= Z) == NOT((U < Z))
;  is an inductive theorem.
; Following equation
;    (U >= Z) == NOT((U < Z))
;    is an inductive theorem in the current system.
PROVE
((U * Y) < SUCC(Y)) == FALSE if (NOT((U = 0)) AND (NOT((U = SUCC(0))) AND NOT((Y = 0))))
EXIT
Y

; All subgoals are proved so 
; ((U * Y) < SUCC(Y)) == FALSE  if  
;        { not((0 = U)),
;          not((0 = Y)),
;          not((SUCC(0) = U)) } 
;  is an inductive theorem.
; Following equation
;    ((U * Y) < SUCC(Y)) == FALSE  if  
;        { not((0 = U)),
;          not((0 = Y)),
;          not((SUCC(0) = U)) } 
;    is an inductive theorem in the current system.
WRITE
SPEC-WRITE
/USR/PROGRESS/ART/SPECS/TEST/NAT1/NAT1.IMPL_1/NAT1.IMPL_1
Y
