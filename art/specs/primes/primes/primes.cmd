OPTION
HISTORY
NO-HISTORY
ADD
      [0 : -> NAT ]
      [TIMELIST : NATLIST -> NAT ]
      [PRIME1 : NAT, NAT -> BOOL ]
      [PRIMEFAC : NAT -> NATLIST ]
      [PRIMELIST : NATLIST -> BOOL ]
      [PRIME : NAT -> BOOL ]
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
      [SUB1 : NAT -> NAT ]
      [GCD : NAT, NAT -> NAT ]
      [DIVIDES : NAT, NAT -> BOOL ]
      [REM : NAT, NAT -> NAT ]
      [DIV : NAT, NAT -> NAT ]
DIV(X, 0) := 0
DIV(X, Y) := 0 if (X < Y)
DIV((Y + X), Y) := SUC(DIV(X, Y)) if NOT((0 = Y))
REM(X, 0) := X
REM(X, Y) := X if (X < Y)
REM((Y + X), Y) := REM(X, Y)
DIVIDES(X, Y) := (REM(Y, X) = 0)
GCD(X, 0) := X
GCD(0, Y) := Y
GCD((X + Y), Y) := GCD(X, Y)
GCD(X, (X + Y)) := GCD(X, Y)
SUB1(0) := 0
SUB1(SUC(X)) := X
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
PRIME(0) := FALSE
PRIME(SUC(X)) := PRIME1(SUC(X), X)
PRIMELIST(NULL) := true 
PRIMELIST(CONS(X, V)) := (PRIME(X) AND PRIMELIST(V))
TIMELIST(NULL) := SUC(0)
TIMELIST(CONS(X, V)) := (X * TIMELIST(V))
PRIMEFAC(0) := NULL
PRIMEFAC(SUC(0)) := NULL
PRIMEFAC((X * Y)) := APPEND(PRIMEFAC(X), PRIMEFAC(Y)) if (NOT((X = 0)) AND NOT((Y = 0)))
PRIME1(X, 0) := FALSE
PRIME1(X, SUC(0)) := true 
PRIME1(X, SUC(Y)) := (NOT(DIVIDES(SUC(Y), X)) AND PRIME1(X, Y)) if NOT((Y = 0))
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
OPERATOR
COMMUTATIVE
GCD * 
OPERATOR
PRECEDENCE
DIVIDES REM 
OPERATOR
PRECEDENCE
GCD * 
OPERATOR
PRECEDENCE
DIV * 
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
PRECEDENCE
PRIMELIST PRIME 
OPERATOR
PRECEDENCE
TIMELIST * 
OPERATOR
PRECEDENCE
PRIMEFAC APPEND 
OPERATOR
PRECEDENCE
PRIME PRIME1 
OPERATOR
PRECEDENCE
PRIME1 REM 
OPERATOR
STATUS
<
LR
OPERATOR
STATUS
*
OPERATOR
STATUS
PERM
LR
MAKERULE
SUFFICE

; Note: the system may be not canonical.

; Specification of 'DIV' is completely defined.

; Specification of 'REM' is completely defined.

; Specification of 'DIVIDES' is completely defined.

; Specification of 'GCD' is completely defined.

; Specification of 'SUB1' is completely defined.

; Specification of '+' is completely defined.

; Specification of '*' is completely defined.

; Specification of '-' is completely defined.

; Specification of '<' is completely defined.

; Specification of '>=' is completely defined.

; Specification of 'APPEND' is completely defined.

; Specification of 'DELETE' is completely defined.

; Specification of 'MEMBER' is completely defined.

; Specification of 'PERM' is completely defined.

; Specification of 'PRIME' is completely defined.

; Specification of 'PRIMELIST' is completely defined.

; Specification of 'PRIMEFAC' is completely defined.

; Specification of 'PRIME1' is completely defined.

; Specification of 'TIMELIST' is completely defined.
OPTION
PROVE
E
COVER

; Specification of 'DIV' is completely defined.

; Specification of 'REM' is completely defined.

; Specification of 'DIVIDES' is completely defined.

; Specification of 'GCD' is completely defined.

; Specification of 'SUB1' is completely defined.

; Specification of '+' is completely defined.

; Specification of '*' is completely defined.

; Specification of '-' is completely defined.

; Specification of '<' is completely defined.

; Specification of '>=' is completely defined.

; Specification of 'APPEND' is completely defined.

; Specification of 'DELETE' is completely defined.

; Specification of 'MEMBER' is completely defined.

; Specification of 'PERM' is completely defined.

; Specification of 'PRIME' is completely defined.

; Specification of 'PRIMELIST' is completely defined.

; Specification of 'PRIMEFAC' is completely defined.

; Specification of 'PRIME1' is completely defined.

; Specification of 'TIMELIST' is completely defined.
ADD
REM(Y, Y) == 0
REM(SUC((Y + X)), Y) == REM(SUC(X), Y)
DIV(Y, Y) == SUC(0) if NOT((0 = Y))
DIV(0, Y) == 0
REM(0, Y) == 0
(Y * DIV((Y + X), Y)) == (Y * SUC(DIV(X, Y)))
(REM(X, Y) + (Y * DIV(X, Y))) == X
(Y * DIV(X, Y)) == X if DIVIDES(Y, X)
DIV((X * Y), X) == Y if NOT((X = 0))
REM((Y * X), X) == 0
REM((Y * Z), X) == 0 if (DIVIDES(X, Z) AND NOT((X = 0)))
REM((X + Y), Z) == REM(X, Z) if DIVIDES(Z, Y)
(DIV(X, Y) < X) == TRUE if (NOT((X = 0)) AND (NOT((Y = 0)) AND NOT((Y = SUC(0)))))
DIV((Z + Y), X) == (DIV(Z, X) + DIV(Y, X)) if (DIVIDES(X, Z) AND NOT((X = 0)))
DIV((Z * Y), X) == (Y * DIV(Z, X)) if (DIVIDES(X, Z) AND NOT((X = 0)))
REM(SUC(0), X) == SUC(0) if NOT((X = SUC(0)))
(SUB1(X) < Y) == (X < SUC(Y)) if NOT((X = 0))
GCD(X, Y) == GCD(Y, X)
GCD((X * Z), (Y * Z)) == (Z * GCD(X, Y))
(GCD((X * Y), Z) = Y) == FALSE if ((REM(Z, X) = 0) AND NOT((REM(Y, X) = 0)))
(REM((Y * Z), X) = 0) == FALSE if ((GCD((X * Y), (Y * Z)) = Y) AND (NOT((Y = 0)) AND NOT((REM(Y, X) = 0))))
GCD(X, SUC(0)) == SUC(0) if NOT((X = 0))
REM(X, GCD(X, Y)) == 0
(GCD(X, Y) = X) == FALSE if NOT((REM(Y, X) = 0))
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
DELETE(X, U) == U if NOT(MEMBER(X, U))
]
MAKERULE
PROVE
DIVIDES(X, TIMELIST(U)) == TRUE if MEMBER(X, U)

; All subgoals are proved so 
; REM(TIMELIST(U), X) == 0  if   { MEMBER(X, U) } 
;  is an inductive theorem.
; Following equation
;    DIVIDES(X, TIMELIST(U)) == TRUE  if   { MEMBER(X, U) } 
;    is an inductive theorem in the current system.
PROVE
PRIMELIST(DELETE(X, U)) == TRUE if PRIMELIST(U)

; All subgoals are proved so 
; PRIMELIST(DELETE(X, U)) == TRUE  if   { PRIMELIST(U) } 
;  is an inductive theorem.
; Following equation
;    PRIMELIST(DELETE(X, U)) == TRUE  if   { PRIMELIST(U) } 
;    is an inductive theorem in the current system.
PROVE
(X = SUC(0)) == FALSE if PRIME(X)
Y

; Following equation 
;    (SUC(0) = X1) == FALSE  if   { PRIME(X1) } 
; is an equational theorem in the system.
PROVE
(X = 0) == FALSE if PRIME(X)
Y

; Following equation 
;    (0 = X1) == FALSE  if   { PRIME(X1) } 
; is an equational theorem in the system.
PROVE
TIMELIST(DELETE(X, U)) == DIV(TIMELIST(U), X) if (NOT((X = 0)) AND MEMBER(X, U))

; All subgoals are proved so 
; TIMELIST(DELETE(X, U)) == DIV(TIMELIST(U), X)  if  
;        { MEMBER(X, U),
;          not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    TIMELIST(DELETE(X, U)) == DIV(TIMELIST(U), X)  if  
;        { MEMBER(X, U),
;          not((0 = X)) } 
;    is an inductive theorem in the current system.
1 
PROVE
(TIMELIST(U) = 0) == FALSE if PRIMELIST(U)

; All subgoals are proved so 
; (TIMELIST(U) = 0) == FALSE  if   { PRIMELIST(U) } 
;  is an inductive theorem.
; Following equation
;    (TIMELIST(U) = 0) == FALSE  if   { PRIMELIST(U) } 
;    is an inductive theorem in the current system.
PROVE
PRIMELIST(APPEND(U, V)) == TRUE if (PRIMELIST(U) AND PRIMELIST(V))

; All subgoals are proved so 
; PRIMELIST(APPEND(U, V)) == TRUE  if  
;        { PRIMELIST(U),
;          PRIMELIST(V) } 
;  is an inductive theorem.
; Following equation
;    PRIMELIST(APPEND(U, V)) == TRUE  if  
;        { PRIMELIST(U),
;          PRIMELIST(V) } 
;    is an inductive theorem in the current system.
PROVE
PRIME1((W * Z), Y) == FALSE if (NOT((Z = SUC(0))) AND (NOT((Z = 0)) AND ((Y >= Z) AND NOT((Y = SUC(0))))))
EXIT
EXIT
Y

; All subgoals are proved so 
; PRIME1((W * Z), Y) == FALSE  if  
;        { (Y >= Z),
;          not((0 = Z)),
;          not((SUC(0) = Y)),
;          not((SUC(0) = Z)) } 
;  is an inductive theorem.
; Following equation
;    PRIME1((W * Z), Y) == FALSE  if  
;        { (Y >= Z),
;          not((0 = Z)),
;          not((SUC(0) = Y)),
;          not((SUC(0) = Z)) } 
;    is an inductive theorem in the current system.
PROVE
(X >= Y) == NOT((X < Y))

; All subgoals are proved so 
; NOT((X < X))
;  is an inductive theorem.

; All subgoals are proved so 
; (SUC(X) < Y) == (X < Y)  if   { not((SUC(X) = Y)) } 
;  is an inductive theorem.

; All subgoals are proved so 
; (X >= Y) == NOT((X < Y))
;  is an inductive theorem.
; Following equation
;    (X >= Y) == NOT((X < Y))
;    is an inductive theorem in the current system.
PROVE
NOT(DIVIDES(Z, X)) == TRUE if (PRIME1(X, SUB1(X)) AND (NOT((Z = SUC(0))) AND (NOT((Z = X)) AND (NOT((X = 0)) AND NOT((X = SUC(0)))))))
EXIT
Y
EXIT
EXIT
EXIT
EXIT
Y

; All subgoals are proved so 
; (REM(X, Z) = 0) == FALSE  if  
;        { not((Z = X)),
;          not((0 = X)),
;          PRIME1(X, SUB1(X)),
;          not((SUC(0) = X)),
;          not((SUC(0) = Z)) } 
;  is an inductive theorem.
; Following equation
;    NOT(DIVIDES(Z, X)) == TRUE  if  
;        { PRIME1(X, SUB1(X)),
;          not((Z = X)),
;          not((0 = X)),
;          not((SUC(0) = X)),
;          not((SUC(0) = Z)) } 
;    is an inductive theorem in the current system.
PROVE
(REM(X, Y) = 0) == FALSE if (PRIME(X) AND (NOT((Y = SUC(0))) AND NOT((X = Y))))

; All subgoals are proved so 
; (REM(X, Y) = 0) == FALSE  if  
;        { PRIME(X),
;          not((Y = X)),
;          not((SUC(0) = Y)) } 
;  is an inductive theorem.
; Following equation
;    (REM(X, Y) = 0) == FALSE  if  
;        { PRIME(X),
;          not((Y = X)),
;          not((SUC(0) = Y)) } 
;    is an inductive theorem in the current system.
PROVE
(REM(X, Y) = 0) == FALSE if (PRIME(Y) AND (PRIME(X) AND NOT((X = Y))))
Y

; Following equation 
;    (REM(X1, Y2) = 0) == FALSE  if  
;        { PRIME(X1),
;          PRIME(Y2),
;          not((Y2 = X1)) } 
; is an equational theorem in the system.
PROVE
GCD(X, Y) == SUC(0) if ((REM(X, GCD(X, Y)) = 0) AND (NOT((X = 0)) AND (NOT((X = SUC(0))) AND (PRIME1(X, SUB1(X)) AND NOT((GCD(X, Y) = X))))))
Y

; Following equation 
;    GCD(X1, Y2) == SUC(0)  if  
;        { (REM(X1, GCD(X1, Y2)) = 0),
;          PRIME1(X1, SUB1(X1)),
;          not((GCD(X1, Y2) = X1)) } 
; is an equational theorem in the system.
PROVE
(GCD(X, Y) = X) == FALSE if NOT((REM(Y, X) = 0))
Y

; Following equation 
;    (GCD(X1, Y2) = X1) == FALSE  if   { not((REM(Y2, X1) = 0)) } 
; is an equational theorem in the system.
PROVE
GCD(X, Y) == SUC(0) if (PRIME1(X, SUB1(X)) AND NOT((REM(Y, X) = 0)))
Y

; Following equation 
;    GCD(X1, Y2) == SUC(0)  if  
;        { PRIME1(X1, SUB1(X1)),
;          not((REM(Y2, X1) = 0)) } 
; is an equational theorem in the system.
PROVE
(REM((Y * Z), X) = 0) == FALSE if (PRIME(X) AND (NOT(DIVIDES(X, Y)) AND NOT(DIVIDES(X, Z))))
EXIT
Y

; All subgoals are proved so 
; (REM((Y * Z), X) = 0) == FALSE  if  
;        { PRIME(X),
;          not((REM(Y, X) = 0)),
;          not((REM(Z, X) = 0)) } 
;  is an inductive theorem.
; Following equation
;    (REM((Y * Z), X) = 0) == FALSE  if  
;        { PRIME(X),
;          not(DIVIDES(X, Y)),
;          not(DIVIDES(X, Z)) } 
;    is an inductive theorem in the current system.
PROVE
MEMBER(X, U) == TRUE if (PRIME(X) AND (PRIMELIST(U) AND DIVIDES(X, TIMELIST(U))))

; All subgoals are proved so 
; MEMBER(X, U) == TRUE  if  
;        { PRIME(X),
;          PRIMELIST(U),
;          (REM(TIMELIST(U), X) = 0) } 
;  is an inductive theorem.
; Following equation
;    MEMBER(X, U) == TRUE  if  
;        { PRIME(X),
;          PRIMELIST(U),
;          DIVIDES(X, TIMELIST(U)) } 
;    is an inductive theorem in the current system.
PROVE
TIMELIST(DELETE(X, U)) == DIV(TIMELIST(U), X) if (DIVIDES(X, TIMELIST(U)) AND (PRIME(X) AND PRIMELIST(U)))
Y

; Following equation 
;    TIMELIST(DELETE(X1, U2)) == DIV(TIMELIST(U2), X1)  if  
;        { PRIME(X1),
;          PRIMELIST(U2),
;          DIVIDES(X1, TIMELIST(U2)) } 
; is an equational theorem in the system.
PROVE
TIMELIST(PRIMEFAC(X)) == X if NOT((X = 0))
EXIT
EXIT
Y

; All subgoals are proved so 
; TIMELIST(PRIMEFAC(X)) == X  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    TIMELIST(PRIMEFAC(X)) == X  if   { not((0 = X)) } 
;    is an inductive theorem in the current system.
PROVE
PRIMELIST(PRIMEFAC(X)) == TRUE if NOT((X = 0))

; All subgoals are proved so 
; PRIMELIST(PRIMEFAC(X)) == TRUE  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    PRIMELIST(PRIMEFAC(X)) == TRUE  if   { not((0 = X)) } 
;    is an inductive theorem in the current system.
PROVE
PERM(U, V) == TRUE if (PRIMELIST(U) AND (PRIMELIST(V) AND (TIMELIST(U) = TIMELIST(V))))

; All subgoals are proved so 
; PERM(NULL, V) == TRUE  if  
;        { PRIMELIST(V),
;          (TIMELIST(V) = SUC(0)) } 
;  is an inductive theorem.
EXIT
Y

; All subgoals are proved so 
; PERM(U, NULL) == TRUE  if  
;        { PRIMELIST(U),
;          (TIMELIST(U) = SUC(0)) } 
;  is an inductive theorem.
EXIT
Y

; All subgoals are proved so 
; PERM(U, V) == TRUE  if  
;        { PRIMELIST(U),
;          PRIMELIST(V),
;          (TIMELIST(V) = TIMELIST(U)) } 
;  is an inductive theorem.
; Following equation
;    PERM(U, V) == TRUE  if  
;        { PRIMELIST(U),
;          PRIMELIST(V),
;          (TIMELIST(V) = TIMELIST(U)) } 
;    is an inductive theorem in the current system.
WRITE
SPEC-WRITE
/USR/PROGRESS/ART/SPECS/PRIMES/PRIMES/PRIMES
Y
