% l1 y l2 son constantes.
% linterna es un predicado de aridad 1.
%  predicado es análogo a una clase.
linterna(l1). % l1 es una linterna
linterna(l2). % l2 es una linterna
linterna(l3). % l3 es una linterna
encendida(l1).

% la siguiente es una regla:
herramienta(X) :- linterna(X).
% estosellamacabeza :- estosellamacuerpo.
% la regla se lee como:
%   "cuando se cumple que X es una linterna, se cumple que X es una herramienta"
%   "si X es linterna --> X es una herramienta"
% X es una variable, sin embargo, recordemos que estas variables no tienen nada que ver con las
% variables de python


herramienta(martillo).

apunta(l1,sala).
apunta(l1,cueva).
apunta(l2,cueva).
% encendida(l2).

iluminado(Lugar) :- apunta(Linterna,Lugar),encendida(Linterna).
