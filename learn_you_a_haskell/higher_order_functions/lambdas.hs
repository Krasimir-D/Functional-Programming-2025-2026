--Lambdas are a way of making anonymous functions that are used because we need a function that we'll use only once.
--We usually make a lambda function for the sole reason of passing it to a higher-order function
--Syntax: (\<param_1> <param_2> .. <param_n> -> <fn_body>)

--Lambdas are expressions and that's why we can pass them around just like that. The expression (\xs -> length xs > 15)
--returns a function that tells us whether a list has a length greater than 15.

--like any normal function, lambdas can take any number of parameters:

ghci> zipWith (\a b -> (a * 30 + 3) / b) [5,4,3,2,1] [1,2,3,4,5]
[153.0,61.5,31.0,15.75,6.6]
