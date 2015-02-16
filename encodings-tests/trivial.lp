%expect: in(a) -in(b)
%execute: encondings/model.lp encondings/ac.lp encodings-tests/trivial.lp
#show in/1.
#show -in/1.

%Argument s ist ein tupel (NAME, ACCEPTANCE FUNCTION).
s(a,basicpattern(a1,"==",0)).
s(b,basicpattern(b1,"==",0)).
%Jedes basicpattern hat ein label, nützlich für z.b. Aggregatsfunktionen
label(a1).
label(b1).

%Edge mit label
e(a,b,"-").

%rechte Seite der bp inequality, inkl. referenz zum gehörigen bp.
rhs(a1,0).
rhs(b1,0).

%term(LABEL,MULTIPLIKATOR,TERM). TERM ist der term wie definiert im paper.
%labelcount(argument,label). #l Semantik
term(a1,1,labelcount(a,"-")).
term(b1,1,labelcount(b,"-")).

eq("==").
minus("-").
plus("+").
