
The arities of the operators are:
      [DIV : NAT, NAT -> NAT ]
      [REM : NAT, NAT -> NAT ]
      [DIVIDES : NAT, NAT -> BOOL ]
      [GCD : NAT, NAT -> NAT ]
      [SUB1 : NAT -> NAT ]
      [SUC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
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
     Type 'NAT': { 0, SUC }
     Type 'NATLIST': { NULL, CONS }

There are no equivalent operators.

Precedence relation now is: 
   DIVIDES > REM 
   GCD > * + 
   DIV > * + 
   * > + 
   >= > < 
   PERM > DELETE MEMBER 
   PRIMELIST > PRIME PRIME1 REM 
   TIMELIST > * + DIV 
   PRIMEFAC > APPEND 
   PRIME > PRIME1 REM 
   PRIME1 > REM 

Operators with status are:
   PERM with left-to-right status.
   < with left-to-right status.

Associative & commutative operator set = { + }

Commutative operator set = { *, GCD }

The arities of the operators are:
      [DIV : NAT, NAT -> NAT ]
      [REM : NAT, NAT -> NAT ]
      [DIVIDES : NAT, NAT -> BOOL ]
      [GCD : NAT, NAT -> NAT ]
      [SUB1 : NAT -> NAT ]
      [SUC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
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



DIV(X, 0) ---> 0
DIV(X, Y) ---> 0 if  { (X < Y) } 
DIV((X + Y), Y) ---> SUC(DIV(X, Y)) if  { not((0 = Y)) } 
REM(X, 0) ---> X
REM(X, Y) ---> X if  { (X < Y) } 
REM((X + Y), Y) ---> REM(X, Y)
DIVIDES(X, Y) ---> (REM(Y, X) = 0)
GCD(X, 0) ---> X
GCD(Y, (X + Y)) ---> GCD(X, Y)
SUB1(0) ---> 0
SUB1(SUC(X)) ---> X
(X + 0) ---> X
(X + SUC(Y)) ---> SUC((X + Y))
(0 - X) ---> 0
(X - 0) ---> X
(SUC(X) - SUC(Y)) ---> (X - Y)
(X * 0) ---> 0
(X * SUC(Y)) ---> (X + (X * Y))
(X < 0) ---> FALSE
(0 < SUC(X)) ---> TRUE
(SUC(X) < SUC(Y)) ---> (X < Y)
(X >= X) ---> TRUE
(0 >= SUC(Y)) ---> FALSE
(SUC(X) >= Y) ---> (X >= Y) if  { not((SUC(X) = Y)) } 
APPEND(NULL, U) ---> U
APPEND(CONS(X, U), V) ---> CONS(X, APPEND(U, V))
DELETE(X, NULL) ---> NULL
DELETE(X, CONS(Y, U)) ---> COND((Y = X), U, CONS(Y, DELETE(X, U)))
MEMBER(X, NULL) ---> FALSE
MEMBER(X, CONS(Y, U)) ---> COND((Y = X), TRUE, MEMBER(X, U))
PERM(NULL, NULL) ---> TRUE
PERM(NULL, CONS(X, U)) ---> FALSE
PERM(CONS(X, U), V) ---> COND(MEMBER(X, V), PERM(U, DELETE(X, V)), FALSE)
PRIME(0) ---> FALSE
PRIME(SUC(X)) ---> PRIME1(SUC(X), X)
PRIMELIST(NULL) ---> TRUE
PRIMELIST(CONS(X, V)) ---> (PRIME(X) AND PRIMELIST(V))
TIMELIST(NULL) ---> SUC(0)
TIMELIST(CONS(X, V)) ---> (X * TIMELIST(V))
PRIMEFAC(0) ---> NULL
PRIMEFAC(SUC(0)) ---> NULL
PRIMEFAC((X * Y)) ---> APPEND(PRIMEFAC(X), PRIMEFAC(Y)) if 
        { not((0 = X)),
          not((0 = Y)) } 
PRIME1(X, 0) ---> FALSE
PRIME1(X, SUC(0)) ---> TRUE
PRIME1(X, SUC(Y)) ---> (PRIME1(X, Y) AND NOT((REM(X, SUC(Y)) = 0))) if  { not((0 = Y)) } 
REM(Y, Y) ---> 0
REM(SUC((X + Y)), Y) ---> REM(SUC(X), Y)
DIV(Y, Y) ---> SUC(0) if  { not((0 = Y)) } 
DIV(0, Y) ---> 0
REM(0, Y) ---> 0
(Y * DIV((X + Y), Y)) ---> (Y + (Y * DIV(X, Y)))
((Y * DIV(X, Y)) + REM(X, Y)) ---> X
(Y * DIV(X, Y)) ---> X if  { (REM(X, Y) = 0) } 
REM((Y * Z), X) ---> 0 if  { (REM(Z, X) = 0) } 
REM((X + Y), Z) ---> REM(X, Z) if  { (REM(Y, Z) = 0) } 
(DIV(X, Y) < X) ---> TRUE if 
        { not((0 = X)),
          not((0 = Y)),
          not((SUC(0) = Y)) } 
DIV((Y + Z), X) ---> (DIV(Y, X) + DIV(Z, X)) if  { (REM(Z, X) = 0) } 
DIV((Y * Z), X) ---> (Y * DIV(Z, X)) if  { (REM(Z, X) = 0) } 
REM(SUC(0), X) ---> SUC(0) if  { not((SUC(0) = X)) } 
(SUB1(X) < Y) ---> (X < SUC(Y)) if  { not((0 = X)) } 
GCD((X * Z), (Y * Z)) ---> (Z * GCD(X, Y))
(GCD(Z, (X * Y)) = Y) ---> FALSE if 
        { (REM(Z, X) = 0),
          not((REM(Y, X) = 0)) } 
GCD(X, SUC(0)) ---> SUC(0)
REM(X, GCD(X, Y)) ---> 0
(X * (Y + Z)) ---> ((X * Y) + (X * Z))
(0 < X) ---> NOT((0 = X))
(X < SUC(0)) ---> (0 = X)
((X + Y) = 0) ---> COND((0 = X), (0 = Y), FALSE)
((X + Y) = Y) ---> (0 = X)
((Y + Z) = (X + Z)) ---> (Y = X)
((X * Y) = 0) ---> COND((0 = X), TRUE, (0 = Y))
((X * Y) = X) ---> COND((SUC(0) = Y), TRUE, (0 = X))
((X * Y) = SUC(0)) ---> COND((SUC(0) = X), (SUC(0) = Y), FALSE)
(Y < SUC(Y)) ---> TRUE
(X < SUC(Y)) ---> FALSE if  { (Y < X) } 
((U * Y) < SUC(Y)) ---> FALSE if 
        { not((0 = U)),
          not((0 = Y)),
          not((SUC(0) = U)) } 
DELETE(X, U) ---> U if  { not(MEMBER(X, U)) } 
REM(TIMELIST(U), X) ---> 0 if  { MEMBER(X, U) } 
PRIMELIST(DELETE(X, U)) ---> TRUE if  { PRIMELIST(U) } 
TIMELIST(DELETE(X, U)) ---> DIV(TIMELIST(U), X) if 
        { not((0 = X)),
          MEMBER(X, U) } 
(TIMELIST(U) = 0) ---> FALSE if  { PRIMELIST(U) } 
PRIMELIST(APPEND(U, V)) ---> TRUE if 
        { PRIMELIST(U),
          PRIMELIST(V) } 
PRIME1((W * Z), Y) ---> FALSE if 
        { not((0 = Z)),
          (Y >= Z),
          not((SUC(0) = Z)) } 
(X >= Y) ---> NOT((X < Y))
(REM(X, Z) = 0) ---> FALSE if 
        { not((Z = X)),
          PRIME1(X, SUB1(X)),
          not((SUC(0) = Z)) } 
(REM(X, Y) = 0) ---> FALSE if 
        { PRIME(X),
          not((Y = X)),
          not((SUC(0) = Y)) } 
(REM(X, Y) = 0) ---> FALSE if 
        { PRIME(Y),
          PRIME(X),
          not((Y = X)) } 
GCD(X, Y) ---> SUC(0) if 
        { PRIME1(X, SUB1(X)),
          not((REM(Y, X) = 0)) } 
(REM((Y * Z), X) = 0) ---> FALSE if 
        { PRIME(X),
          not((REM(Y, X) = 0)),
          not((REM(Z, X) = 0)) } 
MEMBER(X, U) ---> TRUE if 
        { PRIME(X),
          PRIMELIST(U),
          (REM(TIMELIST(U), X) = 0) } 
TIMELIST(DELETE(X, U)) ---> DIV(TIMELIST(U), X) if 
        { PRIME(X),
          PRIMELIST(U),
          (REM(TIMELIST(U), X) = 0) } 
TIMELIST(PRIMEFAC(X)) ---> X if  { not((0 = X)) } 
PRIMELIST(PRIMEFAC(X)) ---> TRUE
PERM(U, V) ---> TRUE if 
        { PRIMELIST(U),
          PRIMELIST(V),
          (TIMELIST(V) = TIMELIST(U)) } 
(X < X) ---> FALSE
(SUC(X) < Y) ---> (X < Y) if  { not((SUC(X) = Y)) } 
