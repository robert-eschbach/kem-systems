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
      [SUCC : NAT -> NAT ]
      [SUB1 : NAT -> NAT ]
      [GCD : NAT, NAT -> NAT ]
      [DIVIDES : NAT, NAT -> BOOL ]
      [REM : NAT, NAT -> NAT ]
      [DIV : NAT, NAT -> NAT ]
      [>= : NAT, NAT -> BOOL ]
      [< : NAT, NAT -> BOOL ]
      [- : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
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
DIV(X, 0) := 0
DIV(X, Y) := 0 if (X < Y)
DIV((Y + X), Y) := SUCC(DIV(X, Y)) if NOT((0 = Y))
REM(X, 0) := X
REM(X, Y) := X if (X < Y)
REM((Y + X), Y) := REM(X, Y)
DIVIDES(X, Y) := (REM(Y, X) = 0)
GCD(X, 0) := X
GCD(0, Y) := Y
GCD((X + Y), Y) := GCD(X, Y)
GCD(X, (X + Y)) := GCD(X, Y)
SUB1(0) := 0
SUB1(SUCC(X)) := X
APPEND(NULL, XNL1) := XNL1
APPEND(CONS(X, XNL1), XNL2) := CONS(X, APPEND(XNL1, XNL2))
DELETE(X, NULL) := NULL
DELETE(X, CONS(X, XNL1)) := XNL1
DELETE(X, CONS(Y, XNL1)) := CONS(Y, DELETE(X, XNL1)) if NOT((Y = X))
MEMBER(X, NULL) := FALSE
MEMBER(X, CONS(X, XNL1)) := true 
MEMBER(X, CONS(Y, XNL1)) := MEMBER(X, XNL1) if NOT((X = Y))
PERM(NULL, NULL) := true 
PERM(NULL, CONS(X, XNL1)) := FALSE
PERM(CONS(X, XNL1), NULL) := FALSE
PERM(CONS(X, XNL1), XNL2) := (MEMBER(X, XNL2) AND PERM(XNL1, DELETE(X, XNL2)))
PRIME(0) := FALSE
PRIME(SUCC(X)) := PRIME1(SUCC(X), X)
PRIMELIST(NULL) := true 
PRIMELIST(CONS(X, XNL)) := (PRIME(X) AND PRIMELIST(XNL))
TIMELIST(NULL) := SUCC(0)
TIMELIST(CONS(X, XNL)) := (X * TIMELIST(XNL))
PRIMEFAC(0) := NULL
PRIMEFAC(SUCC(0)) := NULL
PRIMEFAC((X * Y)) := APPEND(PRIMEFAC(X), PRIMEFAC(Y)) if (NOT((X = 0)) AND NOT((Y = 0)))
PRIME1(X, 0) := FALSE
PRIME1(X, SUCC(0)) := true 
PRIME1(X, SUCC(Y)) := (NOT(DIVIDES(SUCC(Y), X)) AND PRIME1(X, Y)) if NOT((Y = 0))
]
OPERATOR
CONSTRUCTOR
0 
OPERATOR
CONSTRUCTOR
SUCC 
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
+ * 
OPERATOR
COMMUTATIVE
GCD 
OPERATOR
PRECEDENCE
* + 
OPERATOR
PRECEDENCE
>= < 
OPERATOR
PRECEDENCE
DIVIDES REM 
OPERATOR
PRECEDENCE
GCD * 
OPERATOR
PRECEDENCE
SUB1 < 
OPERATOR
PRECEDENCE
DIV * 
OPERATOR
PRECEDENCE
PERM MEMBER 
OPERATOR
PRECEDENCE
PERM DELETE 
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
*
OPERATOR
STATUS
<
LR
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

; Specification of 'DIV' is completely defined.

; Specification of 'REM' is completely defined.

; Specification of 'DIVIDES' is completely defined.

; Specification of 'GCD' is completely defined.

; Specification of 'SUB1' is completely defined.

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

; Specification of '+' is completely defined.

; Specification of '*' is completely defined.

; Specification of '-' is completely defined.

; Specification of '<' is completely defined.

; Specification of '>=' is completely defined.

; Specification of 'DIV' is completely defined.

; Specification of 'REM' is completely defined.

; Specification of 'DIVIDES' is completely defined.

; Specification of 'GCD' is completely defined.

; Specification of 'SUB1' is completely defined.

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
(X + Y) == (Y + X)
(X * (Y + Z)) == ((X * Y) + (X * Z))
(X < SUCC(0)) == (X = 0)
((X + Y) = 0) == ((X = 0) AND (Y = 0))
((X + Y) = Y) == (X = 0)
((X + Z) = (Y + Z)) == (X = Y)
((X * Y) = 0) == ((X = 0) OR (Y = 0))
((X * Y) = X) == (Y = SUCC(0)) if NOT((X = 0))
((X * Y) = X) == ((Y = SUCC(0)) OR (X = 0))
((X * Y) = SUCC(0)) == ((X = SUCC(0)) AND (Y = SUCC(0)))
(Y < SUCC(Y))
(0 >= U) == (U = 0)
(SUCC(X) < Y) == TRUE if ((X < Y) AND NOT((SUCC(X) = Y)))
(SUCC(X) < Y) == TRUE if ((X < Y) AND NOT((SUCC(X) = Y)))
(U >= Z) == NOT((U < Z))
((U * Y) < SUCC(Y)) == FALSE if (NOT((U = 0)) AND (NOT((U = SUCC(0))) AND NOT((Y = 0))))
REM(Y, Y) == 0
REM(SUCC((Y + X)), Y) == REM(SUCC(X), Y)
DIV(Y, Y) == SUCC(0) if NOT((0 = Y))
DIV(0, Y) == 0
REM(0, Y) == 0
(Y * DIV((Y + X), Y)) == (Y * SUCC(DIV(X, Y)))
(REM(X, Y) + (Y * DIV(X, Y))) == X
(Y * DIV(X, Y)) == X if DIVIDES(Y, X)
(X * Y) == (Y * X)
(X * (Y * Z)) == ((X * Y) * Z)
DIV((X * Y), X) == Y if NOT((X = 0))
REM((Y * X), X) == 0
REM((Y * Z), X) == 0 if ((REM(Z, X) = 0) AND NOT((X = 0)))
REM((X + Y), Z) == REM(X, Z) if (REM(Y, Z) = 0)
(DIV(X, Y) < X) == TRUE if (NOT((X = 0)) AND (NOT((Y = 0)) AND NOT((Y = SUCC(0)))))
DIV((Z + Y), X) == (DIV(Z, X) + DIV(Y, X)) if (DIVIDES(X, Z) AND NOT((X = 0)))
DIV((Z * Y), X) == (Y * DIV(Z, X)) if (DIVIDES(X, Z) AND NOT((X = 0)))
REM(SUCC(0), X) == SUCC(0) if NOT((X = SUCC(0)))
(SUB1(X) < Y) == (X < SUCC(Y)) if NOT((X = 0))
GCD(X, Y) == GCD(Y, X)
GCD((X * Z), (Y * Z)) == (Z * GCD(X, Y))
(GCD((X * Y), Z) = Y) == FALSE if ((REM(Z, X) = 0) AND NOT((REM(Y, X) = 0)))
(REM((Y * Z), X) = 0) == FALSE if ((GCD((X * Y), (Y * Z)) = Y) AND (NOT((Y = 0)) AND NOT((REM(Y, X) = 0))))
GCD(X, SUCC(0)) == SUCC(0) if NOT((X = 0))
REM(X, GCD(X, Y)) == 0
(GCD(X, Y) = X) == FALSE if NOT((REM(Y, X) = 0))
]
MAKERULE
PROVE
DIVIDES(X, TIMELIST(XNL)) == TRUE if MEMBER(X, XNL)
EXIT
Y

; All subgoals are proved so 
; REM(TIMELIST(XNL), X) == 0  if   { MEMBER(X, XNL) } 
;  is an inductive theorem.
; Following equation
;    DIVIDES(X, TIMELIST(XNL)) == TRUE  if   { MEMBER(X, XNL) } 
;    is an inductive theorem in the current system.
PROVE
(X = SUCC(0)) == FALSE if PRIME(X)
Y

; Following equation 
;    (SUCC(0) = X1) == FALSE  if   { PRIME(X1) } 
; is an equational theorem in the system.
PROVE
(X = 0) == FALSE if PRIME(X)
Y

; Following equation 
;    (0 = X1) == FALSE  if   { PRIME(X1) } 
; is an equational theorem in the system.
PROVE
PRIMELIST(DELETE(X, XNL)) == TRUE if PRIMELIST(XNL)

; All subgoals are proved so 
; PRIMELIST(DELETE(X, XNL)) == TRUE  if   { PRIMELIST(XNL) } 
;  is an inductive theorem.
; Following equation
;    PRIMELIST(DELETE(X, XNL)) == TRUE  if   { PRIMELIST(XNL) } 
;    is an inductive theorem in the current system.
PROVE
TIMELIST(DELETE(X, XNL)) == DIV(TIMELIST(XNL), X) if (NOT((X = 0)) AND MEMBER(X, XNL))
EXIT
Y

; All subgoals are proved so 
; TIMELIST(DELETE(X, XNL)) == DIV(TIMELIST(XNL), X)  if  
;        { MEMBER(X, XNL),
;          not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    TIMELIST(DELETE(X, XNL)) == DIV(TIMELIST(XNL), X)  if  
;        { MEMBER(X, XNL),
;          not((0 = X)) } 
;    is an inductive theorem in th