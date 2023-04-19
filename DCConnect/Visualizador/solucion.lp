% solucion.lp
% Vecinos
vecino(Y1, X1, Y2, X2) :-
  fila(Y1), columna(X1),
  fila(Y2), columna(X2),
  Y1 = Y2, X1 - X2 = 1.
  
vecino(Y1, X1, Y2, X2) :-
  fila(Y1), columna(X1),
  fila(Y2), columna(X2),
  X1 = X2, Y1 - Y2 = 1.

vecino(Y1, X1, Y2, X2) :-
  fila(Y1), columna(X1),
  fila(Y2), columna(X2),
  Y1 = Y2, X1 - X2 = -1.

vecino(Y1, X1, Y2, X2) :-
  fila(Y1), columna(X1),
  fila(Y2), columna(X2),
  X1 = X2, Y1 - Y2 = -1.

% Caminos posibles
paso(C, Y1, X1, Y2, X2) :-
  color(C, Y1, X1),
  color(C, Y3, X3),
  Y1 != Y3, X1 != X3,
  vecino(Y1, X1, Y2, X2),
  not ocupado(Y2, X2).

% Celdas ocupadas
ocupado(Y, X) :- paso(_, _, _, Y, X).

% Conectar todas las celdas coloreadas
:- color(C, Y, X), not paso(C, _, _, Y, X), not paso(C, Y, X, _, _).

% Caminos no deben cruzarse
:- paso(C1, _, _, Y, X), paso(C2, _, _, Y, X), C1 != C2.

% Usar todas las celdas
celda(Y, X) :- fila(Y), columna(X).
:- celda(Y, X), not ocupado(Y, X).

% Predicado camino
camino(C, Yorigen, Xorigen, Ydestino, Xdestino) :-
  paso(C, Yorigen, Xorigen, Ydestino, Xdestino).
camino(C, Yorigen, Xorigen, Ydestino, Xdestino) :-
  paso(C, Ydestino, Xdestino, Yorigen, Xorigen).