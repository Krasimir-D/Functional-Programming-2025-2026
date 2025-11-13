densityTell :: (RealFloat a) => a -> a -> String  
densityTell mass volume  
    | mass / volume < 1.2 = "Wow! You're going for a ride in the sky!"  
    | mass / volume <= 1000.0 = "Have fun swimming, but watch out for sharks!"  
    | otherwise   = "If it's sink or swim, you're going to sink."  

--here we defined a density calculator. Notice how for each guard we had to calculate the same expression twice.
--well, that's not very programmer like. We as coders don't like to repeat ourselves. Luckily for us, there is a construct in
--Haskell, called "where". We can modify our function like this:

densityTell :: (RealFloat a) => a -> a -> String  
densityTell mass volume  
    | density < 1.2 = "Wow! You're going for a ride in the sky!"  
    | density <= 1000.0 = "Have fun swimming, but watch out for sharks!"  
    | otherwise   = "If it's sink or swim, you're going to sink."
    where density = mass / volume

--we put the where keyword after the guards and we defined as much names and functions as we like
--they will all be visible across all guards and give us the advantage of not having to repeat ourselves.

--"where" bindings are not shared across different patterns across one function. If you want several patterns of one function to
--access the same shared name, you have to define it globally.

--we can use where bindings to pattern match as well

initials :: String -> String -> String
initials firstname lastname = [f] ++ "." ++ [l] ++ "."
          where (f : _) = firstname
                (l : _) = lastname

--just like we've defined constants in "where" bindings, lets stay true to our programming solids. 
--lets write a function that takes a list of volume mass pairs and returns a list of densities

calcDensities :: (RealFloat a) => [(a, a)] -> [a]
calcDensities xs = [ density x y | (x, y) <- xs]
        where density mass volume = mass / volume

--and that's all there is to it. "where" bindings can also be nested. It is a common idiom to define a helper function within a function and
--give a that helper function its own where binding as well.
              
