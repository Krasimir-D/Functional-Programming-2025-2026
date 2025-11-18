--Functions can take functions as arguments and can also return functions. To illustrate this, we're going to make a function that takes a function as parameter and
--applies it twice

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

--First of all, notice the type declaration here. Before we didn't need parentheses, because "->" is naturaly right-associative. However, here they're mandatory.
--They indicate that the first parameter is a function that takes something and return the same thing. We can read the type declaration of our function in the 
--curried way, but to save ourselves the headache, we'll just say that the function takes two parameters and returns one thing.
