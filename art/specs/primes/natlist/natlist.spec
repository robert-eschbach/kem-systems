
The arities of the operators are:
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
      [0 : -> NAT ]



The system has the following constructors:
     Type 'NAT': { 0, SUC }
     Type 'NATLIST': { NULL, CONS }

There are no equivalent operators.

Precedence relation now is: 
   * > + 
   >= > < 
   PERM > DELETE MEMBER 

Operators with status are:
   PERM with left-to-right status.
   * with right-to-left status.

Associative & commutative operator set = { + }

The arities of the operators are:
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
      [0 : -> NAT ]



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
(0 >= U) ---> (0 = U)
(X < SUC(Y)) ---> FALSE if  { (Y < X) } 
(SUC(X) < Y) ---> TRUE if 
        { (X < Y),
          not((SUC(X) = Y)) } 
((U * Y) < SUC(Y)) ---> FALSE if 
        { not((0 = U)),
          not((0 = Y)),
          not((SUC(0) = U)) } 
DELETE(X, U) ---> U if  { not(MEMBER(X, U)) } 
