
The arities of the operators are:
      [SUCC : NAT -> NAT ]
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
      [0 : -> NAT ]



The system has the following constructors:
     Type 'NAT': { 0, SUCC }

There are no equivalent operators.

Precedence relation now is: 
   * > + 
   >= > < 
   DIVIDES > REM 
   DIV > + * 
   SUB1 > < 
   GCD > * + 

Operators with status are:
   < with left-to-right status.
   * with right-to-left status.

Associative & commutative operator set = { *, + }

Commutative operator set = { GCD }

The arities of the operators are:
      [SUCC : NAT -> NAT ]
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
(X < SUCC(0)) ---> (0 = X)
((X + Y) = 0) ---> ((0 = X) AND (0 = Y))
((X + Y) = Y) ---> (0 = X)
((Y + Z) = (X + Z)) ---> (Y = X)
(Y < SUCC(Y)) ---> TRUE
(SUCC(X) < Y) ---> TRUE if 
        { (X < Y),
          not((SUCC(X) = Y)) } 
(U >= Z) ---> NOT((U < Z))
(0 < U) ---> NOT((0 = U))
REM(Y, Y) ---> 0
REM(SUCC((X + Y)), Y) ---> REM(SUCC(X), Y)
DIV(Y, Y) ---> SUCC(0) if  { not((0 = Y)) } 
DIV(0, Y) ---> 0
REM(0, Y) ---> 0
(X * (Y + Z)) ---> ((X * Y) + (X * Z))
((X * Y) = 0) ---> ((0 = X) OR (0 = Y))
((X * Y) = X) ---> ((0 = X) OR (SUCC(0) = Y))
((X * Y) = SUCC(0)) ---> ((SUCC(0) = X) AND (SUCC(0) = Y))
((U * Y) < SUCC(Y)) ---> FALSE if 
        { not((0 = U)),
          not((0 = Y)),
          not((SUCC(0) = U)) } 
(Y * DIV((X + Y), Y)) ---> (Y + (Y * DIV(X, Y)))
((Y * DIV(X, Y)) + REM(X, Y)) ---> X
(Y * DIV(X, Y)) ---> X if  { (REM(X, Y) = 0) } 
REM((Y * Z), X) ---> 0 if  { (REM(Z, X) = 0) } 
REM((X + Y), Z) ---> REM(X, Z) if  { (REM(Y, Z) = 0) } 
(SUCC(Z) < (X + Y)) ---> TRUE if 
        { (Z < X),
          not((0 = Y)) } 
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
(REM((Y * Z), X) = 0) ---> FALSE if 
        { (GCD((X * Y), (Y * Z)) = Y),
          not((REM(Y, X) = 0)) } 
GCD(X, SUCC(0)) ---> SUCC(0)
REM(X, GCD(X, Y)) ---> 0
(GCD(X, Y) = X) ---> FALSE if  { not((REM(Y, X) = 0)) } 
