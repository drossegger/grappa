%complexity issue because of disj. rule?
in(X) | out(X) :- s(X,_).

:- accept(X), out(X).
:- not accept(X),in(X). 
