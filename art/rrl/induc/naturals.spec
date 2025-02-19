
The arities of the operators are:
      [SUCC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
      [0 : -> NAT ]



The system has the following constructors:
     Type 'NAT': { 0, SUCC }

There are no equivalent operators.

Precedence relation now is: 
   * > + 
   >= > < 

Operators with status are:
   * with right-to-left status.

Associative & commutative operator set = { + }

The arities of the operators are:
      [SUCC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
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
(X * (Y + Z)) ---> ((X * Y) + (X * Z))
(X < SUCC(0)) ---> (0 = X)
((X + Y) = 0) ---> ((0 = X) AND (0 = Y))
((X + Y) = Y) ---> (0 = X)
((Y + Z) = (X + Z)) ---> (Y = X)
(0 * Y) ---> 0
((X * Y) = 0) ---> ((0 = X) OR (0 = Y))
((X * Y) = X) ---> ((0 = X) OR (SUCC(0) = Y))
((X + Z) = SUCC(0)) ---> FALSE if 
        { not((SUCC(0) = Z)),
          not((SUCC(0) = X)) } 
((X * Y) = SUCC(0)) ---> ((SUCC(0) = X) AND (SUCC(0) = Y))
(Y < SUCC(Y)) ---> TRUE
(U < U) ---> FALSE
(SUCC(X) < Z) ---> (X < Z) if  { not((SUCC(X) = Z)) } 
(U >= Z) ---> NOT((U < Z))
(0 < U) ---> NOT((0 = U))
((U * Y) < SUCC(Y)) ---> FALSE if 
        { not((0 = U)),
          not((0 = Y)),
          not((SUCC(0) = U)) } 
