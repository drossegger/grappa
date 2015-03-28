%%%%%%%%%%%%%%%%%%%%%%%
% Candidate Guess
%%%%%%%%%%%%%%%%%%%%%%%
in(S) | out(S) | undec(S) :- s(S,_).

%An argument is selected if it is in or out
select(S) :- in(S).
select(S) :- out(S).
%%%%%%%%%%%%%%%%%%%%%%%
% Completion
%%%%%%%%%%%%%%%%%%%%%%%

in2(S,X) | out2(S,X) :- undec(X), select(S).
in2(S,X) :- in(X),select(S).
out2(S,X) :- out(X),select(S).
%%%%%%%%%%%%%%%%%%%%%%%
% Check
%%%%%%%%%%%%%%%%%%%%%%%
ok(X) :- select(X), accept(X,X).
:- select(S), not ok(S).
%%%%%%%%%%%%%%%%%%%%%%%
% Saturation
%%%%%%%%%%%%%%%%%%%%%%%

in2(S,X) :- ok(S), undec(X).
out2(S,X) :- ok(S), undec(X).

activeedge(S,X,S,L) :- e(X,S,L), ok(S),undec(X).

alcount(S,S,L,0) :- ok(S),term(_,_,activelabelcount(S,L)).
alcount(S,S,L,I) :- ok(S),term(_,_,activelabelcount(S,L)), I=J+1, alcount(S,S,L,J), I<=MAX, lcount(S,L,MAX).

num(0..20).
lhspat(S,X,I) :- num(I), ok(S), basicpattern(S,X,_,_).

%true(S,X) :- ok(S),X=basicpattern(S,L,R,A),basicpattern(S,L,R,A).
%false(S,X) :- ok(S), X=basicpattern(S,L,R,A), basicpattern(S,L,R,A).
