% An edge is active if its origin is in.
activeedge(S,X,S,I) :- e(X,S,I), in2(S,X),select(S).





true(S,p1) :- select(S), #sum { 1, V, act : activeedge(S, V , S, "+") ;
															 -1, V,inact: e(V,S,"+") } == 0.
true(S,p2) :- select(S), #sum { 1, V,neg : activeedge(S,V,S,"-")} <=0.

false(S,p1) :- select(S), #sum { 1,V, act : activeedge(S, V , S, "+") ;
															 -1, V,inact : e(V,S,"+") } != 0.
false(S,p2) :- select(S), #sum {1, V,neg : activeedge(S,V,S,"-") } > 0.

accept(S,S) :- true(S,p1),true(S,p2),in(S).
accept(S,S) :- false(S,p1),out(S).
accept(S,S) :- false(S,p2),out(S).
