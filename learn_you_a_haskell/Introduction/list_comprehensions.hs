--list comprehensions
--set of the element in the [1:10] multiplied by 2
myList1 = [x*2 | x <- [1..10]]

--set of the even numbers in the [1;10] interval
myList2 = [x*2 | x <- [1..10], x*2 <= 10]

--set of the odd numbers in the [50,100] interval
myList3 = [x | x <- [50..100], x `mod` 2 == 1]

--function that replaces odd numbers < 10 with "Boom" and odd numbers >= 10 with "Bang" in a list
boomBangs xs = [if x < 10 then "Boom" else "Bang" | x <- xs, x `mod` 2 == 1]

--not only can we have multiple predicates in a comprehension, but we can also draw elements from multiple lists
--myList4 will generate all the possible combinations for a multiple
--the expected number of combinations is 9
myList4 = [x*y | x <- [2,3,4], y <- [5,6,7]]

--list of comprehensions that combines a list of adjectives and nouns
adjectives = ["Small", "Delightful", "Crispy"]
nouns = ["Column", "Box", "Car"]
myList5 = [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]

--our version of a length function, using pattern matching
--the _ symbol means that we don't care what we draw from the list
length' xs = sum [1 | _ <- xs]

--since strings are lists, we can use comprehensions to process and produce strings
removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]
