
# Programación Lógica y Funcional
Baltazar Pérez Sierra


# Lisp
Ejercicios realizados en Common Lisp.

# Divisiones y Potencias Recursivas (`sumasYpotencias.lsp`)
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




# 🤖 Proyecto Final: BotHype (Eliza) - Prolog & Lisp

Este repositorio contiene la implementación final del proyecto **Eliza**, un sistema experto tipo chatbot desarrollado bajo dos paradigmas de programación distintos: **Lógico (Prolog)** y **Funcional (Common Lisp)**.

El bot, llamado **"BotHype"**, actúa como un asistente virtual capaz de diagnosticar enfermedades comunes (con recomendaciones reales en **Morelia, Michoacán**) y resolver consultas sobre relaciones familiares complejas.

---

## 🚀 Características Principales

### 1. 🏥 Sistema Experto Médico (Guía Salud Morelia)
El bot es capaz de identificar enfermedades basándose en síntomas.
* **Detección de Síntoma Doble (Multitasking):** Si el usuario ingresa `tengo tos y fiebre`, el bot busca una enfermedad que coincida con ambos. Si son enfermedades distintas, analiza cada síntoma por separado.
* **Lógica de Descarte:** El bot realiza preguntas de seguimiento para confirmar o descartar enfermedades basándose en la base de conocimiento.
* **Base de Datos Local:** Incluye direcciones reales de hospitales y especialistas en Morelia (Hospital Civil, Star Médica, IMSS Charo, etc.).

### 2. 🌳 Base de Conocimiento Familiar
Resuelve relaciones genealógicas y realiza conteos inteligentes.
* **Consultas:** ¿Quién es el papá de...? ¿Quiénes son los tíos de...?
* **Conteos:** Responde preguntas como `cuantos abuelos hay` o `cuantos integrantes son` utilizando lógica de conjuntos.
* **Extra:** Incluye datos sobre la familia de Shrek.

### 3. 🧠 Procesamiento de Lenguaje Natural (NLP)
* **Tokenización:** Limpieza de signos de puntuación y normalización de texto.
* **Patrones con Comodines:** Uso del comodín `s` (o variables en Prolog) para capturar frases completas o palabras clave.

---

## 💻 Instrucciones de Ejecución

### Opción A: Versión Lisp (`eliza.lisp`)
1.  Abre tu terminal y ejecuta SBCL (o tu intérprete preferido):
    ```bash
    sbcl
    ```
2.  Carga el archivo:
    ```lisp
    * (load "eliza.lisp")
    ```
3.  El bot iniciará automáticamente. Si no, escribe `(eliza)`.

### Opción B: Versión Prolog (`eliza.pl`)
1.  Abre tu terminal y ejecuta SWI-Prolog:
    ```bash
    swipl
    ```
2.  Carga el archivo:
    ```prolog
    ?- [eliza].
    ```
3.  Inicia el bot:
    ```prolog
    ?- eliza.
    ```

---

## 📂 Código Fuente Completo

Para fines de documentación, aquí se incluyen los códigos fuente completos de ambas versiones.

### 1. Código en Common Lisp (`eliza.lisp`)

```lisp
;;;; PROYECTO FINAL ELIZA LISP BALTY

(defparameter *eliza-punct-chars* ".,;:()?!\"'")

(defun eliza--space-p (c)
  "Verifica si un caracter es un espacio, tabulador o salto de linea."
  (or (char= c #\Space) 
      (char= c #\Tab) 
      (char= c #\Newline) 
      (char= c #\Return)))

(defun clean-and-tokenize (line)
  (when line
    (let* ((lower (string-downcase line)) ; Convertir a minusculas
           (clean-str
            (with-output-to-string (out)
              (loop for c across lower do
                    (if (find c *eliza-punct-chars* :test #'char-equal)
                        (write-char #\Space out) ; Reemplazar puntuacion por espacio
                        (write-char c out))))))  ; Conservar caracteres normales
      ;; Separar por espacios
      (let ((tokens '())
            (cur ""))
        (loop for c across clean-str do
             (if (eliza--space-p c)
                 (when (> (length cur) 0)
                   (push cur tokens)
                   (setf cur ""))
                 (setf cur (concatenate 'string cur (string c)))))
        (when (> (length cur) 0) (push cur tokens))
        (nreverse tokens)))))

(defun element-match-p (templ-el token)
  (cond
    ((null templ-el) t)
    ;; Si el template tiene una "s", es un comodin
    ((and (stringp templ-el) (string= templ-el "s"))
     (not (null token))) 
    ;; Si es texto normal, debe coincidir exactamente
    ((stringp templ-el)
     (and token (string= templ-el token)))
    (t nil)))

(defun match-template (stim input)
  (labels ((rec (slist ilist)
             (cond
               ((null slist) (null ilist)) 
               ((null ilist) nil)          
               ;; Manejo del comodin 's'
               ((string= (first slist) "s") 
                (or (rec (rest slist) (rest ilist))   
                    (rec slist (rest ilist))))        
               (t
                ;; Comparacion palabra por palabra
                (if (element-match-p (first slist) (first ilist))
                    (rec (rest slist) (rest ilist))
                    nil)))))
    (rec stim input)))

(defparameter *base-datos-medica*
  '(
    ;; RESPIRATORIAS
    ("fiebre" "dificultad_respirar" "COVID-19" 
     "Aislamiento total, oximetro y paracetamol" 
     "Neumologo" 
     "Hospital Victoria Medical Center, Av. Acueducto 2800 (Chapultepec Norte)")

    ("tos" "perdida_olfato" "COVID-19" 
     "Aislamiento, reposo y monitoreo de oxigenacion" 
     "Infectologo" 
     "Hospital Civil Dr. Miguel Silva, Calle Isidro Huarte S/N")

    ("cuerpo_cortado" "estornudos" "Gripe Estacional" 
     "Tomar muchos liquidos, vitamina C y antigripales" 
     "Medico General" 
     "Farmacias del Ahorro, Consultorios Simi o Cruz Roja en el Centro Historico")

    ("falta_aire" "silbido_pecho" "Asma" 
     "Inhalador de rescate (salbutamol) y evitar el polvo" 
     "Alergologo" 
     "Torre Medica de Especialidades, Consultorio 204")

    ("tos" "silbido_al_respirar" "Tosferina" 
     "Antibioticos especificos y reposo absoluto" 
     "Pediatra" 
     "Hospital Infantil Eva Samano de Lopez Mateos, Bosque Cuauhtemoc")

    ;; CORAZON
    ("dolor_pecho" "brazo_izquierdo" "INFARTO" 
     "URGENTE toma una Aspirina masticada y llamar ambulancia" 
     "Cardiologo" 
     "Hospital Star Medica, Virrey de Mendoza 2000, Col. Felix Ireta")

    ("dolor_cabeza" "zumbido_oidos" "Hipertension" 
     "Dieta baja en sal, ejercicio y captopril" 
     "Cardiologo" 
     "Hospital Star Medica, Virrey de Mendoza 2000, Col. Felix Ireta")

    ;; ESTOMACALES
    ("dolor_estomago" "ardor" "Gastritis" 
     "Omeprazol en ayunas y evitar picante" 
     "Gastroenterologo" 
     "Hospital Angeles Morelia, Av. Montana Monarca Norte 331 (Altozano)")

    ("vomito" "diarrea" "Infeccion Estomacal" 
     "Suero oral y dieta blanda" 
     "Gastroenterologo" 
     "Hospital Angeles Morelia, Av. Montana Monarca Norte 331 (Altozano)")
    
    ("diarrea" "dolor_estomago" "Infeccion Estomacal" 
     "Suero oral, hidratacion y dieta blanda" 
     "Gastroenterologo" 
     "Hospital Angeles Morelia, Av. Montana Monarca Norte 331 (Altozano)")

    ("dolor_lado_derecho" "fiebre" "Apendicitis" 
     "Cirugia de emergencia (Apendicectomia)" 
     "Cirujano" 
     "Hospital Civil Dr. Miguel Silva, Calle Isidro Huarte S/N")

    ;; VIRALES PIEL
    ("dolor_huesos" "dolor_ojos" "Dengue" 
     "Reposo, hidratacion y NO tomar aspirina" 
     "Internista" 
     "IMSS Hospital General Regional No 1 (Charo)")

    ("granitos" "comezon" "Varicela" 
     "Banos coloidales y no rascarse" 
     "Pediatra" 
     "Hospital Infantil Eva Samano de Lopez Mateos")

    ("manchas" "falta_sensibilidad" "Lepra" 
     "Tratamiento largo con antibioticos" 
     "Dermatologo" 
     "Centro Dermatologico de Morelia 'Dr. Ladislao de la Pascua' (Calle J. J. Tablada)")

    ("paralisis" "fiebre" "Poliomielitis" 
     "Fisioterapia para recuperar movilidad" 
     "Ortopedista" 
     "Clinica de Fracturas y Esguinces, Calle 5 de Febrero")
    
    ;; MAS 
    ("vision_borrosa" "asco_luz" "Migrana" 
     "Dormir a oscuras y ketorolaco" 
     "Neurologo" 
     "Hospital Memorial, Av. Camelinas (frente a Plaza Fiesta)")

    ("ojos_rojos" "laganas" "Conjuntivitis" 
     "Gotas antibioticas y lavar ojos" 
     "Oftalmologo" 
     "Hospital de la Luz o Clinica Sala Uno Morelia")

    ("mucha_sed" "perdida_peso" "Diabetes" 
     "Insulina o metformina, y dieta sin azucar" 
     "Endocrinologo" 
     "Hospital de la Mujer o Star Medica")

    ("taquicardia" "falta_aire" "Ansiedad" 
     "Terapia y ejercicios de respiracion" 
     "Psicologo" 
     "Centro de Atencion Psicologica (CAPS) o Clinica de la Facultad de Psicologia UMSNH")
    ))

;; FAMILIA
(defparameter *conteos-familia*
  '(
    ("hombres" . "En tu familia hay registrados 16 hombres incluyendo personajes de la pelicula de shrek.")
    ("mujeres" . "de tu familia hay registro de 5 mujeres en la familia.")
    ("integrantes" . "En total son como 21 integrantes contando a las mascotas.")
    ("hermanos" . "Solo tienes 1 hermano tu gemelo Luis.")
    ("tios" . "Tienes 4 tios registrados, estos son Fernando, Rafa, Juan y David.")
    ("abuelos" . "Tienes 2 abuelos registrados: Baltazar y Gilberto.")
    ("nietos" . "Hay 2 nietos hombres registrados, solo tu y tu hermano, Balty, Luis.")
    ("padres" . "Hay 4 padres de familia registrados.")
   ))

(defun imprimir-receta-medica (nombre trata doc dir)
  (format t "DIAGNOSTICO CONFIRMADO~%")
  (format t "La enfermedad que te fue detectada es ~a~%" nombre)
  (format t "El tratamiento recomendado es ~a~%" trata)
  (format t "Ve con el especialista ~a~%" doc)
  (format t "Si estas en Morelia te recomiendo ir al ~a~%" dir))

(defun diagnosticar-sintoma-simple (sintoma-usuario)
  (let ((registro (find sintoma-usuario *base-datos-medica* :test #'string-equal 
                        :key #'first)))
    
    (if registro
        (let ((sintoma2 (second registro))
              (nombre   (third registro))
              (trata    (fourth registro))
              (doc      (fifth registro))
              (dir      (sixth registro)))
          
          (format t "~%BotHype> Entonces Para descartar ~a...~%" nombre)
          (format t "BotHype> Tienes ~a? (si/no)~%" sintoma2)
          (format t "TU> ")
          (finish-output)
          
          ;; Leemos la respuesta del usuario
          (let* ((linea (read-line))
                 (resp-tokens (clean-and-tokenize linea)))
            
            ;; Verificamos si dijo que si o que nomenciono el sintoma
            (if (or (find "si" resp-tokens :test #'string-equal)
                    (find sintoma2 resp-tokens :test #'string-equal))
                
                (imprimir-receta-medica nombre trata doc dir)
                
                (progn
                  (format t "BotHype> Ah, ok. Entonces NO es ~a.~%" nombre)
                  (format t "BotHype> Si no tienes ~a, probablemente no sea grave.~%" sintoma2)
                  (format t "Descansa un rato.~%")))))
        
        (format t "BotHype> Ese sintoma (~a) es muy generico o no lo conozco. Checate los signos vitales.~%" sintoma-usuario))))

(defun diagnosticar-sintoma-doble (s1 s2)
  (format t "~%BotHype> A ver, dices que tienes ~a y ~a... Dejame analizar.~%" s1 s2)
  
  ;; Checamos (S1, S2) o (S2, S1)
  (let ((match-exacto 
         (find-if (lambda (e) 
                    (or (and (string-equal (first e) s1) (string-equal (second e) s2))
                        (and (string-equal (first e) s2) (string-equal (second e) s1))))
                  *base-datos-medica*)))
    
    (if match-exacto
        ;; Si cinciden los dos sintomas con la misma enfermedad le damos la que tiene 
        (progn
          (format t "~%BotHype> Esos dos sintmas que tienes, corresponden a una sola enfermedad.~%")
          (imprimir-receta-medica (third match-exacto) 
                                  (fourth match-exacto) 
                                  (fifth match-exacto) 
                                  (sixth match-exacto)))
        
        ;; si no coinciden con la misma enf le damos analisis separados
        (progn
          (format t "~%BotHype> Ojo aqui Esos sintomas NO corresponden a la misma enfermedad.~%")
          (format t "BotHype> Probablemente tengas dos cosas distintas. Vamos a checarlos por separado.~%")
          
          ;; Analisis del primer sintoma
          (format t "~%el primer sintoma que tienes es '~a'...~%" s1)
          (diagnosticar-sintoma-simple s1)
          
          (format t "~%--------------------------------------------------~%")
          
          ;; Analisis del segundo sintoma
          (format t "tu segundo sintoma es '~a'...~%" s2)
          (diagnosticar-sintoma-simple s2)))))

(defun realizar-conteo (tipo)
  (let ((dato (assoc tipo *conteos-familia* :test #'string-equal)))
    (if dato
        (format t "BotHype> ~a~%" (cdr dato))
        (format t "BotHype> Híjole, no tengo el dato exacto de cuantos ~a son.~%" tipo))))

(defparameter *templates*
  (list
   ;; SALUDOS
   (list (list "hola" "s") 
         (list "Hola" "soy" "BotHype." "Preguntame" "de" "medicina" "o" "familia") nil)
   (list (list "hola") 
         (list "Que" "onda" "amigo." "En" "que" "te" "ayudo?") nil)
   (list (list "te" "gusta" "el" "futbol") 
         (list "Si" "le" "voy" "a" "las" "Chivas" "Rayadas") nil)

   ;; CONTEOS DE LA FAMILY
   (list (list "cuantos" "hombres" "hay")      (list "COUNT_OP" "hombres") nil)
   (list (list "cuantos" "hombres" "son")      (list "COUNT_OP" "hombres") nil)
   (list (list "cuantas" "mujeres" "hay")      (list "COUNT_OP" "mujeres") nil)
   (list (list "cuantas" "mujeres" "son")      (list "COUNT_OP" "mujeres") nil)
   (list (list "cuantos" "integrantes" "son")  (list "COUNT_OP" "integrantes") nil)
   (list (list "cuantos" "hermanos" "tengo")   (list "COUNT_OP" "hermanos") nil)
   (list (list "cuantos" "tios" "tengo")       (list "COUNT_OP" "tios") nil)
   (list (list "cuantos" "abuelos" "hay")      (list "COUNT_OP" "abuelos") nil)
   (list (list "cuantos" "nietos" "hay")       (list "COUNT_OP" "nietos") nil)
   (list (list "cuantos" "padres" "hay")       (list "COUNT_OP" "padres") nil)

   ;; DATOS FAMILIARES 
   (list (list "quien" "es" "el" "papa" "de" "balty") (list "El" "papa" "de" "Balty" "es" "Luis" "Perez") nil)
   (list (list "quien" "es" "la" "mama" "de" "balty") (list "La" "mama" "de" "Balty" "es" "Claudia" "Sierra") nil)
   (list (list "quien" "es" "mi" "mama") (list "Tu" "mama" "es" "Claudia" "Sierra") nil)
   (list (list "quien" "es" "mi" "papa") (list "Tu" "papa" "es" "Luis" "Perez") nil)
   (list (list "quien" "es" "la" "mama" "de" "mi" "hermano") (list "La" "mama" "de" "Luis" "es" "Claudia" "Sierra") nil)
   (list (list "quien" "es" "el" "papa" "de" "mi" "hermano") (list "El" "papa" "de" "tu" "hermano" "es" "Luis" "Perez" "Martinez") nil)
   
   ;; ABUELOS Y TIOS
   (list (list "quien" "es" "mi" "abuelo" "paterno") (list "Tu" "abuelo" "paterno" "es" "Baltazar" "Perez") nil)
   (list (list "quien" "es" "mi" "abuela" "paterna") (list "Tu" "abuela" "paterna" "es" "Elvira" "Martinez") nil)
   (list (list "quien" "es" "mi" "abuelo" "materno") (list "Tu" "abuelo" "materno" "es" "Gilberto" "Sierra") nil)
   (list (list "quien" "es" "mi" "abuela" "materna") (list "Tu" "abuela" "materna" "es" "Sahara" "Zaragoza") nil)
   (list (list "quienes" "son" "mis" "tios" "maternos") (list "Tus" "tios" "maternos" "son" "Juan" "y" "David" "Sierra") nil)
   (list (list "quienes" "son" "mis" "tios") (list "Tus" "tios" "son" "Juan" "David" "Fernando" "y" "Rafa") nil)

   ;; MASCOTA 
   (list (list "quien" "es" "la" "mascota") (list "Tienen" "una" "perra" "llamada" "Sheyla") nil)

   ;; CINE Y SHREK 
   (list (list "quien" "es" "shrek") (list "Es" "un" "ogro" "verde" "casado" "con" "Fiona") nil)
   (list (list "quien" "es" "el" "suegro" "de" "shrek") (list "El" "suegro" "es" "el" "Rey" "Harold") nil)
   (list (list "quien" "es" "burro") (list "El" "mejor" "amigo" "de" "Shrek") nil)
   (list (list "de" "que" "trata" "la" "pelicula" "de" "shrek") (list "Trata" "de" "un" "ogro" "que" "vive" "en" "un" "pantano") nil)

   ;;LOGICA MEDICA
   (list (list "tengo" "s" "y" "s") (list "MEDICAL_DOUBLE_OP") nil)

   ;; UN SOLO SINTOMA
   (list (list "tengo" "s") (list "MEDICAL_SIMPLE_OP") nil)
   (list (list "me" "duele" "s") (list "MEDICAL_SIMPLE_OP") nil)
   (list (list "me" "duele" "el" "s") (list "MEDICAL_SIMPLE_OP") nil)
   (list (list "me" "duele" "la" "s") (list "MEDICAL_SIMPLE_OP") nil)
   (list (list "siento" "s") (list "MEDICAL_SIMPLE_OP") nil)
   (list (list "me" "dio" "s") (list "MEDICAL_SIMPLE_OP") nil)

   (list (list "s") (list "No" "te" "entiendo" "bien." "Intenta" "preguntar" "quien" "es" "mi" "papa" "o" "tengo" "tos") nil)
   ))

(defun find-matching-template (input)
  (find-if (lambda (tpl)
             (match-template (first tpl) input))
           *templates*))

(defun respond-to (input)
  (let ((tpl (find-matching-template input)))
    (when tpl
      (let ((resp (second tpl)))
        
        ;; Decidimos que hacer segun la etiqueta de respuesta
        (cond
            ;; SI ES DOBLE SINTOMA
          ((equal (first resp) "MEDICAL_DOUBLE_OP")
           (let ((s1 (nth 1 input))
                 (s2 (nth 3 input)))
             (diagnosticar-sintoma-doble s1 s2)))
          
          ;; SI ES SINTOMA SIMPLE
          ((equal (first resp) "MEDICAL_SIMPLE_OP")
           (let ((sintoma (car (last input))))
             (diagnosticar-sintoma-simple sintoma)))
          
          ((equal (first resp) "COUNT_OP")
           (realizar-conteo (second resp)))
          
          (t
           (format t "BotHype> ~{~a~^ ~}~%" resp)))))))

;;LOOP
(defun eliza ()
  (format t "  PROYECTO FINAL ELIZA LISP    ~%")
  (format t "Hola! Soy BotHype. Escribe 'adios' para salir.~%~%")
  
  (loop
     (format t "TU> ")
     (finish-output)
     (let ((line (read-line)))
       ;; Checar salida
       (when (or (string-equal line "adios") 
                 (string-equal line "bye")
                 (string-equal line "salir"))
         (format t "BotHype> Sobres, bye. Cuidate.~%")
         (return))
       
       ;; Procesar entrada
       (let ((tokens (clean-and-tokenize line)))
         (if tokens
             (respond-to tokens)
             (format t "BotHype> No escribiste nada, carnal.~%"))))))
2. Código en Prolog (eliza.pl)
Prolog

% PROYECTO FINAL ELIZA PROLOG BALTY

hombre(balty).
hombre(luis_perez_sierra).
hombre(luis_perez).        
hombre(juan_sierra).       
hombre(david_sierra).      
hombre(fernando_perez).    
hombre(rafa_perez).        
hombre(gilberto_sierra).   
hombre(baltazar_perez).
hombre(shrek). 
hombre(burro).
hombre(harold).
hombre(farquaad).
hombre(gato_con_botas). 
hombre(chicharito).
hombre(messi).

mujer(claudia_sierra).     
mujer(lupita_sierra).      
mujer(sahara_zaragoza).    
mujer(elvira_martinez).    
mujer(fiona).

perra(sheyla).

% RELACIONES DE FAMILIA
progenitor(baltazar_perez, luis_perez).
progenitor(elvira_martinez, luis_perez).
progenitor(baltazar_perez, fernando_perez).
progenitor(elvira_martinez, fernando_perez).
progenitor(baltazar_perez, rafa_perez).
progenitor(elvira_martinez, rafa_perez).

progenitor(gilberto_sierra, claudia_sierra).
progenitor(sahara_zaragoza, claudia_sierra).
progenitor(gilberto_sierra, juan_sierra).
progenitor(sahara_zaragoza, juan_sierra).
progenitor(gilberto_sierra, david_sierra).
progenitor(sahara_zaragoza, david_sierra).
progenitor(gilberto_sierra, lupita_sierra).
progenitor(sahara_zaragoza, lupita_sierra).

progenitor(luis_perez, balty).
progenitor(claudia_sierra, balty).
progenitor(luis_perez, luis_perez_sierra).
progenitor(claudia_sierra, luis_perez_sierra).

progenitor(harold, fiona). 
pareja(shrek, fiona).
pareja(fiona, shrek).
amigo(shrek, burro).
amigo(shrek, gato_con_botas).
enemigo(shrek, farquaad).

dueno(claudia_sierra, sheyla).

% REGLAS FAMILIARES
padre(P, H) :- progenitor(P, H), hombre(P).
madre(M, H) :- progenitor(M, H), mujer(M).
hermano(X, Y) :- padre(P, X), padre(P, Y), madre(M, X), madre(M, Y), X \= Y, hombre(X).
hermana(X, Y) :- padre(P, X), padre(P, Y), madre(M, X), madre(M, Y), X \= Y, mujer(X).
tio(T, S) :- progenitor(P, S), hermano(T, P).
tia(T, S) :- progenitor(P, S), hermana(T, P).
abuelo(A, N) :- progenitor(P, N), padre(A, P).
abuela(A, N) :- progenitor(P, N), madre(A, P).
nieto(N, A) :- progenitor(A, P), progenitor(P, N), hombre(N).
nieta(N, A) :- progenitor(A, P), progenitor(P, N), mujer(N).
suegro(Suegro, Yerno) :- pareja(Yerno, Esposa), padre(Suegro, Esposa).



% MEDICAA

% Respiratorias
enfermedad(covid, fiebre, dificultad_respirar).
enfermedad(covid, tos, perdida_olfato).
enfermedad(gripe, fiebre, cuerpo_cortado).
enfermedad(gripe, escurrimiento_nasal, estornudos).
enfermedad(asma, falta_aire, silbido_pecho).
enfermedad(tosferina, tos, silbido_al_respirar).

% Corazon
enfermedad(hipertension, dolor_cabeza, zumbido_oidos).
enfermedad(infarto, dolor_pecho, brazo_izquierdo).

% Estomacales
enfermedad(gastritis, dolor_estomago, ardor).
enfermedad(infeccion_estomacal, dolor_estomago, vomito).

enfermedad(infeccion_estomacal, diarrea, dolor_estomago). 
enfermedad(apendicitis, dolor_lado_derecho, fiebre).

% Virales/Piel
enfermedad(dengue, fiebre, dolor_huesos).
enfermedad(varicela, granitos, comezon).
enfermedad(lepra, manchas, falta_sensibilidad).
enfermedad(poliomielitis, paralisis, fiebre).

% Otras
enfermedad(migrana, dolor_cabeza, vision_borrosa).
enfermedad(conjuntivitis, ojos_rojos, laganas).
enfermedad(diabetes, mucha_sed, perdida_peso).
enfermedad(ansiedad, taquicardia, falta_aire).


% TRATAMIENTOS
tratamiento(covid, 'Aislamiento total, oximetro y paracetamol').
tratamiento(gripe, 'Tomar muchos liquidos, vitamina C y antigripales').
tratamiento(asma, 'Inhalador de rescate (salbutamol) y evitar el polvo').
tratamiento(tosferina, 'Antibioticos especificos y reposo absoluto').
tratamiento(hipertension, 'Dieta baja en sal, ejercicio y captopril').
tratamiento(infarto, 'URGENTE: Aspirina masticada y llamar ambulancia').
tratamiento(gastritis, 'Omeprazol en ayunas y evitar picante').
tratamiento(infeccion_estomacal, 'Suero oral y dieta blanda').
tratamiento(apendicitis, 'Cirugia de emergencia (Apendicectomia)').
tratamiento(dengue, 'Reposo, hidratacion y NO tomar aspirina').
tratamiento(varicela, 'Banos coloidales y no rascarse').
tratamiento(lepra, 'Tratamiento largo con antibioticos').
tratamiento(poliomielitis, 'Fisioterapia para recuperar movilidad').
tratamiento(migrana, 'Dormir a oscuras y ketorolaco').
tratamiento(conjuntivitis, 'Gotas antibioticas y lavar ojos').
tratamiento(diabetes, 'Insulina o metformina, y dieta sin azucar').
tratamiento(ansiedad, 'Terapia y ejercicios de respiracion').


% DOCTORES 
doctor(covid, neumologo).
doctor(gripe, medico_general).
doctor(asma, alergologo).
doctor(tosferina, pediatra).
doctor(hipertension, cardiologo).
doctor(infarto, cardiologo).
doctor(gastritis, gastroenterologo).
doctor(infeccion_estomacal, gastroenterologo).
doctor(apendicitis, cirujano).
doctor(dengue, internista).
doctor(varicela, pediatra).
doctor(lepra, dermatologo).
doctor(poliomielitis, ortopedista).
doctor(migrana, neurologo).
doctor(conjuntivitis, oftalmologo).
doctor(diabetes, endocrinologo).
doctor(ansiedad, psicologo).



% DIRECCIONES REALES AQUI EN MORELIA

direccion_morelia(neumologo, 'Hospital Victoria Medical Center, Av. Acueducto 2800 (Chapultepec Norte)').
direccion_morelia(medico_general, 'Farmacias del Ahorro, Consultorios Simi o Cruz Roja en el Centro Historico').
direccion_morelia(alergologo, 'Torre Medica de Especialidades, Consultorio 204').
direccion_morelia(pediatra, 'Hospital Infantil Eva Samano de Lopez Mateos, Bosque Cuauhtemoc').
direccion_morelia(cardiologo, 'Hospital Star Medica, Virrey de Mendoza 2000, Col. Felix Ireta').
direccion_morelia(gastroenterologo, 'Hospital Angeles Morelia, Av. Montana Monarca Norte 331 (Altozano)').
direccion_morelia(cirujano, 'Hospital Civil Dr. Miguel Silva, Calle Isidro Huarte S/N').
direccion_morelia(internista, 'IMSS Hospital General Regional No 1 (Charo)').
direccion_morelia(dermatologo, 'Centro Dermatologico de Morelia "Dr. Ladislao de la Pascua" (Calle J. J. Tablada)').
direccion_morelia(ortopedista, 'Clinica de Fracturas y Esguinces, Calle 5 de Febrero').
direccion_morelia(neurologo, 'Hospital Memorial, Av. Camelinas (frente a Plaza Fiesta)').
direccion_morelia(oftalmologo, 'Hospital de la Luz o Clinica Sala Uno Morelia').
direccion_morelia(endocrinologo, 'Hospital de la Mujer o Star Medica').
direccion_morelia(psicologo, 'Centro de Atencion Psicologica (CAPS) o Clinica de la Facultad de Psicologia UMSNH').




% MOTOR match

match([], _).

match([s(Var)|Stim], [I|Input]) :-
    Var = I,
    match(Stim, Input), !.

match([Word|Stim], [Word|Input]) :-
    atom(Word),
    match(Stim, Input), !.

match(Stim, [_|Input]) :-
    match(Stim, Input).




% TEMPALESSSS

% SALUDOS 
template([hola], ['Hola', soy, 'BotHype', dime, en, que, te, ayudo], []).
template([que, onda], ['Que', tal, amigo, pregunta, con, confianza], []).
template([te, gusta, el, futbol], ['Si', le, voy, a, las, 'Chivas'], []).

% PREGUNTAS DE CONTEO
template([cuantos, hombres, hay], [flagContarHombres], []).
template([cuantos, hombres, son], [flagContarHombres], []).
template([cuantas, mujeres, hay], [flagContarMujeres], []).
template([cuantas, mujeres, son], [flagContarMujeres], []).
template([cuantos, integrantes, son], [flagContarTotal], []).

template([cuantos, abuelos, hay], [flagContarAbuelos], []).
template([cuantos, nietos, hay], [flagContarNietos], []).
template([cuantos, padres, hay], [flagContarPadres], []).
template([cuantos, hermanos, hay], [flagContarHermanos], []).
template([cuantos, tios, hay], [flagContarTios], []).




% FAMILIA  PAPAS 
template([quien, es, el, papa, de, s(Persona)], [flagPadre], [Persona]).
template([quien, es, la, mama, de, s(Persona)], [flagMadre], [Persona]).
template([quien, es, mi, papa], [flagPadre], [balty]).
template([quien, es, mi, mama], [flagMadre], [balty]).

% FAMILIA HERMANOS
template([quien, es, el, hermano, de, s(Persona)], [flagHermano], [Persona]).
template([quienes, son, los, hermanos, de, s(Persona)], [flagHermano], [Persona]).

% FAMILIA TIOS
template([quien, es, el, tio, de, s(Persona)], [flagTios], [Persona]).
template([quienes, son, los, tios, de, s(Persona)], [flagTios], [Persona]).

% FAMILIA ABUELOS
template([quienes, son, los, abuelos, de, s(Persona)], [flagAbuelos], [Persona]).

% FAMILIA NIETOS
template([quienes, son, los, nietos, de, s(Persona)], [flagNietos], [Persona]).

% FAMILIA MASCOTA
template([quien, es, la, mascota, de, s(Persona)], [flagMascota], [Persona]).

% CINE SHREK
template([quien, es, el, suegro, de, s(Persona)], [flagSuegro], [Persona]).
template([quienes, son, los, amigos, de, s(Persona)], [flagAmigos], [Persona]).
template([quien, es, el, enemigo, de, s(Persona)], [flagEnemigo], [Persona]).
template([quien, es, la, pareja, de, s(Persona)], [flagPareja], [Persona]).

template([quien, es, shrek], ['Es', un, ogro, verde, bien, chido], []).
template([quien, es, fiona], ['Es', la, esposa, de, 'Shrek'], []). 

% PREGUNTAS DIRECTAS DE UBICACION
template([donde, me, atiendo, si, tengo, s(Enfermedad)], [flagDondeAtender], [Enfermedad]).
template([donde, puedo, tratar, la, s(Enfermedad)], [flagDondeAtender], [Enfermedad]).


% MEDICINA
template([tengo, s(S1), y, s(S2)], [flagMedicinaDoble], [S1, S2]).

template([tengo, s(Sintoma)], [flagMedicina], [Sintoma]).
template([me, duele, s(Sintoma)], [flagMedicina], [Sintoma]).
template([me, duele, el, s(Sintoma)], [flagMedicina], [Sintoma]).
template([me, duele, la, s(Sintoma)], [flagMedicina], [Sintoma]).
template([siento, s(Sintoma)], [flagMedicina], [Sintoma]).
template([me, dio, s(Sintoma)], [flagMedicina], [Sintoma]).


template(_, ['No', te, entendi, escribelo, bien, porfa], []).


% PROCESARRR
eliza_process(Input) :-
    template(Stim, Resp, Vars),
    match(Stim, Input),
    nth0(0, Resp, Flag), 
    tratar_respuesta(Flag, Vars, Input),
    !.


% BANDERAS GENERICAS

tratar_respuesta(Flag, _, Input) :-
    \+ member(Flag, [
        flagPadre, flagMadre, flagHermano, flagTios, flagAbuelos, flagPrimos, flagNietos, 
        flagMascota, flagSuegro, flagAmigos, flagEnemigo, flagPareja, 
        flagMedicina, flagMedicinaDoble, flagDondeAtender, 
        flagContarHombres, flagContarMujeres, flagContarTotal,
        flagContarAbuelos, flagContarNietos, flagContarPadres, flagContarHermanos, flagContarTios
    ]),
    template(Stim, R, _), 
    match(Stim, Input), 
    write('BotHype: '), 
    imprimir_lista(R),  
    nl, !.



% BANDERAS DE CONTEO
tratar_respuesta(flagContarHombres, _, _) :-
    findall(X, hombre(X), Lista),
    length(Lista, N),
    write('BotHype: En tu familia hay '), write(N), writeln(' hombres registrados.'), !.

tratar_respuesta(flagContarMujeres, _, _) :-
    findall(X, mujer(X), Lista),
    length(Lista, N),
    write('BotHype: En tu familia hay '), write(N), writeln(' mujeres registradas.'), !.

tratar_respuesta(flagContarTotal, _, _) :-
    findall(X, hombre(X), L1), length(L1, N1),
    findall(Y, mujer(Y), L2), length(L2, N2),
    Total is N1 + N2,
    write('BotHype: En total son '), write(Total), writeln(' integrantes en tu familia.'), !.




% ABUELOS
tratar_respuesta(flagContarAbuelos, _, _) :-
  
    findall(X, abuelo(X, _), ListaSucia),
    sort(ListaSucia, ListaUnica), 
    length(ListaUnica, N),        
    write('BotHype: Hay '), write(N), writeln(' abuelos registrados.'), !.

% NIETOS
tratar_respuesta(flagContarNietos, _, _) :-
    findall(X, nieto(X, _), ListaSucia),
    sort(ListaSucia, ListaUnica),
    length(ListaUnica, N),
    write('BotHype: Hay '), write(N), writeln(' nietos hombres registrados.'), !.

% PADRES 
tratar_respuesta(flagContarPadres, _, _) :-
    findall(X, padre(X, _), ListaSucia),
    sort(ListaSucia, ListaUnica),
    length(ListaUnica, N),
    write('BotHype: Hay '), write(N), writeln(' padres de familia.'), !.

% HERMANOS 
tratar_respuesta(flagContarHermanos, _, _) :-
    findall(X, hermano(X, _), ListaSucia),
    sort(ListaSucia, ListaUnica),
    length(ListaUnica, N),
    write('BotHype: Hay '), write(N), writeln(' hermanos hombres en la lista.'), !.

% TIOS
tratar_respuesta(flagContarTios, _, _) :-
    findall(X, tio(X, _), ListaSucia),
    sort(ListaSucia, ListaUnica),
    length(ListaUnica, N),
    write('BotHype: Hay '), write(N), writeln(' tios registrados.'), !.






% FAMILIA
tratar_respuesta(flagPadre, [Persona], _) :-
    write('BotHype: Buscando papa de '), write(Persona), nl,
    (padre(X, Persona) -> (write('el papa Es: '), writeln(X)) ; writeln(' No se quien es su papa.')).

tratar_respuesta(flagMadre, [Persona], _) :-
    write('BotHype: Buscando mama de '), write(Persona), nl,
    (madre(X, Persona) -> (write('la mama Es: '), writeln(X)) ; writeln(' No se quien es su mama.')).

tratar_respuesta(flagHermano, [Persona], _) :-
    write('BotHype: Hermanos de '), write(Persona), nl,
    (hermano(X, Persona), write('- '), writeln(X), fail ; true).

tratar_respuesta(flagTios, [Persona], _) :-
    write('BotHype: Tios de '), write(Persona), nl,
    (tio(T, Persona), write('- Tio: '), writeln(T), fail ; true),
    (tia(A, Persona), write('- Tia: '), writeln(A), fail ; true).

tratar_respuesta(flagAbuelos, [Persona], _) :-
    write('BotHype: Abuelos de '), write(Persona), nl,
    (abuelo(A, Persona), write('- Abuelo: '), writeln(A), fail ; true),
    (abuela(B, Persona), write('- Abuela: '), writeln(B), fail ; true).

tratar_respuesta(flagNietos, [Persona], _) :-
    write('BotHype: Nietos de '), write(Persona), nl,
    (nieto(N, Persona), write('- Nieto: '), writeln(N), fail ; true),
    (nieta(M, Persona), write('- Nieta: '), writeln(M), fail ; true).

tratar_respuesta(flagMascota, [Persona], _) :-
    (dueno(Persona, M) -> (write('BotHype: Su mascota es '), writeln(M)) ; writeln('-> No tiene mascota.')).

tratar_respuesta(flagSuegro, [Persona], _) :-
    (suegro(X, Persona) -> (write('BotHype: El suegro es '), writeln(X)) ; writeln('-> No tiene suegro.')).

tratar_respuesta(flagAmigos, [Persona], _) :-
    write('BotHype: Amigos de '), write(Persona), nl,
    (amigo(Persona, X), write('- '), writeln(X), fail ; true).

tratar_respuesta(flagEnemigo, [Persona], _) :-
    (enemigo(Persona, X) -> (write('BotHype: Su enemigo es '), writeln(X)) ; writeln('-> No tiene enemigos.')).

tratar_respuesta(flagPareja, [Persona], _) :-
    (pareja(Persona, X) -> (write('BotHype: Su pareja es '), writeln(X)) ; writeln('Esta soltero.')).




% PREGUNTAS DE UBICACION 

tratar_respuesta(flagDondeAtender, [Enfermedad], _) :-
    write('BotHype: Buscando donde tratar la '), write(Enfermedad), writeln(' en Morelia...'),
    (doctor(Enfermedad, Doc) ->
        (
            direccion_morelia(Doc, Ubicacion),
            write('Tienes que ir con un '), writeln(Doc),
            write('Si estas en Morelia puedes ir al '), writeln(Ubicacion)
        )
    ;
        writeln('Híjole, esa enfermedad no la tengo registrada. Busca en Google.')
    ).


tratar_respuesta(flagMedicinaDoble, [S1, S2], _) :-
    write('BotHype: A ver, dices que tienes '), write(S1), write(' y '), write(S2), writeln('...'),
    

    % una enfermedad que tenga l0s dos sintomasss
    ( (enfermedad(Enf, S1, S2) ; enfermedad(Enf, S2, S1)) ->
        (
            nl, write(' DIAGNOSTICO CONFIRMADO POR DOBLE SINTOMA '), nl,
            write('Coincide perfectamente con: '), writeln(Enf),
            tratamiento(Enf, T),
            write('Tratamiento: '), writeln(T),
            doctor(Enf, D), direccion_morelia(D, Dir),
            write('Ve con el especialista: '), writeln(D), write('En Morelia: '), writeln(Dir)
        )
    ;
        % si no le revisamos uno y despues otro
        (
            nl, writeln('BotHype: Esos sintomas son de enfermedades distintas. Vamos a checarlos por separado.'),
            
            nl, write('Tu primer sintoma es '), write(S1), writeln('...'),
            (diagnosticar_enfermedad(S1, []) -> true ; writeln('No se confirmo nada grave con este sintoma.')),
            
            nl, writeln('--------------------------------------------------'),
            
            write('El segundo sintoma es'), write(S2), writeln('...'),
            (diagnosticar_enfermedad(S2, []) -> true ; writeln('No se confirmo nada grave con este sintoma.'))
        )
    ), !.


tratar_respuesta(flagMedicina, [Sintoma1], Input) :-
    write('BotHype: Dices que tienes '), write(Sintoma1), writeln('...'),
    (
        diagnosticar_enfermedad(Sintoma1, Input)
    ;
        writeln('Mmm, ya revise los datos y no cuadra nada con ese sintoma. Ve al doctor general.')
    ), !. 


diagnosticar_enfermedad(Sintoma1, Input) :-
    enfermedad(Enf, Sintoma1, Sintoma2), 
    
    ( member(Sintoma2, Input) ->
        (
            nl, write('BotHype: Ah, ya veo que tambien mencionaste '), writeln(Sintoma2),
            imprimir_resultado(Enf)
        )
    ;
        (
            nl, write('BotHype: A ver, para descartar '), write(Enf), write('... tienes '), write(Sintoma2), write('?'), nl,
            write('TU> '),
            read_line_to_string(user_input, RespuestaRaw),
            atomic_list_concat(ListaPalabras, ' ', RespuestaRaw),
            
            ( (member(si, ListaPalabras) ; member(Sintoma2, ListaPalabras)) ->
                imprimir_resultado(Enf) 
            ;
                fail 
            )
        )
    ).


imprimir_resultado(Enf) :-
    nl, write(' DIAGNOSTICO CONFIRMADO '), nl,
    write('La Enfermedad detectada es '), writeln(Enf),
    tratamiento(Enf, T),
    write('Entonces tienes que seguir el tratamiento de '), writeln(T),
    
    % UBICACION
    doctor(Enf, D),
    direccion_morelia(D, Dir),
    
    write('Tienes que ir con el especialista '), writeln(D),
    write('Si estas en Morelia puedes ir al '), writeln(Dir),
    true.


imprimir_lista([]).
imprimir_lista([H|T]) :- write(H), write(' '), imprimir_lista(T).


% LOOP PRINCIPAL
eliza :-
    writeln('  PROYECTO FINAL ELIZA PROLOG BALTAZAR (GUIA SALUD MORELIA - FINAL) '),
    writeln('&*&*&*&*&*&*&*&*&*&&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*'),
    writeln('Escribe "adios" para salir.'), nl,
    loop.

loop :-
    write('TU> '),
    read_line_to_string(user_input, String),
    (String == "adios" -> writeln('Sobres, bye.') ;
     String == "bye" -> writeln('Sobres, bye.') ;
        (
            atomic_list_concat(List, ' ', String),
            eliza_process(List),
            loop
        )
    ).
📝 Autor
Baltazar (Balty)
Proyecto Final de Programación Lógica y Funcional.
