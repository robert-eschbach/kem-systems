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
]
OPERATOR
CONSTRUCTOR
0 
OPERATOR
CONSTRUCTOR
SUC 
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
DIVIDES REM 
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
REM(Y, Y) == 0
REM(SUC((Y + X)), Y) == REM(SUC(X), Y)
DIV(Y, Y) == SUC(0) if NOT((0 = Y))
]
MAKERULE
PROVE
DIV(0, Y) == 0

; All subgoals are proved so 
; DIV(0, Y) == 0
;  is an inductive theorem.
; Following equation
;    DIV(0, Y) == 0
;    is an inductive theorem in the current system.
PROVE
REM(0, Y) == 0

; All subgoals are proved so 
; REM(0, Y) == 0
;  is an inductive theorem.
; Following equation
;    REM(0, Y) == 0
;    is an inductive theorem in the current system.
PROVE
(Y * DIV((Y + X), Y)) == (Y * SUC(DIV(X, Y)))

; All subgoals are proved so 
; (Y * DIV((X + Y), Y)) == (Y + (Y * DIV(X, Y)))
;  is an inductive theorem.
; Following equation
;    (Y * DIV((X + Y), Y)) == (Y * SUC(DIV(X, Y)))
;    is an inductive theorem in the current system.
PROVE
(REM(X, Y) + (Y * DIV(X, Y))) == X

; All subgoals are proved so 
; ((Y * DIV(X, Y)) + REM(X, Y)) == X
;  is an inductive theorem.
; Following equation
;    ((Y * DIV(X, Y)) + REM(X, Y)) == X
;    is an inductive theorem in the current system.
PROVE
(Y * DIV(X, Y)) == X if DIVIDES(Y, X)
; Following equation
;    (Y * DIV(X, Y)) == X  if   { DIVIDES(Y, X) } 
;    is an inductive theorem in the current system.
PROVE
DIV((X * Y), X) == Y if NOT((X = 0))

; All subgoals are proved so 
; DIV((X * Y), X) == Y  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    DIV((X * Y), X) == Y  if   { not((0 = X)) } 
;    is an inductive theorem in the current system.
PROVE
REM((Y * X), X) == 0
EXIT
EXIT
EXIT
Y

; All subgoals are proved so 
; REM((Y * X), X) == 0
;  is an inductive theorem.
; Following equation
;    REM((Y * X), X) == 0
;    is an inductive theorem in the current system.
PROVE
REM((Y * Z), X) == 0 if (DIVIDES(X, Z) AND NOT((X = 0)))
EXIT
EXIT
EXIT
EXIT

; All subgoals are proved so 
; REM((Z + (Y * X)), X) == 0  if  
;        { not((0 = X)),
;          (REM(Z, X) = 0) } 
;  is an inductive theorem.

; All subgoals are proved so 
; REM((Z + (Y * X)), X) == 0  if  
;        { not((0 = X)),
;          (REM(Z, X) = 0),
;          (REM(X1, X) = 0) } 
;  is an inductive theorem.

; All subgoals are proved so 
; REM((Y * Z), X) == 0  if  
;        { not((0 = X)),
;          (REM(Z, X) = 0) } 
;  is an inductive theorem.
; Following equation
;    REM((Y * Z), X) == 0  if  
;        { DIVIDES(X, Z),
;          not((0 = X)) } 
;    is an inductive theorem in the current system.
PROVE
REM((X + Y), Z) == REM(X, Z) if DIVIDES(Z, Y)

; All subgoals are proved so 
; (X + (0 * Z)) == X
;  is an inductive theorem.

; All subgoals are proved so 
; REM((SUC(X) * Z), SUC(X)) == 0
;  is an inductive theorem.
EXIT

; All subgoals are proved so 
; REM((X + Y), Z) == REM(X, Z)  if   { (REM(Y, Z) = 0) } 
;  is an inductive theorem.
; Following equation
;    REM((X + Y), Z) == REM(X, Z)  if   { DIVIDES(Z, Y) } 
;    is an inductive theorem in the current system.
PROVE
(DIV(X, Y) < X) == TRUE if (NOT((X = 0)) AND (NOT((Y = 0)) AND NOT((Y = SUC(0)))))
N

; All subgoals are proved so 
; (SUC(Z) < (X + Y)) == TRUE  if  
;        { (Z < X),
;          not((0 = Y)),
;          not((SUC(0) = Y)) } 
;  is an inductive theorem.

; All subgoals are proved so 
; (DIV(X, Y) < X) == TRUE  if  
;        { not((0 = X)),
;          not((0 = Y)),
;          not((SUC(0) = Y)) } 
;  is an inductive theorem.
; Following equation
;    (DIV(X, Y) < X) == TRUE  if  
;        { not((0 = X)),
;          not((0 = Y)),
;          not((SUC(0) = Y)) } 
;    is an inductive theorem in the current system.
PROVE
DIV((Z + Y), X) == (DIV(Z, X) + DIV(Y, X)) if (DIVIDES(X, Z) AND NOT((X = 0)))

; All subgoals are proved so 
; DIV((Y + (X * Z)), X) == (Z + DIV(Y, X))  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    DIV((Y + Z), X) == (DIV(Y, X) + DIV(Z, X))  if  
;        { DIVIDES(X, Z),
;          not((0 = X)) } 
;    is an inductive theorem in the current system.
1 
PROVE
DIV((Z * Y), X) == (Y * DIV(Z, X)) if (DIVIDES(X, Z) AND NOT((X = 0)))

; All subgoals are proved so 
; DIV((0 * Y), X) == 0  if   { not((0 = X)) } 
;  is an inductive theorem.
EXIT
EXIT

; All subgoals are proved so 
; DIV(((X + X1) * Y), X) == (Y + DIV((X1 * Y), X))  if  
;        { not((0 = X)),
;          (REM(X1, X) = 0) } 
;  is an inductive theorem.

; All subgoals are proved so 
; DIV((Z * Y), X) == (Y * DIV(Z, X))  if  
;        { not((0 = X)),
;          (REM(Z, X) = 0) } 
;  is an inductive theorem.
; Following equation
;    DIV((Z * Y), X) == (Y * DIV(Z, X))  if  
;        { DIVIDES(X, Z),
;          not((0 = X)) } 
;    is an inductive theorem in the current system.
1 
PROVE
REM(SUC(0), X) == SUC(0) if NOT((X = SUC(0)))

; All subgoals are proved so 
; REM(SUC(0), X) == SUC(0)  if   { not((SUC(0) = X)) } 
;  is an inductive theorem.
; Following equation
;    REM(SUC(0), X) == SUC(0)  if   { not((SUC(0) = X)) } 
;    is an inductive theorem in the current system.
PROVE
(SUB1(X) < Y) == (X < SUC(Y)) if NOT((X = 0))

; All subgoals are proved so 
; (SUB1(X) < Y) == (X < SUC(Y))  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    (SUB1(X) < Y) == (X < SUC(Y))  if   { not((0 = X)) } 
;    is an inductive theorem in the current system.
1 
STATUS
<
LR
PROVE
GCD(X, Y) == GCD(Y, X)

; All subgoals are proved so 
; GCD(X, Y) == GCD(Y, X)
;  is an inductive theorem.
; Following equation
;    GCD(X, Y) == GCD(Y, X)
;    is an inductive theorem in the current system.
PROVE
GCD((X * Z), (Y * Z)) == (Z * GCD(X, Y))

; All subgoals are proved so 
; (0 * X) == 0
;  is an inductive theorem.

; All subgoals are proved so 
; (0 * GCD(X, Y)) == 0
;  is an inductive theorem.
EXIT
EXIT
Y

; All subgoals are proved so 
; (SUC(Y) * X) == (X + (Y * X))
;  is an inductive theorem.

; All subgoals are proved so 
; (X * Z) == (Z * X)
;  is an inductive theorem.

; All subgoals are proved so 
; GCD((X * Z), (Y * Z)) == (Z * GCD(X, Y))
;  is an inductive theorem.
; Following equation
;    GCD((X * Z), (Y * Z)) == (Z * GCD(X, Y))
;    is an inductive theorem in the current system.
1 
PROVE
(GCD((X * Y), Z) = Y) == FALSE if ((REM(Z, X) = 0) AND NOT((REM(Y, X) = 0)))
; Following equation
;    (GCD(Z, (X * Y)) = Y) == FALSE  if  
;        { (REM(Z, X) = 0),
;          not((REM(Y, X) = 0)) } 
;    is an inductive theorem in the current system.
PROVE
(REM((Y * Z), X) = 0) == FALSE if ((GCD((X * Y), (Y * Z)) = Y) AND (NOT((Y = 0)) AND NOT((REM(Y, X) = 0))))
Y

; Following equation 
;    (REM((Y1 * Z2), X3) = 0) == FALSE  if  
;        { (GCD((X3 * Y1), (Y1 * Z2)) = Y1),
;          not((REM(Y1, X3) = 0)) } 
; is an equational theorem in the system.
PROVE
GCD(X, SUC(0)) == SUC(0) if NOT((X = 0))

; All subgoals are proved so 
; GCD(X, SUC(0)) == SUC(0)  if   { not((0 = X)) } 
;  is an inductive theorem.
; Following equation
;    GCD(X, SUC(0)) == SUC(0)  if   { not((0 = X)) } 
;    is an inductive theorem in the current system.
PROVE
REM(X, GCD(X, Y)) == 0

; All subgoals are proved so 
; REM(X, GCD(X, Y)) == 0
;  is an inductive theorem.
; Following equation
;    REM(X, GCD(X, Y)) == 0
;    is an inductive theorem in the current system.
PROVE
(GCD(X, Y) = X) == FALSE if NOT((REM(Y, X) = 0))
Y

; Following equation 
;    (GCD(X1, Y2) = X1) == FALSE  if   { not((REM(Y2, X1) = 0)) } 
; is an equational theorem in the system.
WRITE
SPEC-WRITE
/USR/PROGRESS/ART/SPECS/PRIMES/ARITHMETIC/ARITHMETIC
Y
