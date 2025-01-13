OPTION
HISTORY
NO-HISTORY
ADD
      [0 : -> NAT ]
      [PERM : NATLIST, NATLIST -> BOOL ]
      [MEMBER : NAT, NATLIST -> BOOL ]
      [DELETE : NAT, NATLIST -> NATLIST ]
      [APPEND : NATLIST, NATLIST -> NATLIST ]
      [CONS : NAT, NATLIST -> NATLIST ]
      [NULL : -> NATLIST ]
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
APPEND(NULL, U) := U
APPEND(CONS(X, U), V) := CONS(X, APPEND(U, V))
DELETE(X, NULL) := NULL
DELETE(X, CONS(Y, U)) := COND((X = Y), U, CONS(Y, DELETE(X, U)))
MEMBER(X, NULL) := FALSE
MEMBER(X, CONS(Y, U)) := COND((X = Y), TRUE, MEMBER(X, U))
PERM(NULL, NULL) := true 
PERM(NULL, CONS(X, U)) := FALSE
PERM(CONS(X, U), NULL) := FALSE
PERM(CONS(X, U), V) := COND(MEMBER(X, V), PERM(U, DELETE(X, V)), FALSE)
]
OPERATOR
CONSTRUCTOR
0 
OPERATOR
CONSTRUCTOR
SUC 
YES
OPERATOR
CONSTRUCTOR
NULL 
OPERATOR
CONSTRUCTOR
CONS 
YES
OPERATOR
ACOPERATOR
+ 
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
PRECEDENCE
PERM DELETE 
OPERATOR
PRECEDENCE
PERM MEMBER 
OPERATOR
STATUS
*
RL
OPERATOR
STATUS
PERM
LR
MAKERULE
SUFFICE

; Note: the system may be not canonical.

; Specification of '+' is completely defined.

; Specification of '*' is completely defined.

; Specification of '-' is completely defined.

; Specification of '<' is completely defined.

; Specification of '>=' is completely defined.

; Specification of 'APPEND' is completely defined.

; Specification of 'DELETE' is completely defined.

; Specification of 'MEMBER' is completely defined.

; Specification of 'PERM' is completely defined.
OPTION
PROVE
E
COVER

; Specification of '+' is completely defined.

; Specification of '*' is completely defined.

; Specification of '-' is completely defined.

; Specification of '<' is completely defined.

; Specification of '>=' is completely defined.

; Specification of 'APPEND' is completely defined.

; Specification of 'DELETE' is completely defined.

; Specification of 'MEMBER' is completely defined.

; Specification of 'PERM' is completely defined.
ADD
(X + Y) == (Y + X)
((X + Y) + Z) == (X + (Y + Z))
(X * (Y + Z)) == ((X * Y) + (X * Z))
(0 < X) == NOT((X = 0))
(X < SUC(0)) == (X = 0)
((X + Y) = 0) == COND((X = 0), (Y = 0), FALSE)
((X + Y) = Y) == (X = 0)
((X + Z) = (Y + Z)) == (X = Y)
((X * Y) = 0) == COND((X = 0), TRUE, (Y = 0))
((X * Y) = X) == (Y = SUC(0)) if NOT((X = 0))
((X * Y) = X) == COND((Y = SUC(0)), TRUE, (X = 0))
((X * Y) = SUC(0)) == COND((X = SUC(0)), (Y = SUC(0)), FALSE)
(SUC(0) < Y) == TRUE if (NOT((Y = 0)) AND NOT((Y = SUC(0))))
(Y < SUC(Y))
(0 >= U) == (U = 0)
NOT((X < SUC(Y))) == TRUE if (Y < X)
(SUC(X) < Y) == TRUE if ((X < Y) AND NOT((SUC(X) = Y)))
(SUC(X) < Y) == TRUE if ((X < Y) AND NOT((SUC(X) = Y)))
((U * Y) < SUC(Y)) == FALSE if (NOT((U = 0)) AND (NOT((U = SUC(0))) AND NOT((Y = 0))))
]
MAKERULE
PROVE
DELETE(X, U) == U if NOT(MEMBER(X, U))

; All subgoals are proved so 
; DELETE(X, U) == U  if   { not(MEMBER(X, U)) } 
;  is an inductive theorem.
; Following equation
;    DELETE(X, U) == U  if   { not(MEMBER(X, U)) } 
;    is an inductive theorem in the current system.
WRITE
SPEC-WRITE
/USR/PROGRESS/ART/SPECS/PRIMES/NATLIST/NATLIST
Y
