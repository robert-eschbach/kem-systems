
The arities of the operators are:
      [SUC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
      [0 : -> NAT ]



The system has the following constructors:
     Type 'NAT': { 0, SUC }

There are no equivalent operators.

Precedence relation now is: 
   * > + 
   >= > < 

Operators with status are:
   * with right-to-left status.

Associative & commutative operator set = { + }

The arities of the operators are:
      [SUC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
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
(X * (Y + Z)) ---> ((X * Y) + (X * Z))
(0 < X) ---> NOT((0 = X))
(X < SUC(0)) ---> (0 = X)
((X + Y) = 0) ---> COND((0 = X), (0 = Y), FALSE)
((X + Y) = Y) ---> (0 = X)
((Y + Z) = (X + Z)) ---> (Y = X)
(0 * Y) ---> 0
((X * Y) = 0) ---> COND((0 = X), TRUE, (0 = Y))
((X * Y) = X) ---> COND((SUC(0) = Y), TRUE, (0 = X))
((X + Z) = SUC(0)) ---> FALSE if 
        { not((SUC(0) = Z)),
          not((SUC(0) = X)) } 
((X * Y) = SUC(0)) ---> COND((SUC(0) = X), (SUC(0) = Y), FALSE)
(Y < SUC(Y)) ---> TRUE
(0 >= U) ---> (0 = U)
(X < SUC(Y)) ---> FALSE if  { (Y < X) } 
(SUC(X) < Y) ---> TRUE if 
        { (X < Y),
          not((SUC(X) = Y)) } 
(Z < Y) ---> FALSE if  { not((Z < SUC(Y))) } 
((U + Z) < SUC(SUC(Y))) ---> FALSE if 
        { not((0 = U)),
          not((Z < SUC(Y))) } 
((U * Y) < SUC(Y)) ---> FALSE if 
        { not((0 = U)),
          not((0 = Y)),
          not((SUC(0) = U)) } 
