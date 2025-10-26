--typeclasses are very similar to what interfaces are in Java. They specify a given behavior and
--any type that belongs to a typeclass must implement it's functionality

--lets check what's the type of the (==) function
--if we type ":t (==)" we get the following "(==) :: (Eq a) => a -> a -> Bool"
--we see a new thing in this output, that's the "=>" symbol.
--everything that sits before  the "=>" symbol is called a class constraint
--we can read the previous type declaration like this:
--"the equality function takes any two values that are of the same type and returns a Bool.
--The type of those values must be a member of the Eq class."(this was the type constraint)

--The "Eq" typeclass
--The Eq class is used for types that support testing. The functions its members implement are
--1. == equality
--2. /= inequality

ghci> 5 == 5
True
ghci> 5 /= 5
False
ghci> 'a' == 'a'
True
ghci> "Ho Ho" == "Ho Ho"
True
ghci> 3.432 == 3.432
True

--The "Ord" typeclass
--Ord is for types that have an ordering
--The functions its members implement are
--1.(<)
--2.(>)
--3.(>=)
--2.(<=)
--To be a member of the Ord class one must a member of the Eq class first

-- ghci> :t (>)
-- (>) :: (Ord a) => a -> a -> Bool

--The Show typeclass
--Members of the Show class can be presented as strings
--The most used function that deals with the Show typeclass is "show"
--It takes a value whose type is a member of Show and represents it as a string

ghci> show 3
"3"
ghci> show 5.334
"5.334"
ghci> show True
"True"

--The Read typeclass
--Read is the absolute opposite of the Show. Members of the Read class can be parsed 
--from a string that comes from the standart input into the correct type

ghci> read "True" || False
True
ghci> read "8.2" + 3.8
12.0
ghci> read "5" - 2
3
ghci> read "[1,2,3,4]" ++ [3]
[1,2,3,4,3]

--So far, so good, but what would happen if we only tried reading "4"

ghci> read "4"
<interactive>:1:0:
    Ambiguous type variable `a' in the constraint:
      `Read a' arising from a use of `read' at <interactive>:1:0-7
    Probable fix: add a type signature that fixes these type variable(s)
--What happens here is that the compiler can't infer what the type is due to the lack of context
--If we look back at the previous uses of read, we wrote, we can notice that we always did something with the parsed value
--Let's look at the type of "read" once again

ghci> :t read
read :: (Read a) => String -> a

--See? It returns a type that's part of the Read class but if we don't use the result in some way later
--it has no way of knowing which type.
--That's why we can use explicit type annotations

ghci> read "5" :: Int
5
ghci> read "3.42" :: Float
5.42
ghci> (read "5" :: Float) * 4
20.0
ghci> read "[1,2,3,4]" :: Int
[1,2,3,4]
ghci> read "(3, 'a')" :: (Int, Char)
(3, 'a')

--The Enum typeclass. The members of this class can be sequentially enumerated. The main advantage of the Enum typeclass
--is that we can use its types in list ranges. Types in this class are (), Bool, Int, Integer, Float, Double

ghci> ['a'..'e']
"abcde"
ghci> [LT .. GT]
[LT,EQ,GT]
ghci> [3 .. 5]
[3,4,5]
ghci> succ 'B'
'C'

--They have also defined successors and predecesors, which you can get using the "succ" and "pred" functions

--The Bounded typeclass
--Bounded members have upper and lower bound
ghci> minBound :: Int
-2147483648
ghci> maxBound :: Char
'\1114111'
ghci> maxBound :: Bool
True
ghci> minBound :: Bool
False

--All tuples are a Bounded member as well
ghci> maxBound :: (Char, Bool, Int)
(True,2147483647,'\1114111')

--Num is a numeric typeclass. Its members have the property of acting like
--numbers. Let's examine the type of a number

ghci> :t 20
20 :: (Num t) => t

--It appears that whole numbers also act like polymorphic constants. 
--They can act like any type that's a member of the Num typeclass.

ghci> 20 :: Int
20
ghci> 20 :: Integer
ghci> 20 :: Double

--If we examine the type of * we'll see that it accepts any member of Num
ghci> :t (*)
(*) :: (Num a) => a -> a -> a

--It takes two numbers of the same type and returns a number of that exact type.
--That's why (5 :: Integer) * (3 :: Int) will result in an error.
--To join the Num typeclass, one must be a friend of Eq and Show beforehand

--Integral is a numeric typeclass, also. Num includes all numbers, including real and integral.
--Integral only includes Int and Integer

--Floating includes only Float and Double

--"fromIntegral" is a vital function for working with Floating and Integral numbers at the same time
--it has the following type declaration

ghci> :t fromIntegral
fromIntegral :: (Integral a, Num b) => a -> b

--as we can see from the type declaration of "fromIntegral"
--the function takes an Integral number and converts it into a more general number