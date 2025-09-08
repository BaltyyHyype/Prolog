
(defun division (a b)
    (if (< a b)               
        0                     
        (+ 1 (division (- a b) b))
    )
    
) 


(defun multiplicacion (a b) 
    (if (= b 0)
        0
        (+ a (multiplicacion a (- b 1))) 
    )
    
)


(defun potencia (base exp)
    (if (= exp 0)
        1
        (multiplicacion base (potencia base (- exp 1)))
    )
      
)

