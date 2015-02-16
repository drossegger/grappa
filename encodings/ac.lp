%Count attackers/supporters
lcount(NODE,L,NUMBER) :- s(NODE,_), NUMBER = #count{I:supports(I,NODE)},plus(L).
lcount(NODE,L,NUMBER) :- s(NODE,_), NUMBER = #count{I:attacks(I,NODE)},minus(L).

attacks(X,Y) :- e(X,Y,"-"), in(X).
supports(X,Y):- e(X,Y,"+"), in(X).

%Calculate value of a term
mterm(X,Y):- term(X,M,I), Y=M*I, num(I).
mterm(X,Y):- term(X,M,I), I==labelcount(J,K), lcount(J,K,NUMBER), Y=M*NUMBER.

%Value of the lefthandside of a pattern
lhspat(X,Y) :-  Y = #sum {I:mterm(X,I)}, label(X).

%Can be concluded if a bp is correct.
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), geq(R), I>=A,rhs(L,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), leq(R), I<=A,rhs(L,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), eq(R), I==A, rhs(L,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), neq(R), I!=A,rhs(L,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), gt(R), I>A,  rhs(L,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), lt(R), I<A,  rhs(L,A).

accept(X) :- s(X,I), ismodel(I).

false(X) :- atom(X), not true(X).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), geq(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), leq(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), eq(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), neq(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), gt(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), lt(R).

ismodel(X) :- pattern(X), true(X).
ismodel(X) :- pattern(X;X1), X=neg(X1), nomodel(X1).
ismodel(X) :- pattern(X;X1;X2), X=and(X1,X2), ismodel(X1;X2).
ismodel(X) :- pattern(X;X1;X2), X=or(X1,X2), ismodel(X1).
ismodel(X) :- pattern(X;X1;X2), X=or(X1,X2), ismodel(X2).
ismodel(X) :- pattern(X;X1;X2), X=xor(X1,X2), ismodel(X1), nomodel(X2).
ismodel(X) :- pattern(X;X1;X2), X=xor(X1,X2), ismodel(X2), nomodel(X1).

nomodel(X) :- pattern(X), false(X).
nomodel(X) :- pattern(X;X1), X=neg(X1), ismodel(X1).
nomodel(X) :- pattern(X;X1;X2), X=and(X1,X2), nomodel(X1).
nomodel(X) :- pattern(X;X1;X2), X=and(X1,X2), nomodel(X2).
nomodel(X) :- pattern(X;X1;X2), X=or(X1,X2), nomodel(X1), nomodel(X2).
nomodel(X) :- pattern(X;X1;X2), X=xor(X1,X2), nomodel(X1), nomodel(X2).
nomodel(X) :- pattern(X;X1;X2), X=xor(X1,X2), ismodel(X1), ismodel(X2).


%Work in progress
pattern(P) :- s(X,P).
pattern(P) :- pattern(and(P,_)).
pattern(P) :- pattern(and(_,P)).
pattern(P) :- pattern(or(P,_)).
pattern(P) :- pattern(or(_,P)).
pattern(P) :- pattern(neg(P)).
pattern(P) :- pattern(xor(P,_)).
pattern(P) :- pattern(xor(_,P)).
