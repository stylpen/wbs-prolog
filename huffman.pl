% HUFFMANIZE
% takes text and builds up huffman tree and encodes text using that tree
% huffmanize("test", X, Y).
% Tree is:
% [[[[116,2],[[[101,1],[115,1]],2]],4]]
% Encoded text is:
% [5,0,5,1,0,5,1,1,5,0]
% X = [[[[116, 2], [[[101, 1], [115, 1]], 2]], 4]],
% Y = [5, 0, 5, 1, 0, 5, 1, 1, 5|...] .
huffmanize(T, X, Y) :- 
    occurrencelist(T, [], OL),
    sortswapped(OL, SOL),
    occurrencelist2tree(SOL, X),
    write('Tree is:\n'),
    write(X),
    write('\nEncoded text is:\n'),
    encode(X, T, [], Y),
    write(Y).

% occurrencES
% stores number of occurrences of second parameter in first parameter in third parameter.
% occurrences("test", "t", X).
% X = 2 
occurrences([], X, 0).

occurrences([X|T], [X], Y):-
    occurrences(T, [X], Z), Y is 1 + Z.
    
occurrences([X1|T], [X], Z):-
    X1 \= X, occurrences(T, [X], Z).

% OCCURRENCELIST
% makes list of number of occurrences per character in string. first parameter is the string, second is the data structure passed to the function as input, last is the output
% occurrencelist("test", [], X).
% X = [[116, 2], [101, 1], [115, 1]] 
occurrencelist([], L, L).

occurrencelist([X|T], OL, NL):-
    complexmember(X, OL),
    occurrencelist(T, OL, NL).

occurrencelist([X|T], OL, NL):-
    occurrences([X|T], [X], E),
    append(OL, [[X, E]], HL),
    occurrencelist(T, HL, NL).
    
% COMPLEXMEMBER
% true if E is member of list of type [[A, 2], [B, 1], [C, 1]]
complexmember(E, [[A,B]|R]):- 
    E = A;
    complexmember(E, R).

% SORTSWAPPED
% swaps, sorts, swaps back
% does this: [[f, 3], [x, 4], [r, 2]] => [[r, 2], [f, 3], [x, 4]]
sortswapped([], []).

sortswapped(I, O):-
    swapelements(I, T),
    sort(T, S),
    swapelements(S, O).

% SWAPELEMENTS
% swaps
% does this: [[f, 3], [x, 4], [r, 2]] => [[3, f], [4, x], [2, r]] 
swapelements([], []).

swapelements([[F, S]], [[S, F]]).

swapelements([[F, S]|R], [[S, F]|R2]):-
    swapelements(R, R2).

% TREE
% takes the leftmost two items and combines them into one node, afterwards
% sorts the list
tree([[X, NX],[Y, NY]|R], R2):-
    N is NX + NY, 
    sortswapped([[[[X, NX], [Y, NY]], N]|R], R2).

% FREQLIST2TREE
% takes an occurrencelist and turns it into a tree
occurrencelist2tree([FL], [FL]).
occurrencelist2tree([FLA, FLB|FLR], T):-
    tree([FLA, FLB|FLR], N),
    occurrencelist2tree(N, T).


% Depth First Search
% dfs([[[[[105, 1], [109, 1]], 2], [[[101, 2], [[[103, 1], [104, 1]], 2]], 4]], 6], 104, [], L).
% L = [1, 1, 1]
dfs([T, X], T, L, L).
% go right -> append 1
dfs(T, G, OL, NL):-
    [[X, Y], N] = T,
    append(OL, [1], Z),
    dfs(Y, G, Z, NL).
% go left -> append 0
dfs(T, G, OL, NL):-
    [[X, Y], N] = T,
    append(OL, [0], Z),
    dfs(X, G, Z, NL).
    
    
% ENCODE
% takes a tree, a text, an input list and generates an output list
% encode([[[[116, 2], [[[101, 1], [115, 1]], 2]], 4]], "test", [], X).
% X = [0, 1, 0, 1, 1, 0]
encode(T, [], L, L).

encode([T], [C|R], OL, NL):-
    dfs(T, C, OL, TL),
    encode([T], R, TL, NL).
