OPTION
HISTORY
NO-HISTORY
ADD
(X + 0) == X
(X + SUCC(Y)) == SUCC((X + Y))
(0 - X) == 0
(X - 0) == X
(SUCC(X) - SUCC(Y)) == (X - Y)
(X * 0) == 0
(X * SUCC(Y)) == (X + (X * Y))
(X < 0) == FALSE
(0 < SUCC(X))
(SUCC(X) < SUCC(Y)) == (X < Y)
(X >= X)
(0 >= SUCC(Y)) == FALSE
(SUCC(X) >= Y) == (X >= Y) if NOT((SUCC(X) = Y))
DIV(X, 0) == 0
DIV(X, Y) == 0 if (X < Y)
DIV((Y + X), Y) == SUCC(DIV(X, Y)) if NOT((0 = Y))
REM(X, 0) == X
REM(X, Y) == X if (X < Y)
REM((Y + X), Y) == REM(X, Y)
DIVIDES(X, Y) == (REM(Y, X) = 0)
GCD(X, 0) == X
GCD(0, Y) == Y
GCD((X + Y), Y) == GCD(X, Y)
GCD(X, (X + Y)) == GCD(X, Y)
SUB1(0) == 0
SUB1(SUCC(X)) == X
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
OPTION
PROVE
E
ADD
REM(Y, Y) == 0
REM(SUCC((Y + X)), Y) == REM(SUCC(X), Y)
DIV(Y, Y) == SUCC(0) if NOT((0 = Y))
]
MAKERULE
PROVE
DIV(0, Y) == 0
Y
Y
Y
Y
PROVE
DIV(0, Y) == 0
N
Y
PROVE
REM(0, Y) == 0
PROVE
(Y * DIV((Y + X), Y)) == (Y * SUCC(DIV(X, Y)))
PROVE
(REM(X, Y) + (Y * DIV(X, Y))) == X
PROVE
(Y * DIV(X, Y)) == X if DIVIDES(Y, X)
PROVE
(X * Y) == (Y * X)
PROVE
(X * (Y * Z)) == ((X * Y) * Z)
PROVE
DIV((X * Y), X) == Y if NOT((X = 0))
PROVE
REM((Y * X), X) == 0
PROVE
REM((Y * Z), X) == 0 if ((REM(Z, X) = 0) AND NOT((X = 0)))
PROVE
REM((X + Y), Z) == REM(X, Z) if (REM(Y, Z) = 0)
EXIT
PROVE
(DIV(X, Y) < X) == TRUE if (NOT((X = 0)) AND (NOT((Y = 0)) AND NOT((Y = SUCC(0)))))
N
EXIT
Y
ABORT
PROVE
Y
Y
EXIT
EXIT
Y
EXIT
Y
ABORT
PROVE
N
DIV((Z + Y), X) == (DIV(Z, X) + DIV(Y, X)) if (DIVIDES(X, Z) AND NOT((X = 0)))
EXIT
1 
PROVE
DIV((Z * Y), X) == (Y * DIV(Z, X)) if (DIVIDES(X, Z) AND NOT((X = 0)))
1 
PROVE
REM(SUCC(0), X) == SUCC(0) if NOT((X = SUCC(0)))
EXIT
QUIT
