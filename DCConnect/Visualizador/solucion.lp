% solucion2.lp

% Vecinos
vecino(Y1, X1, Y1 + 1, X1) :-
  celda(Y1, X1),
  celda(Y1 + 1, X1).

vecino(Y1, X1, Y1 - 1, X1) :-
  celda(Y1, X1),
  celda(Y1 - 1, X1).

vecino(Y1, X1, Y1, X1 + 1) :-
  celda(Y1, X1),
  celda(Y1, X1 + 1).

vecino(Y1, X1, Y1, X1 - 1) :-
  celda(Y1, X1),
  celda(Y1, X1 - 1).

% Celdas válidas
celda(Y, X) :- fila(Y), columna(X).

% Hay que respetar el dominio
:- ocupado(C1, Y, X), not celda(Y, X).
  
% No puede haber una casilla ocupada por dos colores
%:- ocupado(C1, Y, X), ocupado(C2, Y, X), C1 != C2.

:- camino(C1, Y1, X1, Y2, X2), camino(C2, Y3, X3, Y2, X2), C1 !=C2.

% No se puede hacer caminos en celdas no vecinas
:- camino(C, Y1, X1, Y2, X2), not vecino(Y1, X1, Y2, X2).

% No se puede hacer caminos sobre celdas ocupadas
%:- camino(C, Y1, X1, Y2, X2), ocupado(Y2, X2), not color(C, Y2, X2).

% Se ocupan las casillas hacia donde hay un camino
ocupado(C, Y2, X2) :- camino(C, Y1, X1, Y2, X2).

% los puntos extremos siempre están ocupados
%ocupado(C1, Y , X) :- color(C1, Y, X).

% Toda casilla no inicial, tiene un paso previo y uno siguiente
1{camino(C, Y1, X1, Y1 + 1, X1); camino(C, Y1, X1, Y1 - 1, X1); camino(C, Y1, X1, Y1, X1 +1); camino(C, Y1, X1, Y1, X1 -1)}1 :- camino(C, Y3, X3, Y1, X1).

% Toda casilla extremo, tiene que tener un camino de salida.

0{camino(C, Y1, X1, Y1 + 1, X1); camino(C, Y1, X1, Y1 - 1, X1); camino(C, Y1, X1, Y1, X1 +1); camino(C, Y1, X1, Y1, X1 -1)}1 :- color(C, Y1, X1).

% Los caminos no tienen direccion
camino(C, Y1, X1, Y2, X2) :- camino(C, Y2, X2, Y1, X1).

% Para que la casilla esté ocupada, un camino debe ir hacia ella.
:- camino(C, Y1, X1, Y2, X2), not ocupado(C, Y2, X2).

%Hay que rellenar todo el mapa
:- celda(Y, X), not ocupado(C, Y, X), color(C, Y2, X2).