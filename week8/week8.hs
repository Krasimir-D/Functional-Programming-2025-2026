import Control.Applicative (ZipList(..))
--The Functor typeclass
main = do
    line <- getLine
    let line' = reverse line
    putStrLn $ "You said " ++ line' ++ " backwards!"
    putStrLn $ "You really said " ++ line' ++ " backwards!"

--here's how to rewrite this, using fmap
main2 = do
    line <- fmap reverse getLine
    putStrLn $ "You said " ++ line ++ " backwards!"

--Functors redux
--functors are things that can be mapped over, like lists, Maybe's, trees and such.
--In Haskell they're described by the Functor typeclass, which has only one typeclass
--method. fmap::(a -> b) -> f a -> f b. It says: give me a function that takes an argument
--a and returns b and a box with an a(or several of them) and I'll give you a box with b (or several of them) inside it.

--Making a type constructor an instance of Functor
--to make a type constructor an instance of Functor it has to be of kind * -> *,
--which means it takes one concrete value and returns another concrete value
--one example would be Maybe, cause it takes one concrete value to produce values such as
--Maybe String, Maybe Int and such

--If a type constructor takes two parameters, like Either, we have to partially apply the type constructor until it take one 
--type parameter. Hence the following would be wrong

-- instance Functor Either where

--however, we could write:

-- instance Functor (Either a) where
--and we can imagine that fmap is only for Either a, it would have a type declaration
--fmap :: (b -> c) -> Either a b -> Either a c.
-- as you can see the "Either a" part is fixed, because Either a takes only one type parameter

-- We've learned by now how a lot of types (well, type constructors, really) are instances of Functor, like
-- [], Maybe, Either a. We saw how we map functions over them for great good. Now we'll take a look at two more
-- instances of Functor, namely IO and (->) r.

--Let's see how IO is an instance of Functor.
--When we fmap a function over an IO action, we want to get back an IO action that does the same thing
--but has our function applied to the result of that action

-- instance Functor IO where
--     fmap f action = do
--         result <- action
--         return (f result)

-- main1 = do
--     line <- getLine
--     let line' = reverse line
--     putStrLn $ "You said " ++ line' ++ " backwards"
--     putStrLn $ "You really said " ++ line' ++ " backwards"

-- main2 = do
--     line <- fmap reverse getLine
--     putStrLn $ "You said " ++ line' ++ " backwards"
--     putStrLn $ "You really said " ++ line' ++ " backwards"

-- Another instance of Functor that we've been dealing with all along, but didn't know it was a Functor is
-- (->) r. But what's (->) r
-- The function "r -> a" can be rewritten as "(->) r a"
-- Now we can see (->) in a different light. It's just a type constructor that takes two type parameters, just like Either
-- But since Functor has to take exactly one type parameter, we have to partially apply (->) and that's how we end up with (->) r

--Let's see how (->) r is an instance of Functor.

-- instance Functor ((->) r) where
--     fmap f g = (\x -> f (g x))

-- first of all, let's thing of fmap's type
-- fmap :: (a -> b) -> f a -> f b
-- now, if we mentally replace all f's with our functor, i.e., (->) r
-- fmap :: (a -> b) -> (->) r a -> (->) r b

-- now, this we can rewrite as infix functions
-- fmap :: (a -> b) -> (r -> a) -> (r -> b)

-- now what does this function type tell us?
-- mapping a function over a function gives us a new function, just like mapping a function over a Maybe
-- gives us a Maybe value.

--what does the type fmap :: (a -> b) -> (r -> a) -> (r -> b) mean now
--it takes a function from "a" to "b" and a function from "r" to "a" and returns a function from "r" to "b"
-- That's exactly what function composition essentially is. Another way to write the instance would be

-- instance Functor ((->) r) where
    -- fmap = (.)

--Functor laws
-- in order for something to be a functor it has to abide to two laws. They should reliably behave
-- as things that can be mapped over. Calling fmap on a functor should just map a function over the functor and
-- nothing more. This behaviour is descrived in functor laws. There are two of them that all instance of Functor should abide by.
-- They're not enforced by Haskell, so you should test the yourself

-- Functor laws
-- 1) fmap id = id
--  so essentially this rule says, that if we fmap the "id" function over a functor
--  it should give us back the same original functor

-- 2) fmap (f . g) = fmap f . fmap g
--  the second law states that composing two functions and then mapping the resulting function
--  over a functor should be the same as first mapping one function over the functor and then mapping
--  the second function over the resulting functor from the first mapping

-- Applicative functors
-- Applicative functors are beefed up Functors, represented by the Applicative typeclass in Haskell
-- 
-- As we know, all functions in Haskell are curried by default, which means that a function seems to
-- take a few parameters, where in reality it takes one, and produces a new intermediate function that
-- takes the next parameter and so on. If a function is of type "a -> b -> c", we usually say it takes two
-- parameters and returns a "c", but it actually takes "a" and produces a new function of type "b -> c".
-- That's why we can call function as f x y or as (f x) y. This mechanism allows us to partially apply functions
-- 
-- So far, when we've been mapping functions over functors, we've been mapping function that take only one parameter.
-- But what happens if we apply function such as (*), which takes two parameters over a functor? Let's take a look at
-- some concrete examples:
-- fmap (*) (Just 3) -> (Just (*3))
-- 
-- That means we get a function, wrapped in Just

-- we see how mapping functions that take multiple parameters over Functors produces Functors that contain
-- partially applied functions within them. Now, what can we do with them?
-- Well, for one we can map a function that takes these functions contained within the functor as parameters
-- over them.

-- a = fmap (*) [1,2,3,4,5]
-- b = fmap (\f -> f 9) a

-- but what if we had a functor (Just (*3)) and a second functor (Just 5) and we wanted
-- to apply the function contained within the first functor and apply it to the value
-- stored within the second one? Well, if we were to be dealing with ordinary Functors
-- that would mean we're out of luck, because all they support is mapping ordinary functions over them

-- Meet the Applicative typeclass, which lies in Control.Applicative module and it defines two methods
-- "pure" and "<*>". No default implementations are provided in the typeclass, therefore we have to implement
-- them on our own for each instance we make. The class is defined like so:

-- class (Functor f) Applicative f where
    -- pure :: a -> f a
    -- (<*>) :: f (a -> b) -> f a -> f b

-- This simple three line definition tells us a lot. Let's take a look at it line-by-line
-- 1) class (Functor f) Applicative f where
--      it starts the definition of the Applicative typeclass and introduces a class constraint
--      it says that if we want to make a type constructor an instance of Applicative, it should be
--      a in Functor first. That's why we know that if a type constructor is part of the Applicative
--      typeclass, it's also in Functor, hence we can use fmap on it

-- 2) the first method it defines is called "pure". It's type declaration is pure :: a -> f a
--      pure should take a value of any type and returns that value wrapped in an applicative functor
--      a better way of thinking about "pure" is as if it takes a default(pure) value and places it
--      in some sort of context that still yields that value

-- 3) the "<*>" has a really interesting type.
    -- It has a type declaration of <*> :: f (a -> b) -> f a -> f b
    -- What does that type remind us of. Well, of course, fmap :: (a -> b) -> f a -> f b
    -- As already stated, Applicative functor is just a beefed up Functor, therefore <*>
    -- is just a beefed up version of fmap. fmap takes a function and a functor containing some value,
    -- whereas <*> takes a functor, containing a function, a second functor containing a value and applies
    -- that function to the value store within the function

-- Let's take a look at the Applicative instance of Maybe
-- instance Applicative Maybe where
    -- pure = Just
    -- Nothing <*> _ = Nothing
    -- (Just f) <*> something = fmap f something

-- Okay, let's give a whirl:
    -- ghci> Just (+3) <*> Just 9
    -- Just 12
    -- 
    -- ghci> pure (+3) <*> Just 10
    -- Just 13
    -- 
    -- ghci> pure (+3) <*> Just 9
    -- Just 12
    -- 
    -- ghci> Just (++"hahah") <*> Nothing
    -- Nothing

-- With normal functors, you just map a function over a functor and then you can't get the result out in any general way, 
-- even if the result is partially applied function. Applicative functors, on the other hand, allow you to operate on several functors
-- with a single function.

-- Check out this piece of code
-- ghci> pure (+) <*> Just 3 <*> Just 5
-- Just 8

-- ghci> pure (+) <*> Just 3 <*> Nothing
-- Nothing

-- ghci> pure (+) <*> Nothing <*> Just 5
-- Nothing

-- Isn't this awesome? Applicative functors and applicative style of doing "pure f <*> x <*> y <*> ..." allows us to take
-- a function that expects parameters that aren't necessarily wrapped in functors and use that function to perate on several values
-- that are in functor contexts. The function can take as many parameters as we want, because it's always partially applied step by step
-- between occurences of <*>

-- This becomes even more handy and aparent if we consider that "pure f <*> x" equals "fmap f x"
-- This is one of the applicative laws. Like we said, "pure" places a value in default context. If we just put a function in a
-- default context and then extract and apply it to a value inside another applicative functor, we did the same as just mapping that function over that
-- applicative functor. Instead of writing "pure f <*> x <*> y <*> ...", we can write "fmap f x <*> y <*> ..."
-- This is why Control.Applicative exports a function called "<$>", which is just an infix fmap over applicative functors.
-- Here's how it's defined:

-- <$> :: (Functor f) => (a -> b) -> f a -> fb
-- f <$> x = fmap f x

-- ghci> (++) <$> Just "johntra" <*> Just "volta"
-- Just "johntravolta"

-- instance Applicative [] where
    -- pure a = [a]
    -- fs <*> xs = [f x | f <- fs, x <- xs]

-- ghci> [(*0), (*2), (^2)] <*> [1,2,3]
-- [0,0,0,2,4,6,1,8,27]

-- instance Applicative IO where
    -- pure = return
    -- a <*> b = do
        -- f <- a
        -- x <- b
        -- return (f x)

-- Another instance of applicative is (-> r), so functions, however, I'm gonna give that section of the book
-- a pass, due to their rare use in applicative style

-- An instance of Applicative that we've not encountered yet is ZipList, and it lives in Control.Applicative
-- It turns out there are more ways for list to work as Applicate Functors besides using the <*>, namely
-- having a list of functions in the first list and having a list of values in the second list and using the <*>
-- to apply the functions from the left list on the values on the right. [(+3), (*2)] <*> [1,2], resulting in
-- the following list of 4 values i.e. [4,5,2,4].
-- 
-- However there is a way for [(+3), (*2)] <*> [1,2] to work in such way that the first function get applied to the first value
-- and the second function gets applied to the second value and so on. In this case resulting the following 2-element list i.e. [4,4]
-- You could look at it as [3+1,2*2].
-- 
-- Because one type can't have to instances for the same typeclass, the "ZipList a" type was introduced, which has one
-- constructor ZipList that has just one field and that field is a list. Here's an instance
-- 
-- instance Applicative ZipList where
    -- pure x = ZipList (repeat x)
    -- ZipList fs <*> ZipList xs = ZipList (zipWith (\f x -> f x) fs xs)
-- 
-- <*> does exactly as we said it would here. It applies the first function to the first element, the second function
-- to the second element and so on. Because of the way zipWith works, the length of the resuling list is the length of
-- the shorter list of the 2.
-- 
-- pure is also interesting here, since it takes a value and puts it in a list indefinitely.
-- "pure "hahah"" results in ZipList (["hahah, hahah, hahah,..."]). This might be a bit confusing, since
-- we've said that "pure" should put a value within a minimal context and an infinite list sure doesn't seem
-- like an minimal context. However, in the context of zipWith infinite lists make sense, because we should abide
-- the law of Applicative, where "pure f <*> xs" should be equal to "fmap f xs"

-- so how do zip lists work in Applicative style? Let's see. Oh, the "ZipLists a" type doesn't have a Show instance, so
-- we have to use the "getZipList" function to extract the raw list from within the ZipList.

-- ghci> getZipList $ (+) <$> ZipList [1,2,3] <*> ZipList [100,100,100]
-- [101,102,103]

-- ghci> getZipList $ (+) <$> ZipList [1,2,3] <*> ZipList [100,100..]
-- [101,102,103]
-- 
-- ghci> getZipList $ max <$> ZipList [1,2,3,4,5,3] <*> ZipList [5,3,1,2]
-- [5,3,3,4]
-- 
-- ghci> getZipList $ (,,) <$> ZipList "dog" <*> ZipList "cat" <*> ZipList "Rat"
-- [('d','c','r'),('o','a','a'),('g','t','t')]

-- Задача 1: Да се дефинира клас Tree със следните функции:
    -- empty - създава празно дърво
    -- insert - добавя елемент в дървото
    -- size - връща броя на node-овете в дървото
    -- isEmpty - проверява дали дървото е празно
    -- height - връща височината на дървото
    -- fromList
    -- toList
    -- contains - проверява дали елемент се съдържа в дървото
    -- mapTree
    -- foldTree

class Tree t where
    empty :: t a
    insert :: t a -> a -> t a
    size :: t a -> Int
    size x = length $ toList x
    isEmpty :: t a -> Bool
    isEmpty x = null $ toList x
    height :: t a -> Int
    fromList :: [a] -> t a
    toList :: t a -> [a]
    contains :: (Eq a) => t a -> a -> Bool
    contains x b = b `elem` toList x
    mapTree :: (a -> b) -> t a -> t b
    foldTree :: (b -> a -> b) -> b -> t a -> b

-- Задача 2: Да се инстанцира Tree за BTree и NormalTree
-- Задача 3: Да се инстанцира Show за BTree и NormalTree
data BTree a = Empty | Node a (BTree a) (BTree a)

tree :: BTree Int
tree = Node 1 (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)) (Node 22 (Node 33 Empty Empty) (Node 44 Empty Empty))

tree2 :: BTree Int
tree2 = Node 1 (Node 2 (Node 4 Empty Empty) Empty) (Node 3 (Node 5 Empty Empty) (Node 6 Empty Empty))

instance Tree BTree where
    empty :: BTree a
    empty = Empty
    
    insert :: BTree a -> a -> BTree a
    insert (Empty) a = Node a Empty Empty
    insert (Node x l r)  a = Node x (insert l a) r

    height :: BTree a -> Int
    height Empty = 0
    height (Node _ l r) = 1 + max (height l) (height r)

    fromList :: [a] -> BTree a
    fromList [] = Empty
    fromList xs =
        let 
            mid = length xs `div` 2
            root = xs !! mid
            leftHalf = take mid xs
            rightHalf = drop (mid + 1) xs
        in Node root (fromList leftHalf) (fromList rightHalf)

    toList :: BTree a -> [a]
    toList Empty = []
    toList (Node x l r) = x : toList l ++ toList r

    mapTree :: (a -> b) -> BTree a -> BTree b
    mapTree _ Empty = Empty
    mapTree f (Node x l r) = Node (f x) (mapTree f l) (mapTree f r)        

    foldTree :: (b -> a -> b) -> b -> BTree a -> b
    foldTree f acc tree = foldl f acc (toList tree)

instance Show a => Show (BTree a) where
        show :: (Show a) => BTree a -> String
        show Empty = "_"
        show t@(Node x l r) = helperShow t (height t)
            
