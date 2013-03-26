% count occurrences of characters
% 
%sortedoccurencelist([FI|RI], O, O2]):-
%  O = [[C, F]|R],
%  (
%    member(FI, O), F:-occurences(C, O2).
%  )

occurences([], X, 0).

occurences([X|T], [X], Y):-
    occurences(T, [X], Z), Y is 1 + Z.
    
occurences([X1|T], [X], Z):-
    X1 \= X, occurences(T, [X], Z).

occurencelist([], [], []).
occurencelist([], OL, OL).

occurencelist([X|T], OL, NL):-
    complexmember(X, OL),
    occurencelist(T, OL, NL).

occurencelist([X|T], OL, NL):-
    occurences([X|T], [X], E),
    append(OL, [[X, E]], NL),
    occurencelist(T, NL, NL).
    

% true if E is melber of list of type [[A, 2], [B, 1], [C, 1]]
complexmember(E, [[A,B]|R]):- 
    E = A;
    complexmember(E, R).
