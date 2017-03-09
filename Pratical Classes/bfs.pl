bfs([[E|Cam]|R],[E|Cam]):-
  estado_final(E).

bfs([[E|Cam]|R],Sol):-
  findall([E2|[E|Cam]],sucessor(E,E2),Ls),
  append(R,Ls,L2),
  bfs(L2,Sol).


solve_bfs(Sol):-
  estado_inicial(Ei),
  bfs([[Ei]],Sol).
