%
% Semantics of Def. 8, Grappa Paper.
%
% An edge is active if its origin is in.
activeedge(X,Y,I,LABEL) :- e(X,Y,LABEL), in(X,I),iteration(I).

%#l sem
alcount(NODE,L,I,NUMBER) :- s(NODE,_),term(_,_,activelabelcount(NODE,L)),iteration(I), NUMBER = #count{J:activeedge(J,NODE,I,L)}.

%#(t)l semantics
lcount(NODE,L,NUMBER) :- s(NODE,_), term(_,_,labelcount(NODE,L)), NUMBER = #count{I:e(I,NODE,L)}.

%min semantics
minalabel(NODE,I,NUMBER) :- s(NODE,_), term(_,_,minactivelabel(NODE)),iteration(I), NUMBER= #min{J:activeedge(_,NODE,I,J)}.

%min(t) semantics
mintlabel(NODE,NUMBER) :- s(NODE,_), term(_,_,minlabel(NODE)), NUMBER= #min{I:e(_,NODE,I)}.

%max semantics
maxalabel(NODE,I,NUMBER) :- s(NODE,_), term(_,_,maxactivelabel(NODE)),iteration(I), NUMBER= #max{J:activeedge(_,NODE,I,J)}.

%max(t) semantics
maxtlabel(NODE,NUMBER) :- s(NODE,_), term(_,_,maxlabel(NODE)), NUMBER= #max{I:e(_,NODE,I)}.

%sum semantics
sumalabel(NODE,I,NUMBER) :- s(NODE,_), term(_,_,sumactivelabel(NODE)),iteration(I), NUMBER= #sum{J:activeedge(_,NODE,I,J)}.

%sum(t) semantics
sumtlabel(NODE,NUMBER) :- s(NODE,_), term(_,_,sumlabel(NODE)), NUMBER= #sum{I:e(_,NODE,I)}.

%count semantics
%egt0/3 if the label of an edge is >0, undefined for non numerical values.
egt0(X,Y,I) :- e(X,Y,I), I>0.
%egt0/3 and origin is in
activeedgegt0(X,Y,I) :- egt0(X,Y,I),in(X).

countagt0(NODE,NUMBER) :- s(NODE,_), term(_,_,countactivegt0(NODE)), NUMBER=#count{I:activeedgegt0(_,NODE,I)}.
counttgt0(NODE,NUMBER) :- s(NODE,_), term(_,_,countgt0(NODE)), NUMBER=#count{I:egt0(_,NODE,I)}.

%
% Calculating basic patterns
%
%Calculate value of a term
mterm(L,I,Y):- term(L,M,Z), Y=M*Z, num(Z),iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==activelabelcount(J,K), alcount(J,K,I,NUMBER), Y=M*NUMBER,iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==labelcount(J,K), lcount(J,K,NUMBER), Y=M*NUMBER,iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==minactivelabel(J), minalabel(J,I,NUMBER), Y=M*NUMBER,iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==minlabel(J), mintlabel(J,NUMBER), Y=M*NUMBER,iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==maxactivelabel(J), maxalabel(J,I,NUMBER), Y=M*NUMBER,iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==maxlabel(J), maxtlabel(J,NUMBER), Y=M*NUMBER,iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==sumactivelabel(J), sumalabel(J,I,NUMBER), Y=M*NUMBER,iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==sumlabel(J), sumtlabel(J,NUMBER), Y=M*NUMBER,iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==countactivegt0(J), countagt0(J,I,NUMBER), Y=M*NUMBER,iteration(I).
mterm(L,I,Y):- term(L,M,Z), Z==countgt0(J), counttgt0(J,NUMBER), Y=M*NUMBER,iteration(I).


%Value of the lefthandside of a pattern
lhspat(L,I,RESULT) :-  RESULT = #sum {J:mterm(L,I,J)}, rhs(L,_),iteration(I).

%
%Model Checking
%

%true/1 if a basicpattern is correct.
true(X,I) :- X=basicpattern(L,R,A), lhspat(L,I,RESULT), geq(R), RESULT>=A,rhs(L,A).
true(X,I) :- X=basicpattern(L,R,A), lhspat(L,I,RESULT), leq(R), RESULT<=A,rhs(L,A).
true(X,I) :- X=basicpattern(L,R,A), lhspat(L,I,RESULT), eq(R),  RESULT==A, rhs(L,A).
true(X,I) :- X=basicpattern(L,R,A), lhspat(L,I,RESULT), neq(R), RESULT!=A,rhs(L,A).
true(X,I) :- X=basicpattern(L,R,A), lhspat(L,I,RESULT), gt(R),  RESULT>A,  rhs(L,A).
true(X,I) :- X=basicpattern(L,R,A), lhspat(L,I,RESULT), lt(R),  RESULT<A,  rhs(L,A).


false(X,I) :- atom(X),iteration(I), not true(X,I).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), geq(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), leq(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), eq(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), neq(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), gt(R).
atom(X) :- X=basicpattern(L,R,A), rhs(L,A), lt(R).
	
accept(X,I) :- s(X,Y),ismodel(Y,I).
ismodel(X,I) :- pattern(X), true(X,I).
ismodel(X,I) :- pattern(X;X1), X=neg(X1), nomodel(X1,I).
ismodel(X,I) :- pattern(X;X1;X2), X=and(X1,X2), ismodel(X1,I;X2,I).
ismodel(X,I) :- pattern(X;X1;X2), X=or(X1,X2), ismodel(X1,I).
ismodel(X,I) :- pattern(X;X1;X2), X=or(X1,X2), ismodel(X2,I).
ismodel(X,I) :- pattern(X;X1;X2), X=xor(X1,X2), ismodel(X1,I), nomodel(X2,I).
ismodel(X,I) :- pattern(X;X1;X2), X=xor(X1,X2), ismodel(X2,I), nomodel(X1,I).

nomodel(X,I) :- pattern(X), false(X,I).
nomodel(X,I) :- pattern(X;X1), X=neg(X1), ismodel(X1,I).
nomodel(X,I) :- pattern(X;X1;X2), X=and(X1,X2), nomodel(X1,I).
nomodel(X,I) :- pattern(X;X1;X2), X=and(X1,X2), nomodel(X2,I).
nomodel(X,I) :- pattern(X;X1;X2), X=or(X1,X2), nomodel(X1,I), nomodel(X2,I).
nomodel(X,I) :- pattern(X;X1;X2), X=xor(X1,X2), nomodel(X1,I), nomodel(X2,I).
nomodel(X,I) :- pattern(X;X1;X2), X=xor(X1,X2), ismodel(X1,I), ismodel(X2,I).

%
% Boolean Combinations of Basic Pattern
%

pattern(P) :- s(X,P).
pattern(P) :- pattern(and(P,_)).
pattern(P) :- pattern(and(_,P)).
pattern(P) :- pattern(or(P,_)).
pattern(P) :- pattern(or(_,P)).
pattern(P) :- pattern(neg(P)).
pattern(P) :- pattern(xor(P,_)).
pattern(P) :- pattern(xor(_,P)).
