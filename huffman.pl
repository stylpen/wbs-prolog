% count occurrences of characters
% 
%sortedoccurencelist([FI|RI], O, O2]):-
%  O = [[C, F]|R],
%  (
%    member(FI, O), F:-occurences(C, O2).
%  )

% OCCURENCES
% stores number of occurences of second parameter in first parameter in third parameter.
% occurences("test", "t", X).
% X = 2 
occurences([], X, 0).

occurences([X|T], [X], Y):-
    occurences(T, [X], Z), Y is 1 + Z.
    
occurences([X1|T], [X], Z):-
    X1 \= X, occurences(T, [X], Z).

% OCCURENCELIST
% makes list of number of occurences per character in string
% occurencelist("test", [], X).
% X = [[116, 2], [101, 1], [115, 1]] 
occurencelist([], [], []).

occurencelist([], L, L).

occurencelist([X|T], OL, NL):-
    complexmember(X, OL),
    occurencelist(T, OL, NL).

occurencelist([X|T], OL, NL):-
    occurences([X|T], [X], E),
    append(OL, [[X, E]], HL),
    occurencelist(T, HL, NL).
    

% true if E is member of list of type [[A, 2], [B, 1], [C, 1]]
complexmember(E, [[A,B]|R]):- 
    E = A;
    complexmember(E, R).
