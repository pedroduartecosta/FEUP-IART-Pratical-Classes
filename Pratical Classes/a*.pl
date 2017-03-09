/*
For A* to achieve best results, heuristics should be positive
A*:f=g+h
*/

sucessor(b(X,Y),b(4,Y),C):-
  X<4,
  C is 4-C.

/*heuristica*/
h(b(X,Y),H):-
  estadofinal(b(Xf,Yf)),
  H is max(abs(X-Xf),abs(Y-Yf)).


astar(F,G,[[E|Can]|R],Sol):-
    write(E:F:G),nl,
    findall(F2,G2,[E2|[E|Can]] ,(sucessor(E,E2,C),G2 is G+C,h(E2,H2),F2 is G2+H2), Ls),
    append(R,Ls,L2),
    sort(L2,L2ord),
    astar(L2ord,Sol).


solve_astar(Sol):-
  estadoinicial(Ei),h(Ei,Hi),
  astar([(Hi,0,[Ei])],Sol).
