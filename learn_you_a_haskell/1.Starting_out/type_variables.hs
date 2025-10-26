--type variables are like a black box. They are a container that could store a value
--of any of the common types in Haskell

--What could the type of the "head" function be? If we check by using the ":t" function
--we see "head::[a] -> a"
--so what could 'a' possibly be. Well, as we stated earlier types are noted with capital letters(i.e. Int)
--because it's not in capital letters it a type variable. This is much like generics in other languages such as Java.
--type variables are used when writing polymorphic functions that don't work with a specific type

--lets remember the "fst <tuple-pair_name>" function that returns the first component of a tuple
--if we run ":t fst" we'll get "fst :: (a, b) -> a"
--bear in mind that the fact tha we use different letters for the components does not mean
--they're of different type. It just means that can differ in type and that a specific type is not
--specified

