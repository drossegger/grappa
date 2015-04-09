%expect: mterm(a,3) mterm(a,18) mterm(a,-14) ismodel(basicpattern(a,">",5))
#show ismodel/1.
#show mterm/2.
rhs(a,5).
num(3).
num(7).
label(a).

term(a,1,3).
term(a,-2,7).
term(a,6,3).

gt(">").

basicpattern(a,">",5).
