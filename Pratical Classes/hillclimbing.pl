slots(4).
disciplinas(12).
disciplina(1,[1,2,3,4,5]). % Os alunos 1,2,3,4,5 estão inscritos à disciplina 1
disciplina(2,[6,7,8,9]).
disciplina(3,[10,11,12]).
disciplina(4,[1,2,3,4]).
disciplina(5,[5,6,7,8]).
disciplina(6,[9,10,11,12]).
disciplina(7,[1,2,3,5]).
disciplina(8,[6,7,8]).
disciplina(9,[4,9,10,11,12]).
disciplina(10,[1,2,4,5]).
disciplina(11,[3,6,7,8]).
disciplina(12,[9,10,11,12]).

incompat(D1, D2, I):-
  disciplina(D1,LA1),
  disciplina(D2,LA2),
  findall(A,(member(A,LA1),member(A,LA2)),LA12),
  length(LA12,I).

faval(Sol,C):-
  findall(I,(nth1(D1,Sol,X),nth1(D2,Sol,X),D1<D2,incompat(D1,D2,I)),LI),
  sumlist(LI,C).

hc(Sol, SolF):-
  faval(Sol,C),
  vizinho(Sol,Sol2),
  faval(Sol1,C2),
  C2<C,
  !, write(Sol2:C2),nl,
  hc(Sol2,SolF).

hc(Sol,Sol).

vizinho(Sol,Sol2):-
  slots(NS),
  nth1(D,Sol,X),
  between(1,NS,Y),
  Y\=X,
  D1 is D-1,
  length(Pre,D1),
  append(Pre,[X|Pos],Sol),
  append(Pre,[Y|Pos],Sol2).
