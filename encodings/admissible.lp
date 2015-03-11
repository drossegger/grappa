#show in/1.
#show out/1.
model.
in(X,model) | out(X,model) | undec(X,model) :- s(X,_).

numberIterations(X):- X=#count {I : undec(I,model)}.
in(X,I) :- iteration(I),in(X,model).
out(X,I) :- iteration(I),out(X,model).
iteration(I) :- numberIterations(I).
iteration(J) :- iteration(I),J=I-1,I>0.
								
in(X,I) :- undec(X,model), numberIterations(I).
%out(X,I) :- undec(X,model),out(X,J),J=I+1.
I{in(X,I):in(X,J),not in(X,model)}I :- iteration(I),iteration(J),J=I+1.
out(X,I) :- not in(X,I),undec(X,model),iteration(I).

naccept(X,I):- not accept(X,I), iteration(I),in(X,model).
naccept(X,I):- accept(X,I), out(X,model).

in(X):- in(X,model), not naccept(X,_).
out(X) :- out(X,model), not naccept(X,_).

:- not in(S),in(S,model).
:- not out(S),out(S,model).
