% divisible is a recursive predicate that, given if X and Y, range(Y, X) is divisible by X
divisible(X, Y) :- 0 is X mod Y, !.
divisible(X, Y) :- X > Y + 1, divisible(X, Y+1).

% tells if number is prime.
% - 2 is prime
% - 1 or lower is not prime
% - number is prime if it is not divisible by any other number
isPrime(X) :-
  X = 2 -> true ;
  X < 2 -> false ;
  not(divisible(X, 2)).

primePartitions(N, K, List) :-
  N = 0 ->
  (
    % remainder is 0 means sum(lst) = original number
    % lst is now the prime partition
    forall(
      member(Prime, List),
      (
        write(Prime),
        last(List, Prime) -> ( write("") ) ; ( write(" + ") )
      )
    ),
    writeln("")
  ) ; 
  N > K ->
  (
    % might have primes that can contribute to partition
    % iterate over all numbers remaining
    Z is K + 1,
    forall(
      between(Z, N, P),
      (
        % if P is prime, add it to List and activate recursion
        isPrime(P) ->
        (
          append(List, [P], NewList),
          NewN is N - P,
          primePartitions(NewN, P, NewList)
        )
        ;
        write("")
      )
    )
  )
  ;
  write("").

runPrimePartitions(N) :- primePartitions(N, 1, []).