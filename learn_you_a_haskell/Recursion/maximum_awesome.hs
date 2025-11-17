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


