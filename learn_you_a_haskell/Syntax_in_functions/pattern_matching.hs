--pattern matching is a mechanism in haskell that consists of specifying a pattern for a function to which some data
--should conform and checking if it does and deconstructing the data to those patterns
--we can think of it as an analogy of switch-statements in C.

--The placement of each case matters. Therefore, more generic ones should come last.

--recursive factorial function that displays the use of pattern matching
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * Factorial (n - 1)

--if we were to put the second pattern ahead of the first, it would catch all numbers, including 0
--that would trigger an endless loop

--obviously, pattern matching can also fail if we pass some data to a function that does not conform
--to any of the defined patterns.

charName :: Char -> String
charName a = "Albert"
charName b = "Brenda"
charName c = "Carlos"

--and then if we call charName with an input it doesn't expect we would get an error like this:
--"Exception: Non-exhaustive patterns in function charName" 

--Therefore all of our function should include some kind of catch-all pattern, so our program doesn't crash

--we can use pattern matching on tuples as-well
--lets say we want to define a function that adds two 2d vectors together:

addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

--there are built-in functions for extracting the first and the second element of a tuple with two element
--Those functions are "fst" and "snd". However there are no such functions that work on a triple.
--we can define them using pattern matching

first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

--the "_" means exactly what it means in list comprehensions. That we don't care what that part is, so we just write "_"
--we can use pattern-matching in list comprehensions as well. Look at this:

ghci> let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]  
ghci> [a+b | (a,b) <- xs]  
[4,7,6,8,11,4] 

--lists themselves can be used in pattern matching. You can match with the empty list "[]" or any pattern that involves ":"
--and the empty list.

--there is a thing called "as patterns". This is a way to split some data using some pattern whilst still keeping a reference to the original data.

capital :: String -> String
capital [] = "Invalid input! String is empty"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x] 
