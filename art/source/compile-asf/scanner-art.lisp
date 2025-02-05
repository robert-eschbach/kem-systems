(IN-PACKAGE (QUOTE COMPILE-ASF))

(PROGN
  (SETF (GET 'SCANNER-ART 'SCAN-TAB-AR)
        (MAKE-ARRAY '(51)
                    :INITIAL-CONTENTS
                    (LIST
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL 17 17 NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL 17 14 NIL 20 NIL 16 14 5 2 50 30 30 38
                        14 14 27 22 3 3 3 3 3 3 3 3 3 37 32 31 14 18 30 14 41
                        41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41
                        41 41 41 41 41 41 41 6 30 1 30 40 30 41 41 41 41 19 41
                        41 7 41 41 41 49 39 41 33 41 41 21 41 41 41 41 41 41 41
                        41 NIL 30 NIL 30 NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL)
                      NIL
                      NIL
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 42 NIL NIL 43 43 42 NIL NIL NIL NIL
                        NIL NIL 46 42 45 3 3 3 3 3 3 3 3 3 3 NIL NIL NIL 42 NIL
                        NIL 42 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41
                        41 41 41 41 41 41 41 41 41 41 NIL NIL NIL 48 46 NIL 41
                        41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41
                        41 41 41 41 41 41 41 NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)
                      '(5)
                      #(4 4 4 4 4 4 4 4 4 NIL NIL 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
                        4 4 4 4 4 4 NIL 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
                        4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
                        4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
                        4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
                        4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
                        4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
                        4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
                        4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
                        4 4 4 4 4 4 4)
                      NIL
                      '(49)
                      '(42)
                      '(14)
                      '(48)
                      '(47)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 30 NIL 30 30 NIL 30 NIL NIL NIL 30
                        30 NIL 30 30 30 11 11 11 11 11 11 11 11 11 11 NIL NIL
                        30 30 30 30 30 28 28 28 28 28 28 28 28 28 28 28 28 28
                        28 28 28 28 28 28 28 28 28 28 28 28 28 NIL NIL NIL 30
                        30 30 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
                        28 28 28 28 28 28 28 28 28 28 NIL NIL NIL 30 NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 30 NIL 30 30 NIL 30 NIL NIL NIL 30
                        30 NIL 30 30 30 10 10 10 10 10 10 10 10 10 10 NIL NIL
                        30 30 30 30 30 28 28 28 28 28 28 28 28 28 28 28 28 28
                        28 28 28 28 28 28 28 28 28 28 28 28 28 NIL NIL NIL 12
                        30 30 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
                        28 28 28 28 28 28 28 28 28 28 NIL NIL NIL 30 NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 14 NIL 30 30 NIL 14 NIL NIL NIL 30
                        30 NIL 14 14 25 8 8 8 8 8 8 8 8 8 8 NIL NIL 30 14 30 30
                        14 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9
                        NIL NIL NIL 13 14 30 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9
                        9 9 9 9 9 9 9 9 9 NIL NIL NIL 30 NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)
                      NIL
                      #(16 16 16 16 16 16 16 16 16 16 15 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16
                        16 16 16 16)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL 17 17 NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL 17 NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL)
                      '(31)
                      '(49)
                      NIL
                      '(49)
                      '(49)
                      '(26)
                      '(44)
                      '(27)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 26 NIL 30 30 NIL 26 NIL NIL NIL 30
                        30 NIL 26 26 25 24 24 24 24 24 24 24 24 24 24 NIL NIL
                        30 26 30 30 26 23 23 23 23 23 23 23 23 23 23 23 23 23
                        23 23 23 23 23 23 23 23 23 23 23 23 23 NIL NIL NIL 30
                        26 30 23 23 23 23 23 23 23 23 23 23 23 23 23 23 23 23
                        23 23 23 23 23 23 23 23 23 23 NIL NIL NIL 30 NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 26 NIL 30 30 NIL 26 NIL NIL NIL 30
                        30 NIL 26 26 30 24 24 24 24 24 24 24 24 24 24 NIL NIL
                        30 26 30 30 26 23 23 23 23 23 23 23 23 23 23 23 23 23
                        23 23 23 23 23 23 23 23 23 23 23 23 23 NIL NIL NIL 30
                        26 30 23 23 23 23 23 23 23 23 23 23 23 23 23 23 23 23
                        23 23 23 23 23 23 23 23 23 23 NIL NIL NIL 30 NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL)
                      '(31)
                      NIL
                      '(31)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 30 NIL 30 30 NIL 30 NIL NIL NIL 30
                        30 NIL 30 30 30 29 29 29 29 29 29 29 29 29 29 NIL NIL
                        30 30 30 30 30 28 28 28 28 28 28 28 28 28 28 28 28 28
                        28 28 28 28 28 28 28 28 28 28 28 28 28 NIL NIL NIL 30
                        30 30 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
                        28 28 28 28 28 28 28 28 28 28 NIL NIL NIL 30 NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL)
                      NIL
                      '(49)
                      NIL
                      NIL
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL 35 NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL 36 NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 34 NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL)
                      NIL
                      '(49)
                      '(42)
                      '(49)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 42 NIL NIL NIL NIL 42 NIL NIL NIL
                        NIL NIL NIL 42 42 45 42 42 42 42 42 42 42 42 42 42 NIL
                        NIL NIL 42 NIL NIL 42 42 42 42 42 42 42 42 42 42 42 42
                        42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 NIL NIL
                        NIL 48 42 NIL 42 42 42 42 42 42 42 42 42 42 42 42 42 42
                        42 42 42 42 42 42 42 42 42 42 42 42 NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL)
                      NIL
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 44 NIL NIL NIL NIL 44 NIL NIL NIL
                        NIL NIL NIL 44 44 45 44 44 44 44 44 44 44 44 44 44 NIL
                        NIL NIL 44 NIL NIL 44 44 44 44 44 44 44 44 44 44 44 44
                        44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 NIL NIL
                        NIL NIL 44 NIL 44 44 44 44 44 44 44 44 44 44 44 44 44
                        44 44 44 44 44 44 44 44 44 44 44 44 44 NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 44 NIL NIL NIL NIL 44 NIL NIL NIL
                        NIL NIL NIL 44 44 NIL 44 44 44 44 44 44 44 44 44 44 NIL
                        NIL NIL 44 NIL NIL 44 44 44 44 44 44 44 44 44 44 44 44
                        44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 NIL NIL
                        NIL NIL 44 NIL 44 44 44 44 44 44 44 44 44 44 44 44 44
                        44 44 44 44 44 44 44 44 44 44 44 44 44 NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 42 NIL NIL NIL NIL 42 NIL NIL NIL
                        NIL NIL NIL 42 42 45 41 41 41 41 41 41 41 41 41 41 NIL
                        NIL NIL 42 NIL NIL 42 41 41 41 41 41 41 41 41 41 41 41
                        41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 NIL NIL
                        NIL 48 42 NIL 41 41 41 41 41 41 41 41 41 41 41 41 41 41
                        41 41 41 41 41 41 41 41 41 41 41 41 NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL 47 47 47 47 47 47 47 47 47 47
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL 48 48 48 48 48 48 48 48 48 48
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL 47 NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL)
                      #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL 42 NIL NIL 43 43 42 NIL NIL NIL NIL
                        NIL NIL 46 42 45 41 41 41 41 41 41 41 41 41 41 NIL NIL
                        NIL 42 NIL NIL 42 41 41 41 41 41 41 41 41 41 41 41 41
                        41 41 41 41 41 41 41 41 41 41 41 41 41 41 NIL NIL NIL
                        48 46 NIL 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41
                        41 41 41 41 41 41 41 41 41 41 41 NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                        NIL NIL)
                      NIL)))
  (LET ((TAB-AR (GET 'SCANNER-ART 'SCAN-TAB-AR))
        ENTRY)
    (DOTIMES (AI (LENGTH TAB-AR))
             (WHEN (CONSP (SETQ ENTRY (SVREF TAB-AR AI)))
                   (SETF (SVREF TAB-AR AI)
                         (SVREF TAB-AR (CAR ENTRY))))))
  (DEFUN SCANNER-ART
         (INPUT &AUX
                NEXT-STATE
                (HV NIL)
                (LAST-SUCCESS-STATE-T NIL)
                SET-BACK-VAL
                (TAB-AR (GET 'SCANNER-ART 'SCAN-TAB-AR)))
         (SETQ NEXT-STATE 0)
         (LOOP
           (WHEN
             (SETQ HV (SVREF
                        #(NIL #\] #\( (NUMBER NAME PFADNAME MODID) OPERATOR NIL
                          #\[ (#\h NAME PFADNAME MODID)
                          (PFADNAME MODID OPERATOR) (PFADNAME MODID)
                          (MODID OPERATOR) (MODID OPERATOR) (MODID OPERATOR)
                          (MODID OPERATOR) (PFADNAME MODID OPERATOR) IGNORE NIL
                          IGNORE (#\> OPERATOR) (#\e NAME PFADNAME MODID) #\#
                          (#\r NAME PFADNAME MODID)
                          (NUMBER NAME PFADNAME MODID) PFADNAME
                          (PFADNAME OPERATOR) (PFADNAME OPERATOR)
                          (PFADNAME OPERATOR) OPERATOR NIL OPERATOR OPERATOR
                          (#\< OPERATOR) #\; (#\o NAME PFADNAME MODID) |:=|
                          DP-F NIL #\: #\, (#\m NAME PFADNAME MODID)
                          (#\_ PFADNAME MODID) (NAME PFADNAME MODID)
                          (PFADNAME MODID) NAME PFADNAME PFADNAME
                          (PFADNAME MODID) MODID MODID
                          (#\l NAME PFADNAME MODID) #\))
                        NEXT-STATE))
             (SETQ LAST-SUCCESS-STATE-T HV
                   SET-BACK-VAL (GET-INPUT-SET-BACK-VAL INPUT)))
           (UNLESS (INPUT-LEFT1 INPUT)
                   (RETURN
                     (IF HV
                         (VALUES HV
                                 (GET-INPUT-ACT-STR INPUT)
                                 INPUT)
                         (IF LAST-SUCCESS-STATE-T
                             (PROGN (SET-INPUT-BACK INPUT SET-BACK-VAL)
                                    (VALUES LAST-SUCCESS-STATE-T
                                            (GET-INPUT-ACT-STR INPUT)
                                            INPUT))
                             (VALUES NIL
                                     (GET-INPUT-ACT-STR INPUT)
                                     INPUT
                                     'NO-TERM-NODE-FAIL)))))
           (IF (VECTORP (SETQ NEXT-STATE
                              (SVREF TAB-AR NEXT-STATE)))
               (SETQ NEXT-STATE (SVREF NEXT-STATE
                                       (CHAR-CODE (INPUT-POP1 INPUT))))
               (INPUT-POP1 INPUT))
           (UNLESS NEXT-STATE
                   (RETURN
                     (IF LAST-SUCCESS-STATE-T
                         (PROGN (SET-INPUT-BACK INPUT SET-BACK-VAL)
                                (VALUES LAST-SUCCESS-STATE-T
                                        (GET-INPUT-ACT-STR INPUT)
                                        INPUT))
                         (VALUES NIL
                                 (GET-INPUT-ACT-STR INPUT)
                                 INPUT
                                 'NO-SUCCESOR-NODE)))))))
