#show in/1.
#show -in/1.
%execute: -n0 encodings/ac.lp encodings/model.lp encodings-tests/paper.lp
%argument definition. s(argumentname, acceptance condition).
s(a,and(basicpattern(a1,"==",0),basicpattern(a2,"==",0))).
s(b,and(basicpattern(b1,"==",0),basicpattern(b2,"==",0))).
s(c,and(basicpattern(c1,"==",0),basicpattern(c2,"==",0))).
s(d,and(basicpattern(d1,"==",0),basicpattern(d2,"==",0))).

%labelled arcs
e(a,c,"+").
e(b,b,"+").
e(b,c,"+").
e(b,d,"-").

%terms of the basicpatterns
%Care here a term is a*t instead of just t as in definition 7 of the Grappa paper
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

