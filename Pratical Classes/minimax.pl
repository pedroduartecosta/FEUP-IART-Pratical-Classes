%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Formalização do jogo dos palitos:
% - existem inicialmente 10 palitos sobre a mesa
% - cada jogador pode retirar um, dois ou três palitos na sua vez
% - o objectivo é evitar ficar com o último palito
%%%%%%%%%%

% a representação do estado vai incluir também o jogador a jogar,
% pois neste jogo é importante para efeitos de avaliação do estado

% representação de um estado: (NumeroPalitos, Quemjoga)

estado_inicial((10,max)).

% estado final (ter 0 palitos é bom): só interessa para o minimax simples
estado_final((0,max), 1).
estado_final((0,min), 0).

% transições entre estados (as jogadas são as mesmas para os 2 jogadores)
sucessor((N,max), max, (N1,min)) :- N>0, N1 is N-1.
sucessor((N,max), max, (N1,min)) :- N>1, N1 is N-2.
sucessor((N,max), max, (N1,min)) :- N>2, N1 is N-3.
sucessor((N,min), min, (N1,max)) :- N>0, N1 is N-1.
sucessor((N,min), min, (N1,max)) :- N>1, N1 is N-2.
sucessor((N,min), min, (N1,max)) :- N>2, N1 is N-3.


% run:  ?-minimax((10,max),max,V,I)


maxvalue([E],V,E):-minimax(E,min,V,_).
maxvalue([E|Es],V,ME):-
  minimax(E,min,V1,_),
  maxvalue(Es,V2,E2),
  (V1>V2,!,ME=E,V=V1;
  ME=E2,V=V2).

minvalue([E],V,E):-minimax(E,max,V,_).
minvalue([E|Es],V,ME):-
  minimax(E,max,V1,_),
  minvalue(Es,V2,E2),
  (V1<V2,!,ME=E,V=V1;
  ME=E2,V=V2).

minimax(E,_,V,_):-estado_final(E,V).
minimax(E,max,V,J):-
  findall(E2,sucessor(E,max,E2),Ls),
  maxvalue(Ls,V,J).
minimax(E,min,V,J):-
  findall(E2,sucessor(E,min,E2),Ls),
  minvalue(Ls,V,J).
