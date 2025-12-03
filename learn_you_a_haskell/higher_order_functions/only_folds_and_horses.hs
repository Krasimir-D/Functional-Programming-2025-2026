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

