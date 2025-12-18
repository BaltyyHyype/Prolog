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