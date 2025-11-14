--so far we've run into loads of data types, such as Int, Integer, Bool, Float, Char, Maybe.
--but how do we make our own. Well, one way is to use the "data" keyword
--let's see how the Bool type is defined in the standard library

data Bool = False | True

--the part before the "=" denotes the type which is Bool. The part after the "=" are value constructors. They specify the different values this type can have
--the | is read as "or".

--now let's think about how we would represent a shape in Haskell. Circle for instance. One way would be to use a tuple of three Floats
--(43.2, 55.0, 10.4), where the first two arguments are the x and y coordinates of the circle's centre and the third one is its radius.
--that would work just fine but this tuple is ambigious and could represent a 3d vector as well. A better solution would be to write our own
--type to represent a shape. Let's say that a shape can be a circle or a rectangle.

data Shape = Circle Float Float Float | Rectangle Float Float Float Float

--what value constructors essentially are is a function which returns a value of a data type

surface :: Shape -> Float
surface (Circle _ _ r) = pi * r ^ 2
surface (Rectangle x1 y1 x2 y2) (abs x2 - x1) * (abs y2 - y1)

--we can pattern match against value constructors as we have been doing all along btw

--let's say now we wanted to print out Circle 10 20 5 on the console. That will cause an error, because Haskell doesn't know how to
--do that yet. Remember, when we try to print a value out in the prompt, Haskell first runs "show". To make Shape type a part of the Show typeclass
--we can modify it like this:

data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)

--we can of course export our data types in a custom module

--Record syntax
--there is another way of defining our own types.
data Shape = Circle {x :: Float, y :: Float, rad :: Float} | Rectangle {x1 :: Float, y1 :: Float, x2 :: Float, y2 :: Float} deriving (Show)

--one cool thing about this syntax is that it generates function with the same name as each field, that can extract the corresponding field of any object
--of that type.
--another neat thing is that we can create an object using a value constructor without following the order of parameters as long as we specify the correct label

circle = Circle {y=0, rad=5, x=0}

--and last but not least important thing is that by defining a data type in that way, we change the behaviour of "show" we deriving the Show typeclass
--it prints an object in a much cleaner way

--ghci> show circle 
"Circle {x = 0.0, y = 0.0, rad = 5.0}"
