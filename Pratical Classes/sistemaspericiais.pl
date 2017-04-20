:-dynamic(facto/3).

% Regra 1
% se motor=nao e bateria=nao entao problema=bateria com fc=1

questionavel(motor,'O motor funciona?', [sim, nao]).

deduz(A,V,FC):-
  se Premissa entao A=V com fc=FCRegra,
  prova(Premissa,FCPremissa),
  FCNovo is FCPremissa * FCRegra,
  atualiza(A,V,FCNovo),
  fail.

deduz(A,V,FC):-
  facto(A,V,FC).

prova(A=V, FC):-
  verifica(A,V;FC).

prova(A=V e PS,FC):-
  verifica(A,V,FC1),
  prova(Ps,FC2),
  FC is menor(FC1,FC2).

atualiza(A,V;FCNovo):-
  facto(A,V,FCVelho),
  FC is FCNovo + FCVelho *(1-FCNovo),
  retract(facto(A,V,FCVelho)),
  assert(facto(A,V,FC)).

atualiza(A,V,FC):-
  asser(facto(A,V,FC)).


:-op(800,xfy,e)
%facto(A,V,Fc)

verifica(A,V,Fe):-
  facto(A,V,Fc), !.

verifica(A,V,Fc):-
  facto(A,V2,_), V2\=V,
  !,fail.

verifica(A,V,Fc):-
  questionavel(A,P,LR),
  write(P:LR), read(R),
  wirte('certeza:'), read(FC),
  assert(facto(A,R,FC)),   %guarda para a memoria de trabalho
  !, V=R.   %se o valor lido unificar com o valor esperado, continuamos a usar a Regra

verifica(A,V,FC):-
  deduz(A,V,FC).

% Para testar:
/*
?- verifica(problema,V,FC).

*/
