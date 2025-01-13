add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(x + 0) == x
(x + succ(y)) == succ((x + y))
(0 - x) == 0
(x - 0) == x
(succ(x) - succ(y)) == (x - y)
(x * 0) == 0
(x * succ(y)) == (x + (x * y))
(x < 0) == false
(0 < succ(x))
(succ(x) < succ(y)) == (x < y)
(x >= x)
(0 >= succ(y)) == false
(succ(x) >= y) == (x >= y) if not((succ(x) = y))
]
operator
constructor
0 
operator
constructor
succ 
yes
operator
acoperator
+ 
operator
order
l
operator
precedence
* + 
operator
precedence
>= < 
operator
status
*
rl
makerule
option
prove
e
cover
cover
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((un * yn) < succ(yn)) == false if (((0 = un) equ false) and (((succ(0) = un) equ false) and ((0 = yn) equ false)))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((un + zn) < succ(succ(yn))) == false if (((0 = un) equ false) and (((succ(0) = un) equ false) and ((zn < succ(yn)) equ false)))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((un + xn) < succ(yn)) == false if ((((un + xn) < succ(succ(yn))) equ false) and (((xn < yn) equ false) and (((succ(0) = un) equ false) and ((0 = un) equ false))))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((un + xn) < succ(yn)) == false if ((xn < succ(yn)) and (((xn < yn) equ false) and (((succ(0) = un) equ false) and ((0 = un) equ false))))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(un < succ(succ(0))) == false if (((succ(0) = un) equ false) and ((0 = un) equ false))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(un >= zn) == (true xor (un < zn))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(succ(xn) < zn) == (xn < zn) if ((succ(xn) = zn) equ false)
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(true xor (un < un))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(0 >= un) == (0 = un)
]
makerule
list
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn * yn) = succ(0)) == false if ((succ(0) = xn) equ false)
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn + zn) = succ(0)) == false if (((succ(0) = xn) equ false) and ((succ(0) = zn) equ false))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn * yn) = xn) == (((0 = xn) xor (succ(0) = yn)) xor ((0 = xn) and (succ(0) = yn)))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn * yn) = xn) == (succ(0) = yn) if ((0 = xn) equ false)
]
makerule
list
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn * yn) = 0) == (((0 = xn) xor (0 = yn)) xor ((0 = xn) and (0 = yn)))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((yn + zn) = (xn + zn)) == (yn = xn)
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn + yn) = yn) == (0 = xn)
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn + yn) = 0) == false if ((0 = xn) equ false)
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(xn < succ(0)) == (0 = xn)
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(xn < succ(0)) == (0 = xn)
]
makerule
list
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(0 < xn) == (true xor (0 = xn))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(xn + (zn + z1)) == (zn + (xn + z1))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(succ(yn) + xn) == succ((yn + xn))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(0 + xn) == xn
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((un * yn) < succ(yn)) == false if (not((un = 0)) and (not((un = succ(0))) and not((yn = 0))))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(un >= zn) == not((un < zn))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(succ(xn) < yn) == true if ((xn < yn) and not((succ(xn) = yn)))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(succ(xn) < yn) == true if ((xn < yn) and not((succ(xn) = yn)))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(succ(xn) < yn) == true if ((xn < yn) and not((succ(xn) = yn)))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(succ(xn) < yn) == true if ((xn < yn) and not((succ(xn) = yn)))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn * yn) = succ(0)) == ((xn = succ(0)) and (yn = succ(0)))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn * yn) = xn) == ((yn = succ(0)) or (xn = 0))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn * yn) = xn) == (yn = succ(0)) if not((xn = 0))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn * yn) = xn) == (yn = succ(0)) if not((xn = 0))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn * yn) = xn) == (yn = succ(0)) if not((xn = 0))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn + yn) = yn) == (xn = 0)
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


((xn + yn) = yn) == (xn = 0)
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(xn < succ(0)) == (xn = 0)
]
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(0 < xn) == not((xn = 0))
]
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(xn * (yn + zn)) == ((xn * yn) + (xn * zn))
]
makerule
add

The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


(xn + yn) == (yn + xn)
]
makerule
