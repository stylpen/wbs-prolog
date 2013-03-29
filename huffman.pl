% count occurrences of characters
% 
%sortedoccurencelist([FI|RI], O, O2]):-
%  O = [[C, F]|R],
%  (
%    member(FI, O), F:-occurences(C, O2).
%  )

huffmanize(X) :- 
    I = 'I am the input string containing lots of text'.

occurences([],X,0).
occurences([X|T],[X],Y) :- count(T,[X],Z), Y is 1+Z.
occurences([X1|T],[X],Z) :- X1\=X,count(T,[X],Z).

% true if E is melber of list of type [[A, 2], [B, 1], [C, 1]]
complexmember(E, [[A,B]|R]) :- 
    E = A;
    complexmember(E, R).

sortswapped([], []).
sortswapped(I, O) :- swapelements(I, T), sort(T, S), swapelements(S, O).

%does this: [[f,3], [x, 4], [r, 2]] => [[r, 2], [f,3], [x, 4]]
swapelements([], []).
swapelements([[F,S]], [[S,F]]).
swapelements([[F,S]|R], [[S,F]|R2]) :- swapelements(R, R2).

tree([[X,NX],[Y,NY]|R], R2) :- N is NX+NY, sortswapped([[[[X,NX],[Y,NY]],N]|R],R2).

freqlist2tree([FL], [FL]).
freqlist2tree([FLA,FLB|FLR], T) :- tree([FLA,FLB|FLR], N), freqlist2tree(N, T).
