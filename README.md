
````txt
# Programación Lógica y Funcional
Baltazar Pérez Sierra

---

## Lisp
Ejercicios realizados en Common Lisp.

### Divisiones y Potencias Recursivas (`sumasYpotencias.lsp`)
Funciones recursivas básicas para operaciones aritméticas.

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
````

### Funciones Car y Cdr (`FuncionCarCdr.lsp`)

Pruebas de acceso a elementos de listas usando `car` y `cdr`.

```lisp
(defun recorre(lista)
    (car lista)
    (if lista
        (recorre(cdr lista))
    )
)

;la combinacion de la primera
(cadddr ' (a b c (d 1) (c x )mn))
; Resultado: D 1

;segunda combinacion
Break 9 [11]> (cadr(car(cddddr ' (a b c (d 1) (c x )mn))))
; Resultado: X
```

### Árbol de Decisión / Adivinanza (`arbolprog.lsp`)

Recorre un árbol (lista anidada) haciendo preguntas para adivinar un personaje.

```lisp
(defun recorre (lista)
    (when lista
        (let ((elemento (car lista)))
            (format t "¿Tu personaje es ~a?~%" (car elemento))
            (setq a (read))
            (if (string-equal a "si")
                (progn
                    (setq b (cadr (assoc (car elemento) lista)))
                    (recorre b)
                )
                (recorre (cdr lista))
            )
        )
    )
)

(defparameter *nodes* '(  (femenino   ((fuego ((azula)))
                    (tierra ((top) (karara)))
            ))

        (masculino  ((aire ((hola-rayo-masculino)))
                        (fuego ((hola-fuego)))
                        (tierra ((hola-tierra)))
                        (agua ((poder-de-agua)))
                        ))
            
        (ovni       ((aire ((alto ((junito-ovni ())))))
                        (fuego ((hola-fuego)))
                        (tierra ((hola-tierra)))
                        (agua2 ((poder-de-agua)))
            ))

        (aleatorio  ((aire ((hola-rayo)))
                        (fuego ((hola-fuego)))
                        (tierra ((hola-tierra)))
                        (agua2 ((poder-de-agua)))
            ))
    )
)
```

-----

## Prolog

Ejercicios realizados en SWI-Prolog.

### Práctica: Listas en Prolog (`listas.pl`)

10 ejercicios básicos para la manipulación de listas, incluyendo recursividad, acceso y construcción de predicados.

```prolog
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Práctica: Listas en Prolog
% Soluciones a los 10 ejercicios.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1.3 Ejercicio 1: Cabeza y cola de una lista
%
% Define un predicado que permita obtener la cabeza y la cola de una
% lista.
% Consulta:
% ?- cabeza_y_cola([a,b,c,d], C, T).
%
cabeza_y_cola([Cabeza | Cola], Cabeza, Cola).


% 1.4 Ejercicio 2: Verificar si un elemento pertenece a una lista
%
% Crea un predicado `pertenece/2` que determine si un elemento se
% encuentra en una lista.
% Consulta:
% ?- pertenece(b, [a,b,c]).
%
pertenece(X, [X | _]).
pertenece(X, [_ | Cola]) :- pertenece(X, Cola).


% 1.5 Ejercicio 3: Calcular la longitud de una lista
%
% Define un predicado `longitud/2` que devuelva la cantidad de elementos
% de una lista.
% Consulta:
% ?- longitud([a,b,c,d], N).
%
longitud([], 0).
longitud([_ | Cola], N) :-
    longitud(Cola, N_Cola),
    N is N_Cola + 1.


% 1.6 Ejercicio 4: Concatenar dos listas
%
% Crea el predicado `concatenar/3` que una dos listas.
% Consulta:
% ?- concatenar([1,2], [3,4], R).
%
concatenar([], L, L).
concatenar([X | L1], L2, [X | R]) :-
    concatenar(L1, L2, R).


% 1.7 Ejercicio 5: Invertir una lista
%
% Escribe un predicado `invertir/2` que invierta el orden de los
% elementos.
% Consulta:
% ?- invertir([a,b,c,d], R).
%
% (Se usa un predicado auxiliar con un acumulador
% para mayor eficiencia, es la forma estándar en Prolog).
invertir(Lista, Invertida) :-
    invertir_acc(Lista, [], Invertida).

invertir_acc([], Acumulador, Acumulador).
invertir_acc([Cabeza | Cola], Acumulador, Invertida) :-
    invertir_acc(Cola, [Cabeza | Acumulador], Invertida).


% 1.8 Ejercicio 6: Obtener el último elemento
%
% Crea el predicado `ultimo/2` que retorne el último elemento de una
% lista.
% Consulta:
% ?- ultimo([a,b,c,d], X).
%
ultimo([X], X).
ultimo([_ | Cola], X) :-
    ultimo(Cola, X).


% 1.9 Ejercicio 7: Sumar los elementos de una lista numérica
%
% Define un predicado `suma_lista/2` que calcule la suma de los
% elementos de una lista de números.
% Consulta:
% ?- suma_lista([2,4,6,8], S).
%
suma_lista([], 0).
suma_lista([Cabeza | Cola], Suma) :-
    suma_lista(Cola, SumaCola),
    Suma is Cabeza + SumaCola.


% 1.10 Ejercicio 8: Eliminar un elemento de una lista
%
% Crea un predicado `eliminar/3` que elimine la primera aparición de un
% elemento en una lista.
% Consulta:
% ?- eliminar(c, [a,b,c,d,c], R).
%
eliminar(_, [], []).
eliminar(X, [X | Cola], Cola).
eliminar(X, [Y | Cola], [Y | R]) :-
    X \= Y,
    eliminar(X, Cola, R).


% 1.11 Ejercicio 9: Duplicar los elementos de una lista
%
% Escribe un predicado `duplicar/2` que duplique cada elemento de una
% lista.
% Consulta:
% ?- duplicar([a,b,c], R).
%
duplicar([], []).
duplicar([X | Cola], [X, X | R]) :-
    duplicar(Cola, R).


% 1.12 Ejercicio 10: Intercalar dos listas
%
% Crea un predicado `intercalar/3` que mezcle los elementos de dos
% listas alternándolos.
% Consulta:
% ?- intercalar([1,3,5], [2,4,6], R).
%
intercalar([], L, L).
intercalar(L, [], L).
intercalar([X | L1], [Y | L2], [X, Y | R]) :-
    intercalar(L1, L2, R).
```

-----

## Lógica de Predicados

Ejercicios de traducción de lenguaje natural a lógica de predicados (`oraciones.md`).

  * La Tierra es un planeta.
      * **Constantes de Individuo:** Tierra
      * **Propiedades (Predicados Unarios):** `planeta(tierra)`
      * **Dominio del discurso:** Tierra

-----

  * La Luna no es un planeta.
      * **Constantes de Individuo:** Luna
      * **Propiedades (Predicados Unarios):** `¬planeta(luna)`
      * **Dominio del discurso:** Luna

-----

  * La Luna es un satélite.
      * **Constantes de Individuo:** Luna
      * **Propiedades (Predicados Unarios):** `satelite(luna)`
      * **Dominio del discurso:** Luna

-----

  * La Tierra gira alrededor del Sol.
      * **Constantes de Individuo:** Tierra, Sol
      * **Relaciones (Predicados N-arios):** `gira_alrededor(tierra, sol)`
      * **Dominio del discurso:** Tierra, Sol

-----

  * Todo planeta es un satélite.
      * **Variables de Individuo:** planetas
      * **Cuantificadores:** Universal(∀)
      * **Propiedades:** Satelite
      * **Relaciones (Predicados N-arios):** `∀x(planeta(x) ⟶ satelite(x))`
      * **Dominio del discurso:** Planetas

-----

  * Todo planeta gira alrededor del Sol.
      * **Constantes de Individuo:** Sol
      * **Variables de Individuo:** planetas
      * **Cuantificadores:** Universal(∀)
      * **Propiedades:** `gira_alrededor(x, y)`
      * **Relaciones (Predicados N-arios):** `∀x(planeta(x) ⟶ gira_alrededor(x, sol))`
      * **Dominio del discurso:** Planetas, Sol

-----

  * Algún planeta gira alrededor de la Luna.
      * **Constantes de Individuo:** Luna
      * **Variables de Individuo:** planetas
      * **Cuantificadores:** Existencial(∃)
      * **Propiedades:** `gira_alrededor(x, y)`
      * **Relaciones (Predicados N-arios):** `∃x(planeta(x) ^ gira_alrededor(x, luna))`
      * **Dominio del discurso:** Planetas, Luna

-----

  * Hay por lo menos un satélite.
      * **Variables de Individuo:** x
      * **Cuantificadores:** Existencial(∃)
      * **Propiedades:** satelite
      * **Relaciones (Predicados N-arios):** `∃x(satelite(x))`

-----

  * Todos los perros del vecindario muerden a algún cartero.
      * **Variables de Individuo:** Perros, Cartero
      * **Cuantificadores:** Universal(∀), Existencial(∃)
      * **Propiedades:** muerden, Cartero
      * **Relaciones (Predicados N-arios):** `∀x(perros(x) ⟶ ∃y(cartero(y) ^ muerden(x, y)))`
      * **Dominio del discurso:** Perros, Cartero

-----

  * Hay un cartero al que lo muerden todos los perros
      * **Variables de Individuo:** x, y
      * **Cuantificadores:** Universal(∀), Existencial (∃)
      * **Propiedades:** muerden, Cartero, perro
      * **Relaciones (Predicados N-arios):** `∃x(cartero(x) ^ ∀y(perro(y) ⟶ muerde(y, x)))`
      * **Dominio del discurso:** Perros, Cartero

-----

  * Todos los carteros son mordidos por algún perro.
      * **Variables de Individuo:** x, y
      * **Cuantificadores:** Universal(∀), Existencial
      * **Propiedades:** mordido, Cartero, perro
      * **Relaciones (Predicados N-arios):** `∀x(cartero(x) ⟶ ∃y(perro(y) ^ mordido(x, y)))`
      * **Dominio del discurso:** Perros, Cartero

-----

  * Hay un perro que muerde a todos los carteros
      * **Variables de Individuo:** x, y
      * **Cuantificadores:** Universal(∀), Existencial(∃)
      * **Propiedades:** muerde, Cartero, perro
      * **Relaciones (Predicados N-arios):** `∃x(perro(x) ^ ∀y(cartero(y) ⟶ muerde(x, y)))`
      * **Dominio del discurso:** Perros, Cartero

-----

  * Todos los perros que asustan a algún cartero, lo muerden
      * **Variables de Individuo:** x, y
      * **Cuantificadores:** Universal(∀), Existencial(∃)
      * **Propiedades:** asusta, Cartero, perro, muerde
      * **Relaciones (Predicados N-arios):** `∀x((perro(x) ^ ∃y(cartero(y) ^ asusta(x, y))) ⟶ muerde(x, y))`
      * **Dominio del discurso:** Perros, Cartero

-----

  * Hay un perro que muerde a todos los perros que muerden a algún cartero
      * **Variables de Individuo:** x, y, z
      * **Cuantificadores:** Universal(∀), Existencial(∃)
      * **Propiedades:** muerde, perro, cartero
      * **Relaciones (Predicados N-arios):** `∃x(perro(x) ^ ∀y((perros(y) ^ ∃z(cartero(z) ^ muerde(y, z))) ⟶ muerde(x, y)))`
      * **Dominio del discurso:** Perros, Cartero

-----

  * Hay un solo perro que se muerde a sí mismo
      * **Variables de Individuo:** x
      * **Cuantificadores:** Existencial único (∃\!)
      * **Propiedades:** muerde, perro
      * **Relaciones (Predicados N-arios):** `∃!x(perro(x) ^ muerde(x, x))`
      * **Dominio del discurso:** Perros

-----

```
```