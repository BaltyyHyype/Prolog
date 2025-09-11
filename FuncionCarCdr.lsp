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
