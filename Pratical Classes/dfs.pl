dfs(E0,_,[E]):-estado_final(E).

dfs(E,Visited,[E|Es]):-
  sucessor(E,E2), \+ member(E2,Visited),
  dfs(E2,[E2|Visited],Es).

solve_dfs(Sol):-
  estado_inicial(Ei),
  dfs(Ei,[Ei],Sol).
