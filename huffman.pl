% count occurrences of characters
% 
sortedoccurencelist([FI|RI], O, O2]):-
  O = [[C, F]|R],
  (
    member(FI, O), F:-occurences(C, O2).
  )

occurences([],X,0).
occurences([X|T],[X],Y):- count(T,[X],Z), Y is 1+Z.
occurences([X1|T],[X],Z):- X1\=X,count(T,[X],Z).

% true if E is melber of list of type [[A, 2], [B, 1], [C, 1]]
complexmember(E, [[A,B]|R]):- 
    E = A;
    complexmember(E, R).