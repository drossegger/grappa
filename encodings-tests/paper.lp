#show in/1.
s(a,and(basicpattern(a1,"==",0),basicpattern(a2,"==",0))).
s(b,and(basicpattern(b1,"==",0),basicpattern(b2,"==",0))).
s(c,and(basicpattern(c1,"==",0),basicpattern(c2,"==",0))).
s(d,and(basicpattern(d1,"==",0),basicpattern(d2,"==",0))).

e(a,c,"+").
e(b,b,"+").
e(b,c,"+").
e(b,d,"-").

term(a1,1,activelabelcount(a,"+")).
term(a1,-1,labelcount(a,"+")).
term(a2,1,activelabelcount(a,"-")).

term(b1,1,activelabelcount(b,"+")).
term(b1,-1,labelcount(b,"+")).
term(b2,1,activelabelcount(b,"-")).

term(c1,1,activelabelcount(c,"+")).
term(c1,-1,labelcount(c,"+")).
term(c2,1,activelabelcount(c,"-")).

term(d1,1,activelabelcount(d,"+")).
term(d1,-1,labelcount(d,"+")).
term(d2,1,activelabelcount(d,"-")).

eq("==").
rhs(a1,0;a2,0;b1,0;b2,0;c1,0;c2,0;d1,0;d2,0).
label(a1;a2;b1;b2;c1;c2;d1;d2).
