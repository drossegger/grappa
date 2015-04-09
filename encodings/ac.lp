%
% Def. 8, Grappa Paper.
%
% An edge is active if its origin is in.
activeedge(X,Y,I) :- e(X,Y,I), in(X).

%#l
alcount(NODE,L,NUMBER) :- s(NODE,_),term(_,_,activelabelcount(NODE,L)), NUMBER = #count{I:activeedge(I,NODE,L)}.

%#(t)l 
lcount(NODE,L,NUMBER) :- s(NODE,_), term(_,_,labelcount(NODE,L)), NUMBER = #count{I:e(I,NODE,L)}.

%min
minalabel(NODE,NUMBER) :- s(NODE,_), term(_,_,minactivelabel(NODE)), NUMBER= #min{I:activeedge(_,NODE,I)}.

%min(t) 
mintlabel(NODE,NUMBER) :- s(NODE,_), term(_,_,minlabel(NODE)), NUMBER= #min{I:e(_,NODE,I)}.

%max 
maxalabel(NODE,NUMBER) :- s(NODE,_), term(_,_,maxactivelabel(NODE)), NUMBER= #max{I:activeedge(_,NODE,I)}.

%max(t)
maxtlabel(NODE,NUMBER) :- s(NODE,_), term(_,_,maxlabel(NODE)), NUMBER= #max{I:e(_,NODE,I)}.

%sum
sumalabel(NODE,NUMBER) :- s(NODE,_), term(_,_,sumactivelabel(NODE)), NUMBER= #sum{I:activeedge(_,NODE,I)}.

%sum(t)
sumtlabel(NODE,NUMBER) :- s(NODE,_), term(_,_,sumlabel(NODE)), NUMBER= #sum{I:e(_,NODE,I)}.

%distinctlabels 
label(X,L) :- e(_, X, L).
activelabel(X,L) :- activeedge(_,X,L).
distactivelabel(NODE,NUMBER) :- s(NODE,_), term(_,_,distinctactivelabel(NODE)), NUMBER=#count{I:activelabel(NODE,I)}.
distlabel(NODE,NUMBER) :- s(NODE,_), term(_,_,distinctlabel(NODE)), NUMBER=#count{I:label(NODE,I)}.

%
% Calculating basic patterns
%
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
mterm(X,Y):- term(X,M,I), I==distinctactivelabel(J), distactivelabel(J,NUMBER), Y=M*NUMBER.
mterm(X,Y):- term(X,M,I), I==distinctlabel(J), distlabel(J,NUMBER), Y=M*NUMBER.


%Value of the lefthandside of a pattern
lhspat(X,Y) :-  Y = #sum {I:mterm(X,I)}, basicpattern(X,_,_).

%
%Model Checking
%

%true/1 if a basicpattern is correct.
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), geq(R), I>=A,basicpattern(L,R,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), leq(R), I<=A,basicpattern(L,R,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), eq(R), I==A, basicpattern(L,R,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), neq(R), I!=A,basicpattern(L,R,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), gt(R), I>A,  basicpattern(L,R,A).
true(X) :- X=basicpattern(L,R,A), lhspat(L,I), lt(R), I<A,  basicpattern(L,R,A).

false(X) :- X=basicpattern(L,R,A), lhspat(L,I), geq(R), I<A,  basicpattern(L,R,A).
false(X) :- X=basicpattern(L,R,A), lhspat(L,I), leq(R), I>A,  basicpattern(L,R,A).
false(X) :- X=basicpattern(L,R,A), lhspat(L,I), eq(R), I!=A,  basicpattern(L,R,A).
false(X) :- X=basicpattern(L,R,A), lhspat(L,I), neq(R), I==A, basicpattern(L,R,A).
false(X) :- X=basicpattern(L,R,A), lhspat(L,I), gt(R), I<=A,  basicpattern(L,R,A).
false(X) :- X=basicpattern(L,R,A), lhspat(L,I), lt(R), I>=A,  basicpattern(L,R,A).

accept(X) :- s(X,I), ismodel(I).

atom(X) :- X=basicpattern(L,R,A), basicpattern(L,R,A), geq(R).
atom(X) :- X=basicpattern(L,R,A), basicpattern(L,R,A), leq(R).
atom(X) :- X=basicpattern(L,R,A), basicpattern(L,R,A), eq(R).
atom(X) :- X=basicpattern(L,R,A), basicpattern(L,R,A), neq(R).
atom(X) :- X=basicpattern(L,R,A), basicpattern(L,R,A), gt(R).
atom(X) :- X=basicpattern(L,R,A), basicpattern(L,R,A), lt(R).

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

%
% Boolean Combinations of Basic Pattern
%
basicpattern(L,R,A) :- pattern(basicpattern(L,R,A)).

pattern(P) :- s(X,P).
pattern(P) :- pattern(and(P,_)).
pattern(P) :- pattern(and(_,P)).
pattern(P) :- pattern(or(P,_)).
pattern(P) :- pattern(or(_,P)).
pattern(P) :- pattern(neg(P)).
pattern(P) :- pattern(xor(P,_)).
pattern(P) :- pattern(xor(_,P)).
