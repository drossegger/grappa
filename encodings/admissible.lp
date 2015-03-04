#show pin/1.
#show pout/1.
#show in/1.
#show out/1.

model.
in(X,model) | out(X,model) | undec(X,model) :- s(X,_).


numberIterations(X):- X=#count {I : s(I,_)}.


iteration(I) :- numberIterations(I).
out(X,I):- numberIterations(I), s(X,_).

iteration(J) :- iteration(I), J=I-1,I>0.
in(X,J) :- iteration(J),iteration(I),J=I-1, accept(X,I).
out(X,J) :- iteration(J),iteration(I),J=I-1, not in(X,J), out(X,I).

in(S) :- in(S,J),J=0.
out(S):- out(S,J),J=0.

pin(S):- in(S,model).
pout(S) :- out(S,model).
:- not in(S),in(S,model).
:- not out(S),out(S,model).
