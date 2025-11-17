--in Haskell functions can take functions as parameters and return functions as return values. A function that does either of those
--is called a higher-order function.

--officialy in Haskell, every function takes a single parameter. If that's true, how did we use functions that take more than one argument
--up to this point? Well, it's a clever trick actually. Up to this point every function ,which takes multiple parameters, that we've used has
--been a "curried" function. But what's a curried function. Well, it's easier to grasp that idea using an example:

--Let's first look at the "max" function. At first glance in looks like "max" takes two parameters and returns the one that's bigger.
--When doing "max 4 5" what actually happens is that it first creates a function which takes a parameter and returns either that parameter
--or 4, depending on which one is bigger. Then 5 is applied to that function and that function produces our desired result.

ghci> max 4 5
5

is equal to

ghci> (max 4) 5
5

--putting a space between things in Haskell is simply a function application. Spaces in Haskell are operators and their precedence is the
--highest of all. Let's take a look at the signature of "max"

ghci>:t max
max :: (Ord a) => a -> a -> a

--we can read the signature like this. "max" takes a parameter of type a and returns a function that takes a parameter of type a and
--returns a parameter of type a.

--so how is that beneficial to us? When calling a function with too few arguments, this produces a partially applied function
--which takes as many parameters as we've left out. This is neat way of creating new functions on the go, as we can pass them to
--another function or seed them with some data.

--let's take a look at this offensively simple function:

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

ghci> multThree 3 5 9
135

--what really happens when we call multThree is:
--(multThree 3) 5 )9). First 3 is applied to multThree, because they're separated by a space.This creates a function which takes a
--parameter and returns a function. So when 5 is applied to this function, this creates a function which takes a parameter and multiplies
--it to 15. Remember that this function:
--multThree :: (Num a) => a -> a -> a -> a could be written as:
--multThree :: (Num a) => a -> ( a -> ( a -> a ) )

--take a look at this:

ghci> let multTwoWithNine = multThree 9
ghci> multTwoWithNine 3 5
135
