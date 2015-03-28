%%%%%%%%%%%%%%%%%%%%%%%
% Candidate Guess
%%%%%%%%%%%%%%%%%%%%%%%
in(S) | out(S) | undec(S) :- s(S).

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

true(S,p1) :- ok(S).
false(S,p1) :- ok(S).
true(S,p2) :- ok(S).
false(S,p2) :- ok(S).

