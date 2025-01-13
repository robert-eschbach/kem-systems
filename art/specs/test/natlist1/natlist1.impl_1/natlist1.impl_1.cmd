OPTION
HISTORY
NO-HISTORY
ADD
      [PERM : NATLIST, NATLIST -> BOOL ]
      [MEMBER : NAT, NATLIST -> BOOL ]
      [DELETE : NAT, NATLIST -> NATLIST ]
      [APPEND : NATLIST, NATLIST -> NATLIST ]
      [CONS : NAT, NATLIST -> NATLIST ]
      [NULL : -> NATLIST ]
      [SUCC : NAT -> NAT ]
APPEND(NULL, XNL1) := XNL1
APPEND(CONS(X, XNL1), XNL2) := CONS(X, APPEND(XNL1, XNL2))
DELETE(X, NULL) := NULL
DELETE(X, CONS(X, XNL1)) := XNL1
DELETE(X, CONS(Y, XNL1)) := CONS(Y, DELETE(X, XNL1)) if NOT((Y = X))
MEMBER(X, NULL) := FALSE
MEMBER(X, CONS(X, XNL1)) := true 
MEMBER(X, CONS(Y, XNL1)) := MEMBER(X, XNL1) if NOT((X = Y))
PERM(NULL, NULL) := true 
PERM(NULL, CONS(X, XNL1)) := FALSE
PERM(CONS(X, XNL1), NULL) := FALSE
PERM(CONS(X, XNL1), XNL2) := (MEMBER(X, XNL2) AND PERM(XNL1, DELETE(X, XNL2)))
]
OPERATOR
CONSTRUCTOR
0 
0
OPERATOR
CONSTRUCTOR
SUCC 
YES
OPERATOR
CONSTRUCTOR
NULL 
OPERATOR
CONSTRUCTOR
CONS 
YES
OPTION
ORDER
L
OPERATOR
PRECEDENCE
PERM MEMBER 
OPERATOR
PRECEDENCE
PERM DELETE 
OPERATOR
STATUS
PERM
LR
MAKERULE
SUFFICE

; Note: the system may be not canonical.

; Specification of 'APPEND' is completely defined.

; Specification of 'DELETE' is not known to be completely defined.
; Following left hand sides of rules are proposed: 
;    DELETE(SUCC(X), CONS(SUCC(X1), X2)) ---> something

; Specification of 'MEMBER' is not known to be completely defined.
; Following left hand sides of rules are proposed: 
;    MEMBER(SUCC(X), CONS(SUCC(X1), X2)) ---> something

; Specification of 'PERM' is completely defined.
OPTION
PROVE
E
COVER

; Specification of 'APPEND' is completely defined.

; Specification of 'DELETE' is not known to be completely defined.
; Following left hand sides of rules are proposed: 
;    DELETE(SUCC(X), CONS(SUCC(X1), X2)) ---> something
Y

; Specification of 'MEMBER' is not known to be completely defined.
; Following left hand sides of rules are proposed: 
;    MEMBER(SUCC(X), CONS(SUCC(X1), X2)) ---> something
Y

; Specification of 'PERM' is completely defined.
ADD
]
MAKERULE
PROVE
DELETE(X, XNL1) == XNL1 if NOT(MEMBER(X, XNL1))

; All subgoals are proved so 
; DELETE(X, XNL1) == XNL1  if   { not(MEMBER(X, XNL1)) } 
;  is an inductive theorem.
; Following equation
;    DELETE(X, XNL1) == XNL1  if   { not(MEMBER(X, XNL1)) } 
;    is an inductive theorem in the current system.
WRITE
SPEC-WRITE
/USR/PROGRESS/ART/SPECS/TEST/NATLIST1/NATLIST1.IMPL_1/NATLIST1.IMPL_1
Y
