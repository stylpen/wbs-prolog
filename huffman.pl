% count occurrences of characters
% 
%sortedoccurencelist([FI|RI], O, O2]):-
%  O = [[C, F]|R],
%  (
%    member(FI, O), F:-occurences(C, O2).
%  )

occurences([],X,0).
occurences([X|T],[X],Y):- count(T,[X],Z), Y is 1+Z.
occurences([X1|T],[X],Z):- X1\=X,count(T,[X],Z).

% true if E is melber of list of type [[A, 2], [B, 1], [C, 1]]
complexmember(E, [[A,B]|R]):- 
    E = A;
    complexmember(E, R).

%does this: [[f,3], [x, 4], [r, 2]] => [[r, 2], [f,3], [x, 4]]
swapelements([], []).
swapelements([[F,S]], [[S,F]]).
swapelements([[F,S]|R], [[S,F]|R2]) :- swapelements(R, R2).
