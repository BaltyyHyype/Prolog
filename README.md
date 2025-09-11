# Prolog
programación logica y funcional - Baltazar Pérez Sierra

# Divisiones y Potencias recursivas



```lisp

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

```


#Funcion Car y Funcion Cdr

(defun recorre(lista)
    (car lista)
    (if lista
        (recorre(cdr lista))
    )
)


;la combinacion de la primera
(cadddr ' (a b c (d 1) (c x )mn))
D 1
;segunda combinacion
Break 9 [11]> (cadr(car(cddddr ' (a b c (d 1) (c x )mn))))
X
