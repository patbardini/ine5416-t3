%https://www.janko.at/Raetsel/Sudoku/Vergleich/010.a.htm

:- use_module(library(clpfd)).

% predicado para exibir a matriz de solução linha por linha
exibirMatriz([]).
exibirMatriz([L|Ls]) :-
    write(L), nl,
    exibirMatriz(Ls).

solucao(MatrizSolucao) :-
    MatrizSolucao = [[X11, X12,      X13, X14,      X15, X16],
                     [X21, X22,      X23, X24,      X25, X26],
                     [X31, X32,      X33, X34,      X35, X36],

                     [X41, X42,      X43, X44,      X45, X46],
                     [X51, X52,      X53, X54,      X55, X56],
                     [X61, X62,      X63, X64,      X65, X66]],
    
    % transforma a matriz em uma lista contendo todos os elementos da matriz
    flatten(MatrizSolucao, Elementos),
    % elementos devem assumir valores de 1 a 6
    Elementos ins 1..6,

    % tabuleiro do jogo (para resolver outro tabuleiro, alterar somente os operadores)
    X11 #> X12,                 X13 #> X14,                 X15 #< X16,
    X11 #> X21, X12 #> X22,     X13 #> X23, X14 #< X24,     X15 #< X25, X16 #> X26,
    X21 #> X22,                 X23 #< X24,                 X25 #> X26,
    X21 #> X31, X22 #< X32,     X23 #< X33, X24 #> X34,     X25 #> X35, X26 #> X36,
    X31 #< X32,                 X33 #> X34,                 X35 #> X36,

    X41 #< X42,                 X43 #> X44,                 X45 #< X46,
    X41 #< X51, X42 #> X52,     X43 #> X53, X44 #> X54,     X45 #< X55, X46 #< X56,
    X51 #> X52,                 X53 #< X54,                 X55 #< X56,
    X51 #> X61, X52 #< X62,     X53 #< X63, X54 #> X64,     X55 #< X65, X56 #> X66,
    X61 #< X62,                 X63 #> X64,                 X65 #> X66,
    
    % verifica se há algum elemento repetido nos blocos 
    all_different([X11, X12, X21, X22, X31, X32]),
    all_different([X13, X14, X23, X24, X33, X34]),
    all_different([X15, X16, X25, X26, X35, X36]),
    all_different([X41, X42, X51, X52, X61, X62]),
    all_different([X43, X44, X53, X54, X63, X64]),
    all_different([X45, X46, X55, X56, X65, X66]),
    
    % verifica se há algum elemento repetido nas linhas
    maplist(all_different, MatrizSolucao),

    % verifica se há algum elemento repetido nas colunas
    transpose(MatrizSolucao, Transposta),
    maplist(all_different, Transposta),

    % busca de soluções
    label(Elementos).
