%========================%
% Aristotélica en Prolog %
%========================%

% Data Previa %
%=============%

% Data de figuras y nombres de proposiciones
figs([1,2,3,4]).
props([a,e,i,o]).

% Tipos de proposiciones
pos([a,i]).
neg([e,o]).

un([a,e]).
part([i,o]).

% Qué distribuye cada una
distribucion(a,sujeto).
distribucion(e,sujeto).
distribucion(e,predicado).
distribucion(o,predicado).

% Dónde queda el término medio en cada figua
pos_m(1,sujeto,predicado).
pos_m(2,predicado,predicado).
pos_m(3,sujeto,sujeto).
pos_m(4,predicado,sujeto).

% Reglas %
%========%
regla_dos(Prop_uno, Prop_dos, C) :-
	forall(distribucion(C, Termino),
	(   distribucion(Prop_uno, Termino)
	;   distribucion(Prop_dos, Termino)
	)).

regla_tres(Prop_uno, Prop_dos, F) :-
	pos_m(F, Pos_m1, Pos_m2),
	(   distribucion(Prop_uno, Pos_m1)
	;   distribucion(Prop_dos, Pos_m2)
	).

regla_cuatro(Prop_uno, Prop_dos) :-
	neg(Negativas),
	\+ (member(Prop_uno, Negativas), member(Prop_dos, Negativas)).

regla_cinco(Prop_uno, Prop_dos, C) :-
	pos(Positivas), 
	neg(Negativas),
	\+ (member(C, Positivas),
	    (member(Prop_uno, Negativas) ; member(Prop_dos, Negativas))
	).

regla_seis(Prop_uno, Prop_dos, C) :-
	part(Particulares), 
	un(Universales),
	\+ (member(C, Particulares),
	    (member(Prop_uno, Universales), member(Prop_dos, Universales))
	).

% Función de análisis por reglas %
%================================%

analisis_por_reglas(Prop_uno, Prop_dos, C, F) :-
	% Requisitos
	props(Props), 
	figs(Figs),
	% Revisión de sintaxis y pertenencia
	member(F, Figs), 
	member(Prop_uno, Props), 
	member(Prop_dos, Props), 
	member(C, Props),
	% Segunda regla
	regla_dos(Prop_uno, Prop_dos, C),
	% Tercera regla
	regla_tres(Prop_uno, Prop_dos, F),
	% Cuarta regla
	regla_cuatro(Prop_uno, Prop_dos),
	% Quinta regla
	regla_cinco(Prop_uno, Prop_dos, C),
	% Sexta regla
	regla_seis(Prop_uno, Prop_dos, C).