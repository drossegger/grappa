#show ismodel/1.
#show nomodel/1.
atom(a).
atom(b).
atom(c).
atom(d).

true(a).
false(b).
true(c).
false(d).

pattern(xor(or(and(a,b),c),d)).
%pattern(xor(d,or(and(a,b),c))).

%pattern(and(a,c)).
pattern(neg(a)).
pattern(and(a,neg(b))).
