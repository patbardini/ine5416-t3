% https://www.janko.at/Raetsel/Sudoku/Vergleich/001.a.htm

:- use_module(library(clpfd)).

% predicado para exibir a matriz de solução linha por linha
exibirMatriz([]).
exibirMatriz([L|Ls]) :-
    write(L), nl,
    exibirMatriz(Ls).

solucao(MatrizSolucao) :-
    MatrizSolucao = [[X11, X12,      X13, X14],
                     [X21, X22,      X23, X24],

                     [X31, X32,      X33, X34],
                     [X41, X42,      X43, X44]],

    % transforma a matriz em uma lista contendo todos os elementos da matriz
    flatten(MatrizSolucao, Elementos),
    % elementos assumem valores de 1 a 4
    Elementos ins 1..4,

    % tabuleiro do jogo (para resolver outro tabuleiro, alterar somente os operadores)
    X11 #< X12,                 X13 #< X14,
    X11 #> X21, X12 #< X22,     X13 #< X23, X14 #> X24,
    X21 #< X22,                 X23 #> X24,

    X31 #> X32,                 X33 #< X34,
    X31 #> X41, X32 #< X42,     X33 #< X43, X34 #> X44,
    X41 #> X42,                 X43 #> X44,

    % verifica se há algum elemento repetido nas regiões 
    all_different([X11, X12, X21, X22]),
    all_different([X31, X32, X41, X42]),
    all_different([X13, X14, X23, X24]),
    all_different([X33, X34, X43, X44]),
    
    % verifica se há algum elemento repetido nas linhas
    maplist(all_different, MatrizSolucao),

    % verifica se há algum elemento repetido nas colunas
    transpose(MatrizSolucao, Transposta),
    maplist(all_different, Transposta),

    % busca de soluções
    label(Elementos).
