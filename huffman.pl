huffmanize(T, X) :- 
    occurrencelist(T, [], OL),
    sortswapped(OL, SOL),
    occurrencelist2tree(SOL, X).

% OCCURENCES
% stores number of occurences of second parameter in first parameter in third parameter.
% occurences("test", "t", X).
% X = 2 
occurences([], X, 0).

occurences([X|T], [X], Y):-
    occurences(T, [X], Z), Y is 1 + Z.
    
occurences([X1|T], [X], Z):-
    X1 \= X, occurences(T, [X], Z).

% OCCURRENCELIST
% makes list of number of occurences per character in string. first parameter is the string, second is the data structure passed to the function as input, last is the output
% occurencelist("test", [], X).
% X = [[116, 2], [101, 1], [115, 1]] 
occurrencelist([], L, L).

occurrencelist([X|T], OL, NL):-
    complexmember(X, OL),
    occurrencelist(T, OL, NL).

occurrencelist([X|T], OL, NL):-
    occurences([X|T], [X], E),
    append(OL, [[X, E]], HL),
    occurrencelist(T, HL, NL).
    
% COMPLEXMEMBER
% true if E is member of list of type [[A, 2], [B, 1], [C, 1]]
complexmember(E, [[A,B]|R]):- 
    E = A;
    complexmember(E, R).

% SORTSWAPPED
% swaps, sorts, swaps back
sortswapped([], []).

sortswapped(I, O):-
    swapelements(I, T),
    sort(T, S),
    swapelements(S, O).

% SWAPELEMENTS
% does this: [[f,3], [x, 4], [r, 2]] => [[r, 2], [f,3], [x, 4]]
swapelements([], []).

swapelements([[F,S]], [[S,F]]).

swapelements([[F,S]|R], [[S,F]|R2]):-
    swapelements(R, R2).

% TREE
% takes the leftmost two items and combines them into one node, afterwards
% sorts the list
tree([[X,NX],[Y,NY]|R], R2):-
    N is NX + NY, 
    sortswapped([[[[X, NX], [Y,NY]], N]|R], R2).

% FREQLIST2TREE
% takes an occurrencelist and turns it into a tree
occurrencelist2tree([FL], [FL]).
occurrencelist2tree([FLA,FLB|FLR], T):-
    tree([FLA, FLB|FLR], N),
    occurrencelist2tree(N, T).


% Depth First Search
dfs([T, X], T, L, L).

dfs(T, G, OL, NL):-
    [[X|R]] = T,
    append(OL, [5], Z),
    dfs(X, G, Z, NL),
    write(T),
    write('\neingepackt\n'),
    write(OL),
    write('\n'),
    write(X),
    write('\n'),
    write('\n').

dfs(T, G, OL, NL):-
    [X, Y|R] = T,
    append(OL, [1], Z),
    dfs(Y, G, Z, NL),
    write(T),
    write('\nrechts\n'),
    write(OL),
    write('\n'),
    write(Y),
    write('\n'),
    write('\n').

dfs(T, G, OL, NL):-
    [[X], M] = T,    
    append(OL, [4], Z),
    dfs(X, G, Z, NL),
    write(T),
    write('\nanders eingepackt\n'),
    write(OL),
    write('\n'),
    write(X),
    write('\n'),
    write('\n').

dfs(T, G, OL, NL):-
    [X|R] = T,
    append(OL, [0], Z),
    dfs(X, G, Z, NL),
    write(T),
    write('\nlinks\n'),
    write(OL),
    write('\n'),
    write(X),
    write('\n'),
    write('\n').

%[[[[121, 1], [[[101, 1], [104, 1]], 2]], 3]]
%  [[121, 1], [[[101, 1], [104, 1]], 2]]
%             [[[101, 1], [104, 1]], 2]
%              [[101, 1], [104, 1]]
             
             

