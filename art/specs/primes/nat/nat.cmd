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
      [SUC : NAT -> NAT ]
(X + 0) := X
(X + SUC(Y)) := SUC((X + Y))
(0 - X) := 0
(X - 0) := X
(SUC(X) - SUC(Y)) := (X - Y)
(X * 0) := 0
(X * SUC(Y)) := (X + (X * Y))
(X < 0) := FALSE
(0 < SUC(X)) := true 
(SUC(X) < SUC(Y)) := (X < Y)
(X >= X) := true 
(0 >= SUC(Y)) := FALSE
(SUC(X) >= Y) := (X >= Y) if NOT((SUC(X) = Y))
]
OPERATOR
CONSTRUCTOR
0 
OPERATOR
CONSTRUCTOR
SUC 
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
;    (SUC(X) >= SUC(X1)) ---> something
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
;    (SUC(X) >= SUC(X1)) ---> something
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
; (SUC(Y) + X) == SUC((Y + X))
;  is an inductive theorem.

; All subgoals are proved so 
; (X + Y) == (Y + X)
;  is an inductive theorem.
; Following equation
;    (X + Y) == (Y + X)
;    is an inductive theorem in the current system.
PROVE
((X + Y) + Z) == (X + (Y + Z))

; All subgoals are proved so 
; (Z + (X + Y)) == (X + (Y + Z))
;  is an inductive theorem.
; Following equation
;    (Z + (X + Y)) == (X + (Y + Z))
;    is an inductive theorem in the current system.
PROVE
(X * (Y + Z)) == ((X * Y) + (X * Z))

; All subgoals are proved so 
; (X * (Y + Z)) == ((X * Y) + (X * Z))
;  is an inductive theorem.
; Following equation
;    (X * (Y + Z)) == ((X * Y) + (X * Z))
;    is an inductive theorem in the current system.
PROVE
(0 < X) == NOT((X = 0))

; All subgoals are proved so 
; (0 < X) == NOT((0 = X))
;  is an inductive theorem.
; Following equation
;    (0 < X) == NOT((0 = X))
;    is an inductive theorem in the current system.
PROVE
(X < SUC(0)) == (X = 0)

; All subgoals are proved so 
; (X < SUC(0)) == (0 = X)
;  is an inductive theorem.
; Following equation
;    (X < SUC(0)) == (0 = X)
;    is an inductive theorem in the current system.
PROVE
((X + Y) = 0) == COND((X = 0), (Y = 0), FALSE)

; All subgoals are proved so 
; ((X + Y) = 0) == FALSE  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    ((X + Y) = 0) == COND((0 = X), (0 = Y), FALSE)
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
((X * Y) = 0) == COND((X = 0), TRUE, (Y = 0))

; All subgoals are proved so 
; (0 * Y) == 0
;  is an inductive theorem.

; All subgoals are proved so 
; ((X * Y) = 0) == (0 = Y)  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    ((X * Y) = 0) == COND((0 = X), TRUE, (0 = Y))
;    is an inductive theorem in the current system.
PROVE
((X * Y) = X) == (Y = SUC(0)) if NOT((X = 0))

; All subgoals are proved so 
; ((X * Y) = X) == (SUC(0) = Y)  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    ((X * Y) = X) == (SUC(0) = Y)  if   { not((0 = X)) } 
;    is an inductive theorem in the current system.
PROVE
((X * Y) = X) == COND((Y = SUC(0)), TRUE, (X = 0))

; All subgoals are proved so 
; ((X * Y) = X) == (0 = X)  if   { not((SUC(0) = Y)) } 
;  is an inductive theorem.
; Following equation
;    ((X * Y) = X) == COND((SUC(0) = Y), TRUE, (0 = X))
;    is an inductive theorem in the current system.
PROVE
((X * Y) = SUC(0)) == COND((X = SUC(0)), (Y = SUC(0)), FALSE)

; All subgoals are proved so 
; ((X + Z) = SUC(0)) == FALSE  if  
;        { not((SUC(0) = Z)),
;          not((SUC(0) = X)) } 
;  is an inductive theorem.

; All subgoals are proved so 
; ((X * Y) = SUC(0)) == FALSE  if   { not((SUC(0) = X)) } 
;  is an inductive theorem.
; Following equation
;    ((X * Y) = SUC(0)) == COND((SUC(0) = X), (SUC(0) = Y), FALSE)
;    is an inductive theorem in the current system.
PROVE
(SUC(0) < Y) == TRUE if (NOT((Y = 0)) AND NOT((Y = SUC(0))))

; All subgoals are proved so 
; (SUC(0) < Y) == TRUE  if  
;        { not((0 = Y)),
;          not((SUC(0) = Y)) } 
;  is an inductive theorem.
; Following equation
;    (SUC(0) < Y) == TRUE  if  
;        { not((0 = Y)),
;          not((SUC(0) = Y)) } 
;    is an inductive theorem in the current system.
PROVE
(Y < SUC(Y))

; All subgoals are proved so 
; (Y < SUC(Y))
;  is an inductive theorem.
; Following equation
;    (Y < SUC(Y))
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
NOT((X < SUC(Y))) == TRUE if (Y < X)

; All subgoals are proved so 
; (X < SUC(Y)) == FALSE  if   { (Y < X) } 
;  is an inductive theorem.
; Following equation
;    NOT((X < SUC(Y))) == TRUE  if   { (Y < X) } 
;    is an inductive theorem in the current system.
PROVE
(SUC(X) < Y) == TRUE if ((X < Y) AND NOT((SUC(X) = Y)))

; All subgoals are proved so 
; (SUC(X) < Y) == TRUE  if  
;        { (X < Y),
;          not((SUC(X) = Y)) } 
;  is an inductive theorem.
; Following equation
;    (SUC(X) < Y) == TRUE  if  
;        { (X < Y),
;          not((SUC(X) = Y)) } 
;    is an inductive theorem in the current system.
PROVE
((U * Y) < SUC(Y)) == FALSE if (NOT((U = 0)) AND (NOT((U = SUC(0))) AND NOT((Y = 0))))

; All subgoals are proved so 
; (Z < Y) == FALSE  if   { not((Z < SUC(Y))) } 
;  is an inductive theorem.

; All subgoals are proved so 
; ((U + Z) < SUC(SUC(Y))) == FALSE  if  
;        { not((0 = U)),
;          not((Z < SUC(Y))),
;          not((SUC(0) = U)) } 
;  is an inductive theorem.

; All subgoals are proved so 
; ((U * Y) < SUC(Y)) == FALSE  if  
;        { not((0 = U)),
;          not((0 = Y)),
;          not((SUC(0) = U)) } 
;  is an inductive theorem.
; Following equation
;    ((U * Y) < SUC(Y)) == FALSE  if  
;        { not((0 = U)),
;          not((0 = Y)),
;          not((SUC(0) = U)) } 
;    is an inductive theorem in the current system.
WRITE
SPEC-WRITE
/USR/PROGRESS/ART/SPECS/PRIMES/NAT/NAT
Y
