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

--the right fold function "foldr" works in the exact same way, only it folds a list starting from its last element and folding towards its head.
--Another difference of foldr is the binary function takes the current tail of the list as its left argument and the accumulator as its right, opposed to the case with foldl.
--This order makes sense since we're folding the list from right to left.

--The accumulator value can be of any type. It can be a number,a boolean or even a new list. We'll be implementing the "map" function with a right fold. We use foldr instead
--of foldl because the ":: is much cheaper than the "++" operation.

map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs

--The biggest difference between foldr and foldl is that foldr works on infinite lists, whereas left fold does not.

--"foldl1" and "foldr1" are pretty much the same, but with one exception. They don't need you to provide an accumator. Instead, they take the first(last) element of the list as a starting
--value for the accumulator. There's one caveat with this approach, however. These two functions assume that the list has at least one element, and therefore produce runtime errors when fed
--with empty lists.
