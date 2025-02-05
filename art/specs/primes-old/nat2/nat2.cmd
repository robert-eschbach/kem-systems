add
[succ : NAT -> NAT ]
[+ : NAT, NAT -> NAT ]
[- : NAT, NAT -> NAT ]
[* : NAT, NAT -> NAT ]
[^= : NAT, NAT -> bool ]
[< : NAT, NAT -> bool ]
[>= : NAT, NAT -> bool ]
[if.n : bool, NAT, NAT -> NAT ]
[0 : -> NAT ]


(x + 0) == x
(x + succ(y)) == succ((x + y))
(0 - x) == 0
(x - 0) == x
(succ(x) - succ(y)) == (x - y)
(x * 0) == 0
(x * succ(y)) == (x + (x * y))
(0 ^= 0)
(0 ^= succ(x)) == false
(succ(x) ^= 0) == false
(succ(x) ^= succ(y)) == (x ^= y)
(x < 0) == false
(0 < succ(x))
(succ(x) < succ(y)) == (x < y)
(x >= x)
(0 >= succ(y)) == false
(succ(x) >= y) == (x >= y) if not((succ(x) ^= y))
if.n(true, x, y) == x
if.n(false, x, y) == y
if.n(xb, succ(x), succ(y)) == succ(if.n(xb, x, y))
]
operator
constructor
0 
operator
constructor
succ 
yes
operator
order
l
makerule
1 
option
prove
e
write
spec-write
/tmp_mnt/usr/users/madprak1/specs/nat2/nat2.spec
