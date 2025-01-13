(in-package 'scanner-generator) 
(setq der-scanner 
(compile-scanner 
    '(or ; (and #\- #\- #\> (erg1 r-gl))  
         ; (and #\- #\> (erg1 ar-right))
         ; (and #\: #\= (erg1 def-gl))    
         (and #\: #\= (erg1 |:=|)) 
			    ; changed 2.5.1991
         ; inserted 9.4.1991   
         ; (and #\= #\= (erg1 gl-gl))  
         ; changes to comment 9.4.1991
         (and #\: (erg1 #\:)) 
         (and #\, (erg1 #\,))  
         (and #\( (erg1 #\())
         (and #\) (erg1 #\)))
         (and #\_ (erg1 #\_))
         (and #\# (erg1 #\#))
         (and #\< (erg1 #\<))
         (and #\> (erg1 #\>)) 
         (and #\[ (erg1 #\[))
         (and #\] (erg1 #\]))        
         (and #\; (erg1 #\;))  
         (and #\r (erg1 #\r))  
         (and #\m (erg1 #\m))  
         (and #\l (erg1 #\l))
	 (and #\e (erg1 #\e))
	 (and #\o (erg1 #\o))
	 (and #\h (erg1 #\h))  
         ; inserted 8.4.1991
         (and #\: #\  #\f (erg1 dp-f))
         ; (and #\- (erg1 #\-)) 
         (and (or #\0 (and (range #\1 #\9) (* (range #\0 #\9)))) 
              (erg1 number)
         ) 
         ; changed 2.5.1991  0 als gueltige Zahl
         ; moved here 9.4.1991
         (and (or (range #\a #\z)
                  (range #\A #\Z) 
                  (range #\0 #\9)
              )
              (* (or (range #\a #\z)
                     (range #\A #\Z)
                     (range #\0 #\9) 
                     (and (or #\- #\_)
                          (or (range #\a #\z) (range #\A #\Z) (range #\0 #\9))
                     ) 
                 )   
              )   
              (? (set (#\% #\$)))
              (erg1 name)
         )
         ; changed & moved here 9.4.1991  
	 (and (? #\/)
	      (+ (and 
	           (or (set (#\! #\@  #\& #\- #\_ #\. #\=))
		       (range #\a #\z)
		       (range #\A #\Z)
		       (range #\0 #\9))
		  (? #\/)
		  );and
		 );+
	      (erg1 pfadname))
	 (and (+ (or (set (#\! #\@  #\& #\- #\_ #\. #\=))
		     (range #\a #\z)
		     (range #\A #\Z)
		     (range #\0 #\9))
		 );+
	      (? (and #\^ 
		      (* (range #\0 #\9))))
	      (? (and #\^ 
		      (* (range #\0 #\9))))
	      (erg1 modid))

         (and 
           (or (and #\' (+ (not-set (#\newline #\  #\tab))))
             (and (set (#\! #\@ #\^ #\& #\+ #\- #\* #\? #\~ #\/ #\\ #\| #\` #\< #\> #\. #\=))  
                  (or 
                    (and (* (or (range #\a #\z)
                                (range #\A #\Z)
                              ; (range #\0 #\9)   
                              ; changed to comment 8.4.1991
                                (set (#\! #\@ #\# #\$ #\^ #\& #\* #\- #\+ #\= #\~ #\` #\< #\> #\? #\/ #\. #\_))
                            ) 
                         )
                         (or (range #\0 #\9) 
                             (set (#\! #\@ #\# #\$ #\^ #\& #\* #\- #\+ #\= #\~ #\` #\< #\> #\? #\/ #\. #\_))
                         ) 
                    )
                    (? (or (range #\0 #\9) 
                           (set (#\! #\@ #\# #\$ #\^ #\& #\* #\- #\+ #\= #\~ #\` #\< #\> #\? #\/ #\. #\_))
                       ) 
                    ) 
                  )
             )
           )
           (erg1 operator)
         )  
         (and (+ (set (#\newline #\  #\tab)))     (erg1 ignore))  
         (and #\% (* (not-set (#\newline))) #\newline (erg1 ignore))
     )            ; corrected 9.4.1991
     :scanner-name 'scanner-art 
     :talk t                            ; changed e to a
     :write-to #P"scanner-art.lisp"  
)                                         ; changed e to a
 
);erstes setq