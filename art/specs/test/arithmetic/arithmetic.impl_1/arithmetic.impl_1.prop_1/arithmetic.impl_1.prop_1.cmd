OPTION
HISTORY
NO-HISTORY
ADD
      [0 : -> NAT ]
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
]
OPERATOR
CONSTRUCTOR
0 
OPERATOR
CONSTRUCTOR
SUCC 
YES
OPERATOR
ACOPERATOR
+ * 
OPERATOR
COMMUTATIVE
GCD 
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
DIVIDES REM 
OPERATOR
PRECEDENCE
GCD * 
OPERATOR
PRECEDENCE
DIV * 
OPERATOR
STATUS
*
OPERATOR
STATUS
<
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
(Y * DIV((X + Y), Y)) == (Y + (Y * DIV(X, Y)))
((Y * DIV(X, Y)) + REM(X, Y)) == X
(0 * X) == 0
(SUCC(Y) * X) == (X + (Y * X))
(X * (Y * Z)) == (Z * (X * Y))
DIV((X * Y), X) == Y if NOT((0 = X))
REM((X * Y), X) == 0
(SUCC(Z) < (X + Y)) == TRUE if ((Z < X) AND (NOT((0 = Y)) AND NOT((SUCC(0) = Y))))
(DIV(X, Y) < X) == TRUE if (NOT((0 = X)) AND (NOT((0 = Y)) AND NOT((SUCC(0) = Y))))
DIV((Y + Z), X) == (DIV(Y, X) + DIV(Z, X)) if (NOT((0 = X)) AND (REM(Z, X) = 0))
REM(SUCC(0), X) == SUCC(0) if NOT((SUCC(0) = X))
(SUB1(X) < Y) == (X < SUCC(Y)) if NOT((0 = X))
GCD(X, SUCC(0)) == SUCC(0) if NOT((0 = X))
]
MAKERULE
WRITE
SPEC-WRITE
/USR/USERS/ESCHBACH/ART/SPECS/TEST/ARITHMETIC/ARITHMETIC.IMPL_1/ARITHMETIC.IMPL_1.PROP_1/ARITHMETIC.IMPL_1.PROP_1
