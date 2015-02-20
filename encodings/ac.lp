%#l sem
alcount(NODE,L,NUMBER) :- s(NODE,_),activelabelcount(NODE,L), NUMBER = #count{I:activeedge(I,NODE,L)}.

activeedge(X,Y,I) :- e(X,Y,I), in(X).

%#(t)l semantics
lcount(NODE,L,NUMBER) :- s(NODE,_), labelcount(NODE,L), NUMBER = #count{I:e(I,NODE,L).


%min semantics
minalabel(NODE,NUMBER) :- s(Node,_), minactivelabel(NODE), NUMBER= #min{I:activeedge(_,NODE,I)}.

%min(t) semantics

mintlabel(NODE,NUMBER) :- s(NODE,_), minlabel(NODE), NUMBER= #min{I:e(_,NODE,I)}.

%max semantics
maxalabel(NODE,NUMBER) :- s(Node,_), maxactivelabel(NODE), NUMBER= #max{I:activeedge(_,NODE,I)}.

%max(t) semantics

maxtlabel(NODE,NUMBER) :- s(NODE,_), maxlabel(NODE), NUMBER= #max{I:e(_,NODE,I)}.

%sum semantics
sumalabel(NODE,NUMBER) :- s(Node,_), sumactivelabel(NODE), NUMBER= #sum{I:activeedge(_,NODE,I)}.

%sum(t) semantics

sumtlabel(NODE,NUMBER) :- s(NODE,_), sumlabel(NODE), NUMBER= #sum{I:e(_,NODE,I)}.

%count semantics
activeedgegt0(X,Y,I) :- e(X,Y,I),in(X),I>0.
egt0(X,Y,I) :- e(X,Y,I), I>0.

countagt0(NODE,NUMBER) :- s(NODE,_), countactivegt0(NODE), NUMBER=#count{I:activeedgegt0(_,NODE,I)}.
counttgt0(NODE,NUMBER) :- s(NODE,_), countgt0(NODE), NUMBER=#count{I:egt0(_,NODE,I).

%Calculate value of a term
mterm(X,Y):- term(X,M,I), Y=M*I, num(I).
mterm(X,Y):- term(X,M,I), I==activelabelcount(J,K), alcount(J,K,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==labelcount(J,K), lcount(J,K,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==minactivelabel(J), minalabel(J,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==minlabel(J), mintlabel(J,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==maxactivelabel(J), maxalabel(J,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==maxlabel(J), maxtlabel(J,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==sumactivelabel(J), sumalabel(J,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==sumlabel(J), sumtlabel(J,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==countactivegt0(J), countagt0(J,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==countgt0(J), counttgt0(J,NUMBER), Y=M*NUMBER.



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
