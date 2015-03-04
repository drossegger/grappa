%complexity issue because of disj. rule?
in(X) | -in(X) :- s(X,_).

:- accept(X), -in(X).
:- not accept(X),in(X). 
