%%Bienvenida de eliza
%%Funciona al poner eliza.
eliza:-	writeln('Hola, mi nombre es  Eliza tu  chatbot, por favor ingresa tu consulta, usar solo minúsculas sin . al final:'),
	            readln(Input),
	            eliza(Input),!.


%%Casos base de cierre
%Despedida
eliza(Input):- Input == ['adios'], writeln('Adios. espero poder verte ayudado.'), !.
eliza(Input):- Input == ['adios', '.'], writeln('Adios. espero poder verte ayudado.'), !.
eliza(Input):- Input == ['bye'], writeln('Bye. Vuelve pronto.'), !.
eliza(Input):- Input == ['bye', '.'], writeln('Bye. Vuelve pronto.'), !.
eliza(Input):- Input == ['chao'], writeln('Chao. Cuidate.'), !.
eliza(Input):- Input == ['chao', '.'], writeln('Chao. Cuidate.'), !.
eliza(Input):- Input == ['hasta', 'luego'], writeln('Hasta luego. Que tengas un buen dia.'), !.
eliza(Input):- Input == ['hasta', 'luego', '.'], writeln('Hasta luego. Que tengas un buen dia.'), !.
eliza(Input):- Input == ['nos', 'vemos'], writeln('Nos vemos!'), !.
eliza(Input):- Input == ['nos', 'vemos', '.'], writeln('Nos vemos!'), !.
eliza(Input):- Input == ['hasta', 'la', 'proxima'], writeln('Hasta la proxima! Estare aqui.'), !.
eliza(Input):- Input == ['hasta', 'la', 'proxima', '.'], writeln('Hasta la proxima! Estare aqui.'), !.
eliza(Input):- Input == ['salir'], writeln('Saliendo... Adios.'), !.
eliza(Input):- Input == ['terminar'], writeln('Terminando sesion. Adios.'), !.
eliza(Input):- Input == ['ya', 'me', 'voy'], writeln('Esta bien. Adios.'), !.
eliza(Input):- Input == ['ya', 'me', 'voy', '.'], writeln('Esta bien. Adios.'), !.
eliza(Input):- Input == ['tengo', 'que', 'irme'], writeln('Entendido. Vuelve pronto.'), !.
eliza(Input):- Input == ['tengo', 'que', 'irme', '.'], writeln('Entendido. Vuelve pronto.'), !.
eliza(Input):- Input == ['eso', 'es', 'todo'], writeln('Perfecto. Que estes bien. Adios.'), !.
eliza(Input):- Input == ['eso', 'es', 'todo', '.'], writeln('Perfecto. Que estes bien. Adios.'), !.


%% Cerebro principal de Eliza
eliza(Input) :-
	template(Stim, Resp, IndStim),
	match(Stim, Input),
    % El '0' es el marcador que replace0 va a buscar en la lista Resp
	replace0(IndStim, Input, 0, Resp, R),
	writeln(R),
	readln(Input1),
	eliza(Input1), !.

% Caso default por si no entiende
eliza(Input) :-
    writeln('No te entendi. Por favor reformula tu consulta.'),
    readln(Input1),
	eliza(Input1), !.


%% --- AQUI EMPIEZAN LAS PARTES NUEVAS (LAS QUE FALTABAN) ---

%% match/2
%% Compara una plantilla (Stim) con el input del usuario (Input)
%%
% 1. Caso base: dos listas vacías sí empatan.
match([], []).

% 2. Caso comodín: s(_) empata con CUALQUIER palabra.
%    Avanzamos al resto de las listas.
match([s(_)|StimT], [_|InputT]) :-
	match(StimT, InputT).

% 3. Caso normal: dos palabras son iguales.
%    Avanzamos al resto de las listas.
match([H|StimT], [H|InputT]) :-
	match(StimT, InputT).


%% replace0/5
%% Reemplaza los marcadores en una respuesta con palabras del input.
%% replace0(Indices, Input, Marcador, PlantillaResp, RespuestaFinal)
%%
% 1. Caso base: Si la plantilla está vacía, la respuesta final también.
replace0(_, _, _, [], []).

% 2. Caso Marcador: La cabeza de la plantilla ES el marcador (ej: 0).
replace0([I|IndRest], Input, Marker, [Marker|RespT], [Word|FinalT]) :-
	nth0(I, Input, Word), % Saca la palabra (Word) del Input usando el índice (I)
	replace0(IndRest, Input, Marker, RespT, FinalT).

% 3. Caso normal: La cabeza no es el marcador.
replace0(IndStim, Input, Marker, [H|RespT], [H|FinalT]) :-
	H \== Marker, % Si H NO es el marcador...
	replace0(IndStim, Input, Marker, RespT, FinalT). % ...solo la copiamos igual.

%% --- AQUI TERMINAN LAS PARTES NUEVAS ---


%% Plantillas de respuestas
%Saludo
template([hola], ['Hola!', 'En', 'que, puedo, ayudarte', '?'], []).
template([hey], ['Hola.', 'Dime', 'tu', 'consulta', '.'], []).
template([que, tal], ['Que', 'tal!', 'Cual', 'es', 'tu', 'pregunta', '?'], []).
template([que, onda], ['Hola.', 'Estoy', 'lista', 'para', 'tu', 'consulta', '.'], []).
template([saludos], ['Saludos.', 'En', 'que, te', 'ayudo', '?'], []).
template([buena, tarde], ['Buenas', 'tardes.', 'Cual', 'es', 'tu', 'consulta', '?'], []).
template([buenas, noches], ['Buenas', 'noches.', 'En', 'que, te', 'puedo', 'ayudar', '?'], []).
template([que, hay], ['Todo', 'bien.', 'Que', 'necesitas', '?'], []).
template([hola, '.'], ['Hola!', 'En', 'que, puedo, ayudarte', '?'], []).
template([hey, '.'], ['Hola.', 'Dime', 'tu', 'consulta', '.'], []).
template([como, estas, '?'], ['Yo', estoy, 'bien', ',', gracias, '.', 'Cual', 'es', 'tu', 'consulta', '?'], []).
template([como, estas, tu, '?'], ['Yo', estoy, 'bien', ',', gracias, '.', 'Cual', 'es', 'tu', 'consulta', '?'], []).
template([como, te, va, '?'], ['Todo', 'en', 'orden.', 'Dime', 'en', 'que', 'puedo', 'ayudarte', '.'], []).
template([todo, bien, '?'], ['Si,', 'todo', 'bien.', 'Cual', 'es', 'tu', 'duda', '?'], []).

% Plantillas con reemplazo (Indices corregidos a base 0)
template([hola, ',', me, llamo, s(_), '.'], ['Hola', 0, '!', 'Mucho', 'gusto', '.'], [4]).
template([buenas, tardes, ',', me, llamo, s(_), '.'], ['Buenas', 'tardes', 0, '.', 'En', 'que', 'te', 'ayudo', '?'], [5]).
template([hey, ',', mi, nombre, es, s(_), '.'], ['Que', 'tal', 0, '!', 'Un', 'placer', '.'], [6]).
template([me, llamo, s(_)], ['Hola', 0, '.', 'Bonito', 'nombre', '.'], [2]).
template([mi, nombre, es, s(_)], ['Hola', 0, '.', 'Encantada', 'de', 'conocerte', '.'], [3]).
template([soy, s(_), '.'], ['Hola', 0, '.', 'En', 'que', 'puedo', 'ayudarte', '?'], [1]).
template([soy, s(_)], ['Hola', 0, '.', 'En', 'que', 'puedo', 'ayudarte', '?'], [1]).


%Likes (Siguen sin usarse, como en tu original)
likes(apples).
likes(ponies).
likes(zombies).
likes(manzanas).
likes(computadoras).
likes(carros).
likes(pizza).
likes(tacos).
likes(chocolate).
likes(musica).
likes(libros).
likes(peliculas).
likes(gatos).
likes(perros).
likes(videojuegos).
likes(ia).
likes(robots).
likes(prolog).
likes(logica).
likes(ciencia).
likes(estrellas).
likes(lluvia).
likes(memes).
likes(sushi).
likes(helado).
likes(delfines).
likes(arte).
likes(viajes).
likes(historia).
likes(silencio).