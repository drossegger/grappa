in(X) | -in(X) :- s(X,_).

in(X) :- accept(X).
-in(X) :- not accept(X), s(X,_).



