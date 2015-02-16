#show in/1.
#show accept/1.
#show ismodel/1.

s(a,and(basicpattern(a1,"==",0),basicpattern(a2,">=",0))).
s(b,and(basicpattern(b1,"==",0),basicpattern(b2,">=",0))).
s(c,and(basicpattern(c1,"==",0),basicpattern(c2,">=",0))).

term(a1,1,labelcount(a,"-")).
term(b1,1,labelcount(b,"-")).
term(c1,1,labelcount(c,"-")).

term(a2,1,labelcount(a,"+")).
term(b2,1,labelcount(b,"+")).
term(c2,1,labelcount(c,"+")).

label(a1;b1;c1;a2;b2;c2).
eq("==").
geq(">=").
minus("-").
plus("+").

rhs(a1,0;b1,0;c1,0;a2,0;b2,0;c2,0).

e(a,b,"+").
e(c,b,"-").
e(c,c,"+").
