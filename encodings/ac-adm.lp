% An edge is active if its origin is in.
activeedge(S,X,S,I) :- e(X,S,I), in2(S,X),select(S).

%#l sem
%rem: select(NODE)
alcount(S,S,L,NUMBER) :- s(S,_),term(_,_,activelabelcount(S,L)), NUMBER = #count{I:activeedge(S,I,S,L)},select(S).

%#(t)l semantics
%rem: select(NODE)
lcount(NODE,L,NUMBER) :-  term(_,_,labelcount(NODE,L)), NUMBER = #count{I:e(I,NODE,L)}, select(NODE).

% Calculating basic patterns
%
%Calculate value of a term
%rem: select(J)
mterm(S,X,Y):- term(X,M,I), I==activelabelcount(S,K), alcount(S,S,K,NUMBER), Y=M*NUMBER, select(S).
mterm(S,X,Y):- term(X,M,I), I==labelcount(S,K), lcount(S,K,NUMBER), Y=M*NUMBER, select(S).
%Value of the lefthandside of a pattern
%rem: select(N)
lhspat(S,X,Y) :-  Y = #sum {I:mterm(S,X,I)}, basicpattern(S,X,_,_),select(S).
%Model Checking
%rem: select(N)
true(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), geq(R), I>=A,basicpattern(S,L,R,A),select(S).
true(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), leq(R), I<=A,basicpattern(S,L,R,A),select(S).
true(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), eq(R), I==A, basicpattern(S,L,R,A),select(S).
true(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), neq(R), I!=A,basicpattern(S,L,R,A),select(S).
true(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), gt(R), I>A,  basicpattern(S,L,R,A),select(S).
true(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), lt(R), I<A,  basicpattern(S,L,R,A),select(S).

false(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), geq(R), I<A,  basicpattern(S,L,R,A),select(S).
false(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), leq(R), I>A,  basicpattern(S,L,R,A),select(S).
false(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), eq(R), I!=A,  basicpattern(S,L,R,A),select(S).
false(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), neq(R), I==A, basicpattern(S,L,R,A),select(S).
false(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), gt(R), I<=A,  basicpattern(S,L,R,A),select(S).
false(S,X) :- X=basicpattern(S,L,R,A), lhspat(S,L,I), lt(R), I>=A,  basicpattern(S,L,R,A),select(S).

accept(S,S) :- s(S,Y),ismodel(S,Y),in(S).
accept(S,S) :- s(S,Y),nomodel(S,Y),out(S).

ismodel(S,X) :- pattern(X), true(S,X).
ismodel(S,X) :- pattern(X;X1), X=neg(X1), nomodel(S,X1).
ismodel(S,X) :- pattern(X;X1;X2), X=and(X1,X2), ismodel(S,X1),ismodel(S,X2).
ismodel(S,X) :- pattern(X;X1;X2), X=or(X1,X2), ismodel(S,X1).
ismodel(S,X) :- pattern(X;X1;X2), X=or(X1,X2), ismodel(S,X2).
ismodel(S,X) :- pattern(X;X1;X2), X=xor(X1,X2), ismodel(S,X1), nomodel(S,X2).
ismodel(S,X) :- pattern(X;X1;X2), X=xor(X1,X2), ismodel(S,X2), nomodel(S,X1).

nomodel(S,X) :- pattern(X), false(S,X).
nomodel(S,X) :- pattern(X;X1), X=neg(X1), ismodel(S,X1).
nomodel(S,X) :- pattern(X;X1;X2), X=and(X1,X2), nomodel(S,X1).
nomodel(S,X) :- pattern(X;X1;X2), X=and(X1,X2), nomodel(S,X2).
nomodel(S,X) :- pattern(X;X1;X2), X=or(X1,X2), nomodel(S,X1), nomodel(S,X2).
nomodel(S,X) :- pattern(X;X1;X2), X=xor(X1,X2), nomodel(S,X1), nomodel(S,X2).
nomodel(S,X) :- pattern(X;X1;X2), X=xor(X1,X2), ismodel(S,X1), ismodel(S,X2).


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
basicpattern(N,L,R,A) :- pattern(basicpattern(N,L,R,A)).
