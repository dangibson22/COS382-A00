--SOLI DEO GLORIA

isPrimeInner :: Int -> Int -> Bool
isPrimeInner n i =
    if n <= 1
        then False
    else if i <= 1 --Base Case 1 (no n from 2 to n-1 evenly divides n)
        then True
    else if (n `mod` i) == 0 --Base Case 2 (i is a factor of n)
        then False
    else isPrimeInner n (i-1) --Recursive Case (current iterator does not divide n)

--Wrapper function for isPrimeInner so I only have to enter the number in question
isPrime :: Int -> Bool
isPrime n = isPrimeInner n (n-1)

listPrimesInner :: Int -> Int -> [Int] -> [Int]
listPrimesInner low i primes =
    if i < low
        then primes
    else if isPrime i
        then listPrimesInner low (i-1) (primes ++ [i])
    else listPrimesInner low (i-1) primes

--Wrapper function. List the prime numbers within the range [a, b] inclusive
listPrimes :: Int -> Int -> [Int]
listPrimes a b = listPrimesInner a b []

{-
    Params: 
        query: const int -- the number input into the wraper function
        primesList: [int] -- the list of primes within the range (0, query) inclusive.
        currentAddends: [int] -- the list of primes currently being summed together to check for a valid partition
        minAvail: int -- Index of the smallest prime number in primesList available to be added to currentAddends
        startIdx: int -- Index of the smallest prime number possible for the first entry to Addends
        partitions: [[int]] -- the list of valid combinations, should result in the final answer
    Returns: partitions: [[int]] -- The list of all valid partitions
-}
primePartitionsInner :: Int -> [Int] -> [Int] -> Int -> Int -> [[Int]] -> [[Int]]
primePartitionsInner query primesList currentAddends minAvail startIdx partitions =
    if startIdx >= (length primesList) -- Base Case: No more primes are available
        then partitions
    else if (query - (sum currentAddends) - (primesList !! minAvail)) > 0 -- Case 1: Possibility of prime number being part of a partition
        then primePartitionsInner
            query
            primesList
            (currentAddends ++ [primesList !! minAvail])
            (minAvail + 1)
            startIdx
            partitions
    else if (query - (sum currentAddends) - (primesList !! minAvail)) == 0 -- Case 2: minAvail completes a valid partition
        then primePartitionsInner
            query
            primesList
            []-- start a new set for possible partition
            (startIdx + 1)--minAvail must not be less than start index
            (startIdx + 1)
            (partitions ++ [currentAddends ++ [primesList !! minAvail]])-- Appends current Partition with newest entry to partitions
    else -- Case 3: current combo one work. Backtrace a step and move to next item in Primes List
        primePartitionsInner
            query
            primesList
            (init currentAddends)-- init returns all but the last item of a list (essentially pops)
            minAvail-- Don't change back or else we will get infinite recursion
            startIdx
            partitions

--Wrapper function. Lists the partitions
primePartitions :: Int -> [[Int]]
primePartitions query = primePartitionsInner
    query
    (listPrimes 0 query)
    []
    0
    0
    []

testFunc :: Integer -> [[Integer]]
testFunc a = 
    let diff = (a - 8 - 3)
    in
        [[diff]]

main = do
    print (primePartitions 12)
