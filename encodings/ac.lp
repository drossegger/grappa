#show attacks/2.
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
bpaccept(X) :- X=basicpattern(LHS,R,A), lhspat(LHS,I), geq(R), I>=A,num(A).
bpaccept(X) :- X=basicpattern(LHS,R,A), lhspat(LHS,I), leq(R), I<=A,num(A).
bpaccept(X) :- X=basicpattern(LHS,R,A), lhspat(LHS,I), eq(R), I==A, num(A).
bpaccept(X) :- X=basicpattern(LHS,R,A), lhspat(LHS,I), neq(R), I!=A,num(A).
bpaccept(X) :- X=basicpattern(LHS,R,A), lhspat(LHS,I), gt(R), I>A,  num(A).
bpaccept(X) :- X=basicpattern(LHS,R,A), lhspat(LHS,I), lt(R), I<A,  num(A).
%accept(X):- I= #count {NAME : bp(X,NAME)}, J= #count {NAME: basicpattern(X,NAME,_)}, J==I,s(X).

accept(X) :- s(X,I), ismodel(I).

ismodel(X) :- bpaccept(X).


pattern(P) :- pattern(and(P,_)).
pattern(P) :- pattern(and(_,P)).
pattern(P) :- pattern(or(P,_)).
pattern(P) :- pattern(or(_,P)).
pattern(P) :- pattern(neg(P)).
pattern(P) :- pattern(xor(P,_)).
pattern(P) :- pattern(xor(_,P)).


