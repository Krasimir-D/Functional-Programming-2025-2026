--tuples
--a heterogenous data structure which can hold up a number of values of different types
--a tuple is defined by the count of elements it holds, as well as the type of the elements

--two dimensional vector
--a list of pairs instead a list of lists
list_2d_vector = [(1,2),(2,3), (4,5)]

--tuples are heterogenous
person = ("Jordan", "Petterson", 57);

--useful functions that operate on tuples
--"fst <pair>" and "snd <pair>". These two operate on pairs only

--function that produces a list of pairs is "zip <list_1> <list_2>"
zip [1,2,3,4,5] ["one", "two", "three", "four", "five"]
[(1,"one"),(2,"two"),(3,"three"5),(4,"four"),(5,"five")]

--what happens if the length of the lists don't match
--well, since Haskell is a lazy language the remainder of the
--longer list will just get trimmed from the result and be neglected
zip [1,2,3,4] ["i", "turtle", "cat"]
[(1, "i"), (2,"turtle"), (3, "cat")]

--because of that quality of Haskell we can zip an infinite list with a finite list
zip [1..] ["apple", "orange", "cherry", "mango"]
[(1,"apple"),(2,"orange"),(3,"cherry"),(4,"mango")]

--here is a problem that combines list comprehensions and tuples
--which right triangles have integers for all sides, all less <= 10
--and a perimeter of 24:
let triangles = [ (a, b, c) | a <- [1..10], b <- [1..10], c <- [1..10]]

--now we add an aditional rule, that ensures that b is always < c, where is hipotenuse
--and a <= b and that they are all right triangles
let rightTriangles = [ (a, b, c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 = c^2]

--we're almost done, all we need to add now is a rule which insures that the perimeter is 24
let rightTriangles' = [ (a, b, c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 = c^2, a + b + c == 24]



