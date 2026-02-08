-- Задача 1: Да се напише map (\x -> x * x) [1..5], изпозлвайки list comprehension
squared :: [Int]
squared = [x^2 | x <- [1..5]]

-- Задача 2: Да се напише filter even [1..10], изпозлвайки list comprehension
filterEven :: [Int]
filterEven = [x | x <- [1..10], even x]

-- Задача 3: Да се напише функция, която връща всички букви от английската азбука индексирани [(1, 'а'), (2, 'b') ...]
indexAlphabet :: [(Int, Char)]
indexAlphabet = zip [1..] ['a'..'z']

-- Задача 4: Да се напише функция, която връща всички двойки (x, y) такива, че x и y са от 1 до 5 и x < y
zad4 :: [(Int, Int)]
zad4 = [(x,y) | x <- [1..5], y <- [1..5], x < y]

-- Задача 5: Да се напише функция, която намира всички тройки (a, b, c) такива, че a*a + b*b = c*c и a,b,c са от 1 до 10
zad5 :: [(Int,Int,Int)]
zad5 = [(a,b,c) | a <- [1..10], b <- [1..10], c <- [1..10], a^2 + b^2 == c^2]

-- Задача 6: Изполвайки list comprehension, да се напише функция, която връща само имената на хората, които са пълнолетни
names :: [String]
names = ["Alice", "Bob", "Pesho"]

ages :: [Integer]
ages = [10, 18, 25]

zad6 :: [String]
zad6 =
    let people = zip names ages
    in [name | (name, age) <- people, age >= 18]

-- (*) Задача 7: Да се намери сумата на дължините на всички думи, започващи със същата буква. 
--               Резултатът трябва да е в следния формат: [('a', 8), ('b', 10), ('m', 18)]

myWords :: [String]
myWords = ["banana", "apple", "mango", "ant", "bear", "mosaic", "mission"]

zad7 :: [(Char, Int)]
zad7 = [(l, sum $ map length $ filter (\a -> head a == l) myWords) | l <- ['a'..'z'], l `elem` map head myWords]

-- Задача 8: Да се намери сумата на всички числа
nums :: [String]
nums = ["1", "10", "5", "2"]

zad8 :: Int
zad8 = sum [read x | x <- nums]

-- Задача 9: Да се намери сумата на всички подсписъци и да се върне като списък от стрингове
manyNums :: [[String]]
manyNums = [["1", "10", "5", "2"], ["1", "2", "5", "2"], ["1", "10", "15", "2"]]

zad9 :: [String]
zad9 = map show [sum (map read numbers) | numbers <- manyNums]

-- Задача 10: Parser
toParse :: [String]
toParse = ["user=bob", "age=20", "active=True"]
-- Oчакван резултат: ("bob", 20, True)

parser :: (String, Int, Bool)
parser = (first, second, third)
    where
        extractValue :: String -> String
        extractValue [] = ""
        extractValue (x:xs)
            | x /= '=' = extractValue xs
            | otherwise = xs
        values = map extractValue toParse
        first = (values !! 0)
        second = read (values !! 1)
        third = read (values !! 2)

-- Бонус: Да се пренапише задача 10, използвайки record
data User = User {name :: String, age :: Int, active :: Bool}
    deriving (Show)

parser2 :: User
parser2 = helper [drop 1 $ dropWhile (/='=') x | x <- toParse]
    where 
        helper :: [String] -> User
        helper [x,y,z] = User {name = x, age = read y, active = read z}
        helper _ = error "Oops"