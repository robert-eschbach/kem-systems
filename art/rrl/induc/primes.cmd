PRIMES.RRLMR
INIT
ADD
APPEND(NULL, XNL1) == XNL1
APPEND(CONS(X, XNL1), XNL2) == CONS(X, APPEND(XNL1, XNL2))
DELETE(X, NULL) == NULL
DELETE(X, CONS(X, XNL1)) == XNL1
DELETE(X, CONS(Y, XNL1)) == CONS(Y, DELETE(X, XNL1)) if NOT((Y = X))
MEMBER(X, NULL) == FALSE
MEMBER(X, CONS(X, XNL1))
MEMBER(X, CONS(Y, XNL1)) == MEMBER(X, XNL1) if NOT((X = Y))
PERM(NULL, NULL)
PERM(NULL, CONS(X, XNL1)) == FALSE
PERM(CONS(X, XNL1), NULL) == FALSE
PERM(CONS(X, XNL1), XNL2) == (MEMBER(X, XNL1) AND PERM(XNL1, DELETE(X, XNL2)))
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
REM(YNA, YNA) == 0
REM(SUCC((YNA + XNA)), YNA) == REM(SUCC(XNA), YNA)
DIV(YNA, YNA) == SUCC(0) if NOT((0 = YNA))
PRIME(0) == FALSE
PRIME(SUCC(X)) == PRIME1(SUCC(X), X)
PRIMELIST(NULL)
PRIMELIST(CONS(X, XNL)) == (PRIME(X) AND PRIMELIST(XNL))
TIMELIST(NULL) == SUCC(0)
TIMELIST(CONS(X, XNL)) == (X * TIMELIST(XNL))
PRIMEFAC(0) == NULL
PRIMEFAC(SUCC(0)) == NULL
PRIMEFAC((X * Y)) == APPEND(PRIMEFAC(X), PRIMEFAC(Y)) if (NOT((X = 0)) AND NOT((Y = 0)))
PRIME1(X, 0) == FALSE
PRIME1(X, SUCC(0))
PRIME1(X, SUCC(Y)) == (NOT(DIVIDES(SUCC(Y), X)) AND PRIME1(X, Y)) if NOT((Y = 0))
((UN * YN) < SUCC(YN)) == FALSE if (((0 = UN) EQU FALSE) AND (((SUCC(0) = UN) EQU FALSE) AND ((0 = YN) EQU FALSE)))
((UN + ZN) < SUCC(SUCC(YN))) == FALSE if (((0 = UN) EQU FALSE) AND (((SUCC(0) = UN) EQU FALSE) AND ((ZN < SUCC(YN)) EQU FALSE)))
((UN + XN) < SUCC(YN)) == FALSE if ((((UN + XN) < SUCC(SUCC(YN))) EQU FALSE) AND (((XN < YN) EQU FALSE) AND (((SUCC(0) = UN) EQU FALSE) AND ((0 = UN) EQU FALSE))))
((UN + XN) < SUCC(YN)) == FALSE if ((XN < SUCC(YN)) AND (((XN < YN) EQU FALSE) AND (((SUCC(0) = UN) EQU FALSE) AND ((0 = UN) EQU FALSE))))
(UN < SUCC(SUCC(0))) == FALSE if (((SUCC(0) = UN) EQU FALSE) AND ((0 = UN) EQU FALSE))
(UN >= ZN) == (TRUE XOR (UN < ZN))
(SUCC(XN) < ZN) == (XN < ZN) if ((SUCC(XN) = ZN) EQU FALSE)
(TRUE XOR (UN < UN))
(0 >= UN) == (0 = UN)
((XN * YN) = SUCC(0)) == FALSE if ((SUCC(0) = XN) EQU FALSE)
((XN + ZN) = SUCC(0)) == FALSE if (((SUCC(0) = XN) EQU FALSE) AND ((SUCC(0) = ZN) EQU FALSE))
((XN * YN) = XN) == (((0 = XN) XOR (SUCC(0) = YN)) XOR ((0 = XN) AND (SUCC(0) = YN)))
((XN * YN) = XN) == (SUCC(0) = YN) if ((0 = XN) EQU FALSE)
((XN * YN) = 0) == (((0 = XN) XOR (0 = YN)) XOR ((0 = XN) AND (0 = YN)))
((YN + ZN) = (XN + ZN)) == (YN = XN)
((XN + YN) = YN) == (0 = XN)
((XN + YN) = 0) == FALSE if ((0 = XN) EQU FALSE)
(XN < SUCC(0)) == (0 = XN)
(0 < XN) == (TRUE XOR (0 = XN))
(XN + (ZN + Z1)) == (ZN + (XN + Z1))
(SUCC(YN) + XN) == SUCC((YN + XN))
(0 + XN) == XN
((UN * YN) < SUCC(YN)) == FALSE if (NOT((UN = 0)) AND (NOT((UN = SUCC(0))) AND NOT((YN = 0))))
(UN >= ZN) == NOT((UN < ZN))
(SUCC(XN) < YN) == TRUE if ((XN < YN) AND NOT((SUCC(XN) = YN)))
(SUCC(XN) < YN) == TRUE if (((SUCC(XN) = YN) EQU FALSE) AND (XN < YN))
(0 >= UN) == (UN = 0)
(YN < SUCC(YN))
((XN * YN) = SUCC(0)) == ((XN = SUCC(0)) AND (YN = SUCC(0)))
((XN * YN) = XN) == ((YN = SUCC(0)) OR (XN = 0))
((XN * YN) = XN) == (YN = SUCC(0)) if NOT((XN = 0))
((XN * YN) = 0) == ((XN = 0) OR (YN = 0))
((XN + ZN) = (YN + ZN)) == (XN = YN)
((XN + YN) = YN) == (XN = 0)
((XN + YN) = 0) == ((XN = 0) AND (YN = 0))
(XN < SUCC(0)) == (XN = 0)
(0 < XN) == NOT((XN = 0))
(XN * (YN + ZN)) == ((XN * YN) + (XN * ZN))
(XN + YN) == (YN + XN)
REM(Y, Y) == 0
REM(SUCC((Y + X)), Y) == REM(SUCC(X), Y)
DIV(Y, Y) == SUCC(0) if NOT((0 = Y))
GCD(XNA, SUCC(0)) == SUCC(0) if ((0 = XNA) EQU FALSE)
(SUB1(XNA) < YNA) == (XNA < SUCC(YNA)) if ((0 = XNA) EQU FALSE)
REM(SUCC(0), XNA) == SUCC(0) if ((SUCC(0) = XNA) EQU FALSE)
DIV((YNA + (XNA * ZNA)), XNA) == (ZNA + DIV(YNA, XNA)) if ((0 = XNA) EQU FALSE)
(DIV(XNA, YNA) < XNA) == TRUE if (((0 = XNA) EQU FALSE) AND (((0 = YNA) EQU FALSE) AND ((SUCC(0) = YNA) EQU FALSE)))
(SUCC(ZNA) < (XNA + YNA)) == TRUE if (((0 = YNA) EQU FALSE) AND (((SUCC(0) = YNA) EQU FALSE) AND (ZNA < XNA)))
REM((XNA + (ZNA * Z1N)), ZNA) == REM(XNA, ZNA)
REM((XNA * YNA), XNA) == 0
DIV((XNA * YNA), XNA) == YNA if ((0 = XNA) EQU FALSE)
(XNA * (YNA * ZNA)) == (ZNA * (XNA * YNA))
(SUCC(YNA) * XNA) == (XNA + (YNA * XNA))
(0 * XNA) == 0
((YNA * DIV(XNA, YNA)) + REM(XNA, YNA)) == XNA
(YNA * DIV((XNA + YNA), YNA)) == (YNA + (YNA * DIV(XNA, YNA)))
(SUCC(SUCC((XNA + YNA))) < YNA) == FALSE if (((XNA + YNA) < YNA) AND (XNA < YNA))
(SUCC(XNA) < XNA) == FALSE
(GCD(XNA, YNA) = XNA) == FALSE if NOT((REM(YNA, XNA) = 0))
REM(XNA, GCD(XNA, YNA)) == 0
GCD(XNA, SUCC(0)) == SUCC(0) if NOT((XNA = 0))
(REM((YNA * ZNA), XNA) = 0) == FALSE if ((GCD((XNA * YNA), (YNA * ZNA)) = YNA) AND (NOT((YNA = 0)) AND NOT((REM(YNA, XNA) = 0))))
(GCD((XNA * YNA), ZNA) = YNA) == FALSE if ((REM(ZNA, XNA) = 0) AND NOT((REM(YNA, XNA) = 0)))
GCD((XNA * ZNA), (YNA * ZNA)) == (ZNA * GCD(XNA, YNA))
GCD(XNA, YNA) == GCD(YNA, XNA)
(SUB1(XNA) < YNA) == (XNA < SUCC(YNA)) if NOT((XNA = 0))
REM(SUCC(0), XNA) == SUCC(0) if NOT((XNA = SUCC(0)))
DIV((ZNA * YNA), XNA) == (YNA * DIV(ZNA, XNA)) if (DIVIDES(XNA, ZNA) AND NOT((XNA = 0)))
DIV((ZNA + YNA), XNA) == (DIV(ZNA, XNA) + DIV(YNA, XNA)) if (DIVIDES(XNA, ZNA) AND NOT((XNA = 0)))
(DIV(XNA, YNA) < XNA) == TRUE if (NOT((XNA = 0)) AND (NOT((YNA = 0)) AND NOT((YNA = SUCC(0)))))
REM((XNA + YNA), ZNA) == REM(XNA, ZNA) if (REM(YNA, ZNA) = 0)
REM((YNA * ZNA), XNA) == 0 if ((REM(ZNA, XNA) = 0) AND NOT((XNA = 0)))
REM((YNA * XNA), XNA) == 0
DIV((XNA * YNA), XNA) == YNA if NOT((XNA = 0))
(XNA * (YNA * ZNA)) == ((XNA * YNA) * ZNA)
(XNA * YNA) == (YNA * XNA)
(YNA * DIV(XNA, YNA)) == XNA if DIVIDES(YNA, XNA)
(REM(XNA, YNA) + (YNA * DIV(XNA, YNA))) == XNA
(YNA * DIV((YNA + XNA), YNA)) == (YNA * SUCC(DIV(XNA, YNA)))
REM(0, YNA) == 0
DIV(0, YNA) == 0
]
OPERATOR
CONSTRUCTOR
NULL 
OPERATOR
CONSTRUCTOR
CONS 
YES
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
DIV * 
OPERATOR
PRECEDENCE
GCD * 
OPERATOR
STATUS
<
LR
MAKERULE
1 
1 
1 
1 
1 
1 
WRITE
ALL
PRIMES.SPEC
QUIT
