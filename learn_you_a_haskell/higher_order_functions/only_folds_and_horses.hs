--Back when we were dealing with recursion we noticed a certain theme throughout many of the 
--recursive functions that operated on lists.
--Usually, we would have an edge case for an empty list. Then we'd introduce the (x:xs) pattern
--and then we'd do some action that involves a single element and the rest of the list.
--Turns out this is a very common pattern, so a couple of very useful functions were introduced
--to encapsulate it. These functions are called "folds". They're sort of like "map" functions,
--only they reduce the list to a single element.

--A fold takes a binary function, a starting value(we'll call this starting value accumulator) and a list to fold up.
--The binary function is called with the accumulator and the first(last) element of the list and produces a new accumulator.
--Then the binary function is called with the new accumulator and the new first(last) element of the list, and so on.
--Once we've walked over the whole list, only the accumulator remains, which is what the list is reduced to.

--Let's first take a look at the "foldl" function, also called the left fold function. It folds a list from left to right.
--The binary function is applied between the starting value and the head of the list. That produces a new accumulator and the binary function
--is then applied between the new accumulator and the next element in the list, etc.

--let's implement sum function again, but using the foldl instead of explicit recurion over the list.
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

--Let's rewrite the "elem" function that checks whether an value is an element of a list, using fold before moving onto right folds
elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys

--let's go over how this implementation operates real quick. The starting value(accumulator) here is a boolean. We'll start of with a False. It makes
--sense to start with a False. We assume the value is not present in the list. Also, if we call foldl on an empty list, the result will just be the starting value.
--Then we check if the current element is the value we're looking for. If it is, we set the accumulator to True. If it's not we just leave the value of the accumulator unchanged.

