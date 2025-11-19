--the function "map" takes a function and a list and applies that function to every element of the list, producing a new list.
--let's see what's the signature of that function:

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

--map is one of the most versatile higher-order functions, that can be used in millions of ways.

ghci> (+3) [1,3,5,1,6]
[4,6,8,4,9]

ghci> map (++ "!") ["Bang", "Bam", "Kachow"]
["Bang!", "Bam!", "Kachow!"]

ghci> map (replicate 3) [3..6]
[[3,3,3],[4,4,4],[5,5,5],[6,6,6]]

ghci> map (map(^2)) [[1,2,], [3,4,5,6], [7,8]]
[[1,4], [9, 16, 25, 36], [49, 64]]

--you may've noticed that each of these could've been achieved using list comprehensions only. map (+3) [1,3,5,1,6]
--is the same as [x + 3 | x <- [1,3,5,1,6]]. However using map is more readable for cases where you apply a function to the elements of a list
--especially for cases that require the usage of maps of maps.

--the "filter" function takes a two parameters. A function-predicate, a list and returns a new list. A predicate is a function that returns a boolean value.
--it checks whether an element of that list satisfies some condition, if yes, then that list will appear in the result-list. If no, then it won't be included

filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter f (x:xs)
  | f x == True = x : filter f xs
  | otherwise = filter f xs

--Pretty simple stuff. If f evaluates to True x is included in the list. Let's look at some examples

ghci> filter (>3) [1,15,3,42,87,7, 2, 5]
[15,42,87,7,5]

ghci> filter even [1..19]
[2,4,6,8,10,12,14,16,18]

ghci> filter (`elem` ['A'..'Z']) "i Laugh At you Because u R All The Same"  
"LABRATS"

--all this could've been achieved using list comprehensions only. There's not rule of thumb on when to use "map" and "filter" or list comprehensions.
--you just have to decide which is more readable depending on the context of the code. The filter equivalent of applying several predicates in a list comprehension
--is filtering something several times or joining several predicates using the && logical function. Remember our quicksort implementation.
--we used list comprehensions for it. Let's see how it would look using "filter" instead

myQuicksort :: (Ord a) => [a] -> [a]
myQuicksort [] = []
myQuicksort (x:xs) =
    smallerList ++ [x] ++ biggerList
    where 
        smallerList = myQuicksort (filter (<= x) xs)
        biggerList = myQuicksort (filter (> x) xs)

--"takeWhile" takes a predicate and list and returns elements while they satisfy the predicate. We want
