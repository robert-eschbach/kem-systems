
The arities of the operators are:
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
      [DIV : NAT, NAT -> NAT ]
      [REM : NAT, NAT -> NAT ]
      [DIVIDES : NAT, NAT -> BOOL ]
      [GCD : NAT, NAT -> NAT ]
      [SUB1 : NAT -> NAT ]
      [SUCC : NAT -> NAT ]
      [NULL : -> NATLIST ]
      [CONS : NAT, NATLIST -> NATLIST ]
      [APPEND : NATLIST, NATLIST -> NATLIST ]
      [DELETE : NAT, NATLIST -> NATLIST ]
      [MEMBER : NAT, NATLIST -> BOOL ]
      [PERM : NATLIST, NATLIST -> BOOL ]
      [PRIME : NAT -> BOOL ]
      [PRIMELIST : NATLIST -> BOOL ]
      [PRIMEFAC : NAT -> NATLIST ]
      [PRIME1 : NAT, NAT -> BOOL ]
      [TIMELIST : NATLIST -> NAT ]
      [0 : -> NAT ]



The system has the following constructors:
     Type 'NAT': { 0, SUCC }
     Type 'NATLIST': { NULL, CONS }

There are no equivalent operators.

Precedence relation now is: 
   * > + 
   >= > < 
   DIVIDES > REM 
   GCD > * + 
   SUB1 > < 
   DIV > * + 
   PERM > MEMBER DELETE 
   PRIMELIST > PRIME PRIME1 REM 
   TIMELIST > * + 
   PRIMEFAC > APPEND 
   PRIME > PRIME1 REM 
   PRIME1 > REM 

Operators with status are:
   PERM with left-to-right status.
   < with left-to-right status.

Associative & commutative operator set = { *, + }

Commutative operator set = { GCD }

The arities of the operators are:
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
      [DIV : NAT, NAT -> NAT ]
      [REM : NAT, NAT -> NAT ]
      [DIVIDES : NAT, NAT -> BOOL ]
      [GCD : NAT, NAT -> NAT ]
      [SUB1 : NAT -> NAT ]
      [SUCC : NAT -> NAT ]
      [NULL : -> NATLIST ]
      [CONS : NAT, NATLIST -> NATLIST ]
      [APPEND : NATLIST, NATLIST -> NATLIST ]
      [DELETE : NAT, NATLIST -> NATLIST ]
      [MEMBER : NAT, NATLIST -> BOOL ]
      [PERM : NATLIST, NATLIST -> BOOL ]
      [PRIME : NAT -> BOOL ]
      [PRIMELIST : NATLIST -> BOOL ]
      [PRIMEFAC : NAT -> NATLIST ]
      [PRIME1 : NAT, NAT -> BOOL ]
      [TIMELIST : NATLIST -> NAT ]
      [0 : -> NAT ]



(X + 0) ---> X
(X + SUCC(Y)) ---> SUCC((X + Y))
(0 - X) ---> 0
(X - 0) ---> X
(SUCC(X) - SUCC(Y)) ---> (X - Y)
(X * 0) ---> 0
(X * SUCC(Y)) ---> (X + (X * Y))
(X < 0) ---> FALSE
(0 < SUCC(X)) ---> TRUE
(SUCC(X) < SUCC(Y)) ---> (X < Y)
(X >= X) ---> TRUE
(0 >= SUCC(Y)) ---> FALSE
(SUCC(X) >= Y) ---> (X >= Y) if  { not((SUCC(X) = Y)) } 
DIV(X, 0) ---> 0
DIV(X, Y) ---> 0 if  { (X < Y) } 
DIV((X + Y), Y) ---> SUCC(DIV(X, Y)) if  { not((0 = Y)) } 
REM(X, 0) ---> X
REM(X, Y) ---> X if  { (X < Y) } 
REM((X + Y), Y) ---> REM(X, Y)
DIVIDES(X, Y) ---> (REM(Y, X) = 0)
GCD(X, 0) ---> X
GCD(Y, (X + Y)) ---> GCD(X, Y)
SUB1(0) ---> 0
SUB1(SUCC(X)) ---> X
APPEND(NULL, XNL1) ---> XNL1
APPEND(CONS(X, XNL1), XNL2) ---> CONS(X, APPEND(XNL1, XNL2))
DELETE(X, NULL) ---> NULL
DELETE(X, CONS(X, XNL1)) ---> XNL1
DELETE(X, CONS(Y, XNL1)) ---> CONS(Y, DELETE(X, XNL1)) if  { not((Y = X)) } 
MEMBER(X, NULL) ---> FALSE
MEMBER(X, CONS(X, XNL1)) ---> TRUE
MEMBER(X, CONS(Y, XNL1)) ---> MEMBER(X, XNL1) if  { not((Y = X)) } 
PERM(NULL, NULL) ---> TRUE
PERM(NULL, CONS(X, XNL1)) ---> FALSE
PERM(CONS(X, XNL1), XNL2) ---> (MEMBER(X, XNL2) AND PERM(XNL1, DELETE(X, XNL2)))
PRIME(0) ---> FALSE
PRIME(SUCC(X)) ---> PRIME1(SUCC(X), X)
PRIMELIST(NULL) ---> TRUE
PRIMELIST(CONS(X, XNL)) ---> (PRIME(X) AND PRIMELIST(XNL))
TIMELIST(NULL) ---> SUCC(0)
TIMELIST(CONS(X, XNL)) ---> (X * TIMELIST(XNL))
PRIMEFAC(0) ---> NULL
PRIMEFAC(SUCC(0)) ---> NULL
PRIMEFAC((X * Y)) ---> APPEND(PRIMEFAC(X), PRIMEFAC(Y)) if 
        { not((0 = X)),
          not((0 = Y)) } 
PRIME1(X, 0) ---> FALSE
PRIME1(X, SUCC(0)) ---> TRUE
PRIME1(X, SUCC(Y)) ---> (PRIME1(X, Y) AND NOT((REM(X, SUCC(Y)) = 0))) if  { not((0 = Y)) } 
(X * (Y + Z)) ---> ((X * Y) + (X * Z))
(X < SUCC(0)) ---> (0 = X)
((X + Y) = 0) ---> ((0 = X) AND (0 = Y))
((X + Y) = Y) ---> (0 = X)
((Y + Z) = (X + Z)) ---> (Y = X)
((X * Y) = 0) ---> ((0 = X) OR (0 = Y))
((X * Y) = X) ---> ((0 = X) OR (SUCC(0) = Y))
((X * Y) = SUCC(0)) ---> ((SUCC(0) = X) AND (SUCC(0) = Y))
(Y < SUCC(Y)) ---> TRUE
(SUCC(X) < Y) ---> TRUE if 
        { (X < Y),
          not((SUCC(X) = Y)) } 
(U >= Z) ---> NOT((U < Z))
(0 < U) ---> NOT((0 = U))
((U * Y) < SUCC(Y)) ---> FALSE if 
        { not((0 = U)),
          not((0 = Y)),
          not((SUCC(0) = U)) } 
REM(Y, Y) ---> 0
REM(SUCC((X + Y)), Y) ---> REM(SUCC(X), Y)
DIV(Y, Y) ---> SUCC(0) if  { not((0 = Y)) } 
DIV(0, Y) ---> 0
REM(0, Y) ---> 0
(Y * DIV((X + Y), Y)) ---> (Y + (Y * DIV(X, Y)))
((Y * DIV(X, Y)) + REM(X, Y)) ---> X
(Y * DIV(X, Y)) ---> X if  { (REM(X, Y) = 0) } 
REM((Y * Z), X) ---> 0 if  { (REM(Z, X) = 0) } 
REM((X + Y), Z) ---> REM(X, Z) if  { (REM(Y, Z) = 0) } 
(DIV(X, Y) < X) ---> TRUE if 
        { not((0 = X)),
          not((SUCC(0) = Y)) } 
DIV((Y + Z), X) ---> (DIV(Y, X) + DIV(Z, X)) if  { (REM(Z, X) = 0) } 
DIV((Y * Z), X) ---> (Y * DIV(Z, X)) if  { (REM(Z, X) = 0) } 
REM(SUCC(0), X) ---> SUCC(0) if  { not((SUCC(0) = X)) } 
(SUB1(X) < Y) ---> (X < SUCC(Y)) if  { not((0 = X)) } 
GCD((X * Z), (Y * Z)) ---> (Z * GCD(X, Y))
(GCD(Z, (X * Y)) = Y) ---> FALSE if 
        { (REM(Z, X) = 0),
          not((REM(Y, X) = 0)) } 
GCD(X, SUCC(0)) ---> SUCC(0)
REM(X, GCD(X, Y)) ---> 0
