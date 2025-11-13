--"let" bindings
--much like "where" bindings are "let" bindings. "where" bindings are a syntactic construct that lets us bind to variables 
--in the end of a function and the whole function can see them, including all the guards.
--"let" bindings let us bind to variables anywhere and are expressions themselves, but are very local so they don't span across all guards.
--like any other construct in Haskell that lets us bind values to names, "let" constructs can be used to pattern-match.

cylinder :: (RealFloat a) => a -> a -> a
cylinder r h = 
    let sideArea = 2 * pi * r * h
        topArea = pi * r ^ 2
    in  sideArea + 2 * topArea

--the form is "let <some_bindings> in <expression>"
--for all we know for now, the same result could have been achieved using "where" bindings. The only difference we've noticed up untill this point is
--that where bindings are written at the end of a function and are visible in the whole function, whereas "let" bindings are to be written before the expression
--that they're used in.

--well, the big difference is that, as we already have said, "let" bindings are expressions themselves and could be put absolutely everywhere. Just like
--if constructs.

ghci> 4 * (let a = 9 in a + 1) + 2
42

--they can be also used to introduce functions in a local scope
ghci> [let square x = x * x in (square 5, square 3, square 2)]
[(25,9,4)]

--if we want to bind to several variables inline, obviously we can't do align them in columns.
--that why we can separate them using semi-columns

ghci> let square x = x^2; cubic x = x^3 in (square 2, cubic 2)
(4,8)
ghci> 

--using "let" bindings in list comprehensions as well
calcDist :: (RealFloat a) => [((a,a), (a,a))] -> [a]
calcDist list =
    [ distance
    | ((x1,y1), (x2,y2)) <- list
    , let distance = sqrt ((x2 - x1)^2 + (y2 - y1)^2)
    ]
