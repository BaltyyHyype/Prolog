% libreria para listas
:- use_module(library(lists)).

% para correr todo
iniciar :-
    resolver(Investigadores),
    write('--- solucion ---'), nl,
    imprimir_lista(Investigadores).

% aqui esta la logica chida
resolver(Investigadores) :-
    % defino la estructura de la lista
    Investigadores = [
        inv(ana, _, _, _, _, _),
        inv(bruno, _, _, _, _, _),
        inv(carlos, _, _, _, _, _),
        inv(diana, _, _, _, _, _),
        inv(elisa, _, _, _, _, _)
    ],

    % defino las opciones posibles
    Especialidades = [genetica, microbiologia, bioquimica, inmunologia, neurociencia],
    Horarios       = [6, 8, 10, 12, 14],
    Bebidas        = [cafe, te, jugo, mate, agua],
    Equipos        = [microscopio, centrifuga, pcr, espectrometro, incubadora],
    Paises         = [mexico, chile, espana, argentina, peru],

    % aqui empieza el relajo de asignar cosas
    
    % --- especialidades ---
    permutation(Especialidades, [E1, E2, E3, E4, E5]),
    Investigadores = [
        inv(ana, E1, _, _, _, _),
        inv(bruno, E2, _, _, _, _),
        inv(carlos, E3, _, _, _, _),
        inv(diana, E4, _, _, _, _),
        inv(elisa, E5, _, _, _, _)
    ],
    
    % diana va a micro
    E4 = microbiologia,
    % ana no quiere ni genetica ni neuro
    E1 \= genetica, E1 \= neurociencia,

    % --- paises ---
    permutation(Paises, [P1, P2, P3, P4, P5]),
    Investigadores = [
        inv(ana, _, _, _, _, P1),
        inv(bruno, _, _, _, _, P2),
        inv(carlos, _, _, _, _, P3),
        inv(diana, _, _, _, _, P4),
        inv(elisa, _, _, _, _, P5)
    ],
    
    % bruno no es mexa
    P2 \= mexico,
    % la de bio es de chile
    member(inv(_, bioquimica, _, _, _, chile), Investigadores),
    % el de espana esta en neuro
    member(inv(_, neurociencia, _, _, _, espana), Investigadores),

    % --- horarios ---
    permutation(Horarios, [H1, H2, H3, H4, H5]),
    Investigadores = [
        inv(ana, _, H1, _, _, _),
        inv(bruno, _, H2, _, _, _),
        inv(carlos, _, H3, _, _, _),
        inv(diana, _, H4, _, _, _),
        inv(elisa, _, H5, _, _, _)
    ],

    


    % el de genetica llega a las 6
    member(inv(_, genetica, 6, _, _, _), Investigadores),
    % la peruana llega a las 10
    member(inv(_, _, 10, _, _, peru), Investigadores),

    % --- equipos ---
    permutation(Equipos, [Eq1, Eq2, Eq3, Eq4, Eq5]),
    Investigadores = [
        inv(ana, _, _, _, Eq1, _),
        inv(bruno, _, _, _, Eq2, _),
        inv(carlos, _, _, _, Eq3, _),
        inv(diana, _, _, _, Eq4, _),
        inv(elisa, _, _, _, Eq5, _)
    ],
    
    % carlos trae el espectrometro
    Eq3 = espectrometro,
    % inmuno usa pcr
    member(inv(_, inmunologia, _, _, pcr, _), Investigadores),
    % incubadora a las 14
    member(inv(_, _, 14, _, incubadora, _), Investigadores),
    % a las 8 usan micro
    member(inv(_, _, 8, _, microscopio, _), Investigadores),
    % el mexa no usa micro ni incubadora
    member(inv(_, _, _, _, EqMex, mexico), Investigadores),
    EqMex \= microscopio, EqMex \= incubadora,

    % --- bebidas ---
    permutation(Bebidas, [B1, B2, B3, B4, B5]),
    Investigadores = [
        inv(ana, _, _, B1, _, _),
        inv(bruno, _, _, B2, _, _),
        inv(carlos, _, _, B3, _, _),
        inv(diana, _, _, B4, _, _),
        inv(elisa, _, _, B5, _, _)
    ],
    
    % centrifuga toma te
    member(inv(_, _, _, te, centrifuga, _), Investigadores),
    % el argentino toma mate
    member(inv(_, _, _, mate, _, argentina), Investigadores),
    % elisa ni te ni cafe
    B5 \= te, B5 \= cafe,
    % peru no toma agua
    member(inv(_, _, _, BPeru, _, peru), Investigadores),
    BPeru \= agua,
    
    % --- reglas mas dificiles ---
    
    % cafe llega 2 horas antes que jugo
    member(inv(_, _, HoraCafe, cafe, _, _), Investigadores),
    member(inv(_, _, HoraJugo, jugo, _, _), Investigadores),
    HoraJugo is HoraCafe + 2,
    
    % pcr despues de micro
    member(inv(_, _, HoraPCR, _, pcr, _), Investigadores),
    member(inv(_, microbiologia, HoraMicro, _, _, _), Investigadores),
    HoraPCR > HoraMicro,
    
    % agua no usa pcr ni espectro
    member(inv(_, _, _, agua, EqAgua, _), Investigadores),
    EqAgua \= pcr, EqAgua \= espectrometro,
    
    % neuro llega despues del jugo
    member(inv(_, neurociencia, HoraNeuro, _, _, _), Investigadores),
    HoraNeuro > HoraJugo.

% para imprimir la lista
imprimir_lista([]).
imprimir_lista([Cabezal|Cola]) :-
    write(Cabezal), nl,
    imprimir_lista(Cola).