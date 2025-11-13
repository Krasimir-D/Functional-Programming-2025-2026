--while pattern matching ensures that a data conforms to some model, guards are e mechanism that checks whether the data conforms to more complex conditions.
--this sounds very much like "if-statements" in imperative languages. Instead of diving into complex explanations about the syntax for using guards, We'll just look
--at a simple use of guards

max' :: (Ord a) => a -> a -> a
max' a b
    | a >=b         = a
    | otherwise     = b

--much like "if's" we have a catch-all mechanism called "otherwise". If all the guard conditions evaluate to "False" and we haven't
--provided an "otherwise-guard" then the evaluation would fall through onto the next patter. That's why patters work great in combination
--with guards.

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
        | a < b         = LT
        | a == b        = EQ
        | otherwise     = GT 

--but wait! Those are not the only type of guards. Sometimes you want to check not whether an argument satisfies some pattern
--but whether the result of a function does. This is called a "pattern-guard"

densityTell :: String -> String
densityTell input 
          | Just density <-
          readMaybe input, density < 1.2 = "Wow!"
          |Just density 
          <- readMaybe input, density < 1000 = "heyo"

--the syntax for pattern matching in guards is: | <pattern> <- <expression>, <more_conditions...> = result

