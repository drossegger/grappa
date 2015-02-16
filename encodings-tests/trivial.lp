%expect: in(a) -in(b)
#show in/1.
#show -in/1.

s(a,basicpattern(a1,"==",0)).
s(b,basicpattern(b1,"==",0)).
label(a1).
label(b1).

e(a,b,"-").
rhs(a1,0).
rhs(b1,0).
term(a1,1,labelcount(a,"-")).
term(b1,1,labelcount(b,"-")).
num(3).
num(0).
eq("==").
minus("-").
plus("+").
