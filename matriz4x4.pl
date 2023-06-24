%https://www.janko.at/Raetsel/Sudoku/Vergleich/001.a.htm

:- use_module(library(clpfd)).

n(1).
n(2).
n(3).
n(4).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

completa([X1, X2, X3, X4]) :- n(X1), n(X2), n(X3), n(X4),
                              todosDiferentes([X1, X2, X3, X4]).

solucao(MatrizSolucao) :-
    MatrizSolucao = tabuleiro([
                                [X11, X12,      X13, X14],
                                [X21, X22,      X23, X24],

                                [X31, X32,      X33, X34],
                                [X41, X42,      X43, X44]
                            ]),

    %tabuleiro do jogo (para resolver outro tabuleiro, alterar somente os operadores)
    X11 #< X12,                 X13 #< X14,
    X11 #> X21, X12 #< X22,     X13 #< X23, X14 #> X24,
    X21 #< X22,                 X23 #> X24,

    X31 #> X32,                 X33 #< X34,
    X31 #> X41, X32 #< X42,     X33 #< X43, X34 #> X44,
    X41 #> X42,                 X43 #> X44,

    %completa linhas
    completa([X11, X12, X13, X14]),
    completa([X21, X22, X23, X24]),
    completa([X31, X32, X33, X34]),
    completa([X41, X42, X43, X44]),

    %completa colunas
    completa([X11, X21, X31, X41]),
    completa([X12, X22, X32, X42]),
    completa([X13, X23, X33, X43]),
    completa([X14, X24, X34, X44]),

    %completa regiões
    completa([X11, X12, X21, X22]),
    completa([X31, X32, X41, X42]),
    completa([X13, X14, X23, X24]),
    completa([X33, X34, X43, X44]).
