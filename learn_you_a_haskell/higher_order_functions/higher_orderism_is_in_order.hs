--Functions can take functions as arguments and can also return functions. To illustrate this, we're going to make a function that takes a function as parameter and
--applies it twice

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

--First of all, notice the type declaration here. Before we didn't need parentheses, because "->" is naturaly right-associative. However, here they're mandatory.
--They indicate that the first parameter is a function that takes something and return the same thing. We can read the type declaration of our function in the 
--curried way, but to save ourselves the headache, we'll just say that the function takes two parameters and returns one thing.

--Now, we're going to use higher order programming to implement a very useful function that already exists in the standart library. It's called "zipWith" and it takes
--three parameters. One function and two lists and zips the lists by applying the function between the corresponding elements in both lists.

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] = []
myZipWith [] _ = []
myZipWith f (x:xs) (y:ys) = x `f` y : myZipWith f xs ys 

--now we're going to implement yet another function that's already in the standart library. It's called "flip". What flip does is that it takes a function and returns a
--new function only the first two parameters of that function are swapped.

myFlip :: (a -> b -> c) -> (b -> a -> c)
myFlip f = g
    where g x y = f y x

--here we take advantage of the fact that function in Haskell are curried. When doing flip f without the parameters x y, it will return an f which 
--that takes those two elements but calls them flipped

ghci> myFlip zip [1,2,3,4,5] "Hello"
[('H', 1), ('e', 2), ('l', 3), ('l', 4), ('o', 5)]
