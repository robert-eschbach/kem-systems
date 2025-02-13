;; Wie realisiert RRL CR ?

init

option prove e

add
[f : S -> S ]
[g : S -> S ]
[h : S -> S ]
[a : -> S ]
[b : -> S ]
[< : S , S -> bool ]


;; innermost
h(x) == x if (a < b)

;; outermost
f(x) == x 

]

mr

add
f(g(h(x))) == x if (f(a) < f(b))

h(g(x)) == g(x)

]


;; (setq *debug-print-level* 10)
;; (trace  bool-rewrite-at-root) 
;; (trace cover-norm-term norm-bool-innermost norm-or-args)
;; (trace order-eqns process-equation cover-norm-order cover-normalize)
;; (trace cover-uncondi-norm)
;; (trace reduce-by-premises-at-root)
;; (trace norm-term)
;; (trace norm-outermost rewrite-at-root reduce-at-root try-one-rule applies)
;; (trace polish-premises)

RRL-> mr
1 Enter ORDER-EQNS
| 2 Enter PROCESS-EQUATION ((H (G X)) (G X) NIL NIL (USER 4))
|   3 Enter COVER-NORM-ORDER ((H (G X)) (G X) NIL NIL (USER 4))
|   | 4 Enter COVER-NORMALIZE ((H (G X)) (G X) NIL NIL (USER 4))
|   |   5 Enter COVER-UNCONDI-NORM ((H (G X)) (G X) NIL NIL (USER 4)) NIL
|   |   | 6 Enter COVER-NORM-TERM (H (G X))
|   |   |   7 Enter NORM-TERM (H (G X))
|   |   |   | 8 Enter NORM-OUTERMOST (H (G X))
|   |   |   |   9 Enter REWRITE-AT-ROOT (H (G X)) NIL
|   |   |   |   | 10 Enter REDUCE-AT-ROOT (H (G X)) NIL
|   |   |   |   |   11 Enter TRY-ONE-RULE ((H #:X) #:X (*&* ((< (A) (B)) NIL)) NIL (USER 1) 5 NIL 1 NIL NIL ...) (H (G X))
|   |   |   |   |   | 12 Enter POLISH-PREMISES (*&* ((< (A) (B)) NIL)) ((H #:X) #:X (*&* ((< (A) (B)) NIL)) NIL (USER 1) 5 NIL 1 NIL NIL ...)
|   |   |   |   |   | 12 Exit POLISH-PREMISES (NIL *&* ((< (A) (B)) NIL))
|   |   |   |   |   | 12 Enter APPLIES (H #:X) (H (G X)) (NIL *&* ((< (A) (B)) NIL))
|   |   |   |   |   |   13 Enter NORM-BOOL-INNERMOST (< (A) (B))
|   |   |   |   |   |   | 14 Enter NORM-TERM (< (A) (B))
|   |   |   |   |   |   |   15 Enter NORM-OUTERMOST (< (A) (B))
|   |   |   |   |   |   |   | 16 Enter REWRITE-AT-ROOT (< (A) (B)) NIL
|   |   |   |   |   |   |   |   17 Enter REDUCE-AT-ROOT (< (A) (B)) NIL
|   |   |   |   |   |   |   |   17 Exit REDUCE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Exit REWRITE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Enter REWRITE-AT-ROOT (A) NIL
|   |   |   |   |   |   |   |   17 Enter REDUCE-AT-ROOT (A) NIL
|   |   |   |   |   |   |   |   17 Exit REDUCE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Exit REWRITE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Enter REWRITE-AT-ROOT (B) NIL
|   |   |   |   |   |   |   |   17 Enter REDUCE-AT-ROOT (B) NIL
|   |   |   |   |   |   |   |   17 Exit REDUCE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Exit REWRITE-AT-ROOT NIL
|   |   |   |   |   |   |   15 Exit NORM-OUTERMOST (< (A) (B))
|   |   |   |   |   |   | 14 Exit NORM-TERM (< (A) (B))
|   |   |   |   |   |   13 Exit NORM-BOOL-INNERMOST (< (A) (B))
|   |   |   |   |   | 12 Exit APPLIES NIL
|   |   |   |   |   11 Exit TRY-ONE-RULE NIL
|   |   |   |   | 10 Exit REDUCE-AT-ROOT NIL
|   |   |   |   9 Exit REWRITE-AT-ROOT NIL
|   |   |   |   9 Enter REWRITE-AT-ROOT (G X) NIL
|   |   |   |   | 10 Enter REDUCE-AT-ROOT (G X) NIL
|   |   |   |   |   11 Enter TRY-ONE-RULE ((G #:X) #:X (*&* ((< (A) (B)) NIL USED)) NIL (USER 3) 5 NIL 3 NIL NIL ...) (G X)
|   |   |   |   |   | 12 Enter POLISH-PREMISES (*&* ((< (A) (B)) NIL USED)) ((G #:X) #:X (*&* ((< (A) (B)) NIL USED)) NIL (USER 3) 5 NIL 3 NIL NIL ...)
|   |   |   |   |   | 12 Exit POLISH-PREMISES (NIL *&* ((< (A) (B)) NIL USED))
|   |   |   |   |   | 12 Enter APPLIES (G #:X) (G X) (NIL *&* ((< (A) (B)) NIL USED))
|   |   |   |   |   |   13 Enter NORM-BOOL-INNERMOST (< (A) (B))
|   |   |   |   |   |   | 14 Enter NORM-TERM (< (A) (B))
|   |   |   |   |   |   |   15 Enter NORM-OUTERMOST (< (A) (B))
|   |   |   |   |   |   |   | 16 Enter REWRITE-AT-ROOT (< (A) (B)) NIL
|   |   |   |   |   |   |   |   17 Enter REDUCE-AT-ROOT (< (A) (B)) NIL
|   |   |   |   |   |   |   |   17 Exit REDUCE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Exit REWRITE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Enter REWRITE-AT-ROOT (A) NIL
|   |   |   |   |   |   |   |   17 Enter REDUCE-AT-ROOT (A) NIL
|   |   |   |   |   |   |   |   17 Exit REDUCE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Exit REWRITE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Enter REWRITE-AT-ROOT (B) NIL
|   |   |   |   |   |   |   |   17 Enter REDUCE-AT-ROOT (B) NIL
|   |   |   |   |   |   |   |   17 Exit REDUCE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Exit REWRITE-AT-ROOT NIL
|   |   |   |   |   |   |   15 Exit NORM-OUTERMOST (< (A) (B))
|   |   |   |   |   |   | 14 Exit NORM-TERM (< (A) (B))
|   |   |   |   |   |   13 Exit NORM-BOOL-INNERMOST (< (A) (B))
|   |   |   |   |   | 12 Exit APPLIES NIL
|   |   |   |   |   11 Exit TRY-ONE-RULE NIL
|   |   |   |   | 10 Exit REDUCE-AT-ROOT NIL
|   |   |   |   9 Exit REWRITE-AT-ROOT NIL
|   |   |   | 8 Exit NORM-OUTERMOST (H (G X))
|   |   |   7 Exit NORM-TERM (H (G X))
|   |   | 6 Exit COVER-NORM-TERM (H (G X))
|   |   | 6 Enter COVER-NORM-TERM (G X)
|   |   |   7 Enter NORM-TERM (G X)
|   |   |   | 8 Enter NORM-OUTERMOST (G X)
|   |   |   |   9 Enter REWRITE-AT-ROOT (G X) NIL
|   |   |   |   | 10 Enter REDUCE-AT-ROOT (G X) NIL
|   |   |   |   |   11 Enter TRY-ONE-RULE ((G #:X) #:X (*&* ((< (A) (B)) NIL USED)) NIL (USER 3) 5 NIL 3 NIL NIL ...) (G X)
|   |   |   |   |   | 12 Enter POLISH-PREMISES (*&* ((< (A) (B)) NIL USED)) ((G #:X) #:X (*&* ((< (A) (B)) NIL USED)) NIL (USER 3) 5 NIL 3 NIL NIL ...)
|   |   |   |   |   | 12 Exit POLISH-PREMISES (NIL *&* ((< (A) (B)) NIL USED))
|   |   |   |   |   | 12 Enter APPLIES (G #:X) (G X) (NIL *&* ((< (A) (B)) NIL USED))
|   |   |   |   |   |   13 Enter NORM-BOOL-INNERMOST (< (A) (B))
|   |   |   |   |   |   | 14 Enter NORM-TERM (< (A) (B))
|   |   |   |   |   |   |   15 Enter NORM-OUTERMOST (< (A) (B))
|   |   |   |   |   |   |   | 16 Enter REWRITE-AT-ROOT (< (A) (B)) NIL
|   |   |   |   |   |   |   |   17 Enter REDUCE-AT-ROOT (< (A) (B)) NIL
|   |   |   |   |   |   |   |   17 Exit REDUCE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Exit REWRITE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Enter REWRITE-AT-ROOT (A) NIL
|   |   |   |   |   |   |   |   17 Enter REDUCE-AT-ROOT (A) NIL
|   |   |   |   |   |   |   |   17 Exit REDUCE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Exit REWRITE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Enter REWRITE-AT-ROOT (B) NIL
|   |   |   |   |   |   |   |   17 Enter REDUCE-AT-ROOT (B) NIL
|   |   |   |   |   |   |   |   17 Exit REDUCE-AT-ROOT NIL
|   |   |   |   |   |   |   | 16 Exit REWRITE-AT-ROOT NIL
|   |   |   |   |   |   |   15 Exit NORM-OUTERMOST (< (A) (B))
|   |   |   |   |   |   | 14 Exit NORM-TERM (< (A) (B))
|   |   |   |   |   |   13 Exit NORM-BOOL-INNERMOST (< (A) (B))
|   |   |   |   |   | 12 Exit APPLIES NIL
|   |   |   |   |   11 Exit TRY-ONE-RULE NIL
|   |   |   |   | 10 Exit REDUCE-AT-ROOT NIL
|   |   |   |   9 Exit REWRITE-AT-ROOT NIL
|   |   |   | 8 Exit NORM-OUTERMOST (G X)
|   |   |   7 Exit NORM-TERM (G X)
|   |   | 6 Exit COVER-NORM-TERM (G X)
|   |   5 Exit COVER-UNCONDI-NORM ((H (G X)) (G X) NIL NIL (USER 4))
|   | 4 Exit COVER-NORMALIZE ((H (G X)) (G X) NIL NIL (USER 4))

Adding Rule:   [4] H(G(X)) ---> G(X)  [USER, 4]
|   | 4 Enter POLISH-PREMISES NIL ((H (G #:X)) (G #:X) NIL NIL (USER 4) 8 NIL 4 NIL NIL ...)
|   | 4 Exit POLISH-PREMISES NIL
|   | 4 Enter APPLIES (H (G #:X)) (H #:X) NIL
|   | 4 Exit APPLIES NIL
|   3 Exit COVER-NORM-ORDER NIL
| 2 Exit PROCESS-EQUATION NIL
1 Exit ORDER-EQNS NIL




