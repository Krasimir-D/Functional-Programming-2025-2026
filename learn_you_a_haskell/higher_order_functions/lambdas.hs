--Lambdas are a way of making anonymous functions that are used because we need a function that we'll use only once.
--We usually make a lambda function for the sole reason of passing it to a higher-order function
--Syntax: (\<param_1> <param_2> .. <param_n> -> <fn_body>)

--Lambdas are expressions and that's why we can pass them around just like that. The expression (\xs -> length xs > 15)
--returns a function that tells us whether a list has a length greater than 15.

--like any normal function, lambdas can take any number of parameters:

ghci> zipWith (\a b -> (a * 30 + 3) / b) [5,4,3,2,1] [1,2,3,4,5]
[153.0,61.5,31.0,15.75,6.6]

--you can pattern match in lambdas, like with any functions. However you can't define several patterns for one parameter, like making
--a [] and then (x:xs) pattern for the same parameter. If pattern matching fails in lambda functions, a runtime error occurs.

map (\(a,b) -> a + b) [(1,2),(3,5),(6,3),(2,6),(2,5)]
[3,8,9,8,7]

--we usually put lambdas in parenthesis, unless we want them to extend all the way to the right.
--Here's something interesting: Due to the ways functions are normally curried the following two
--functions are equivalent:

addThree :: (Num a) => a -> a -> a -> a
addThree x y z = x + y + z

AND

addThree = \x -> \y -> \z -> x + y + z

--the first notation is far more readable and the second one is pretty much a gimmick to illustrate currying
--However, there are times when using this notations is cool. One good example would be the "flip" function.

flip' :: (a -> b -> c) -> b -> a -> c
flip' f = \x y -> f y x

