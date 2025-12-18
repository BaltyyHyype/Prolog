
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




