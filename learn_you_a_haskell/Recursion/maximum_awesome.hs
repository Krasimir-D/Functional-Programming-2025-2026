--"maximum" takes a list of things that derive from the Ord typeclass (therefore can be compared) and returns the maximum elements for that list
--think about how you'd implement such algorithm iteratively. You'd probably make a temporary variable, which would hold an intermediate result 
--for the biggest element, and you would iterate through the list, step by step. At first, the first element would be the biggest. When going over the
--second element you would conduct a check, whether its bigger than the current biggest number. If yes, then the element at index 2 becomes the biggest element
--and so on. Phew! That was a mouthful of an explanation. Let's see how a recursive implementation could look like
myMaximum :: (Ord a) => [a] -> a
myMaximum [] = error "maximum of empty list"
myMaximum [x] = x
myMaximum (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = myMaximum xs

--now that we have a general understanding of how recursion works and how to think recursively, let's make another recursive function.
--"replicate" is a function that takes an element an a number of occurances of that element in a list
myReplicate :: a -> Int -> [a]
myReplicate _ 0 = []
myReplicate x 1 = [x]
myReplicate x count = x : myReplicate x (count - 1)

--next, we'll try to replicate "take". This function takes a number of elements from a list. If the number is <= 0, then return [].
--if number > length list, return the whole list

myTake :: Int -> [b] -> [b]
myTake n list
    | n > length list = list
    | n <= 0 = []
    | null list = []
    | otherwise = head list : myTake (n - 1) (tail list)


--"reverse". That's a function that just takes a list and reverses it
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

--haskell supports infinite lists and that's why our recursion over lists doesn't really have to have an edge case.
--however, the result of such recursion would either result in in a endless recursion or an infinite list. The good thing
--about infinite lists, however is that we can easily just cut out a desired number of elements from that list
myRepeat :: a -> [a]
myRepeat x = x : myRepeat x

--"zip" takes two lists and produces a list of pairs. The first coordinate is always the element at a given n-th of the left list
--and the second coordinate is always the n-th element of the right list
--"zip" always cuts the longer list, so if we try to zip a list with an empty list, we'll get the empty list and there's our edge case
myZip :: [a] -> [b] -> [(a,b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x,y) : myZip xs ys

--"elem" takes an element and a lists and checks whether that element is in the list
myElem :: (Eq a) => a -> [a] -> Bool
myElem _ [] = False
myElem a (x:xs)
    | a == x = True
    | otherwise = myElem a xs

--quicksort
myQuicksort :: (Ord a) => [a] -> [a]
myQuicksort [] = []
myQuicksort (x:xs) =
    let smallerSorted = myQuicksort [a | a <- xs, a <= x]
        biggerSorted = myQuicksort [a | a <- xs, a > x]
    in smallerSorted ++ [x] ++ biggerSorted
