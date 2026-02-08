-- Задача 6: Да се напише функция, която приема списък от стрингове и ги връща индексирани ["a", "b", "c"] -> [(1, "a"), (2, "b"), (3, "c")]
indexStrings :: [String] -> [(Int, String)]
indexStrings xs = zip [1..] xs

-- Задача 7: Напишете фунцкия, която приема стринг и премахва всички букви от началото му докато не стигне до число "sdf123" -> "123"
trimToIntegers :: String -> String
trimToIntegers xs = dropWhile (\x -> x `elem` ['a'..'z'] || x `elem` ['A'..'Z']) xs

-- folds

-- Задача 1: Да се дефинира foldl
foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ b [] = b
foldl' f b (x:xs) = foldl' f (f b x) xs

-- Задача 2: Да се дефинира foldr
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ b [] = b
foldr' f b (x:xs) = f x (foldr' f b xs)

-- Задача 3: SumList [1,2,3] -> 6
sumList :: [Int] -> Int
sumList xs = foldl (+) 0 xs

-- Задача 3.1: ListProduct: [1,2,3] -> 6
listProduct :: [Int] -> Int
listProduct xs = foldr (*) 1 xs

-- Задача 4: And [True, True, False] -> False
myAnd :: [Bool] -> Bool
myAnd xs = foldr (&&) True xs

-- Задача 5: reverse (ще използваме функцията flip)
myReverse :: [a] -> [a]
myReverse xs = foldl (flip (:)) [] xs

-- Ламбда функции

-- Задача 1: Да се напише ламбда функция, която добавя 1 към число
-- (\x -> x + 1)
-- Задача 2: Да се напише ламбда функция, която умножава две числа
-- (\x y -> x * y)

-- Задача 3: SumList с ламбда функция
sumList' :: [Int] -> Int
sumList' xs = foldr (\x y -> x + y)  0 xs

-- Задача 4: filter
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f xs = foldr (\x acc -> if f x then x : acc else acc) [] xs

-- Задача 5: map
myMap :: (a -> b) -> [a] -> [b]
myMap f xs = foldr (\x acc -> f x : acc) [] xs

-- Задача 5: assignGradesDS -> имате 2 контролни на всяко ви трябват поне 20% и общо ви трябват поне 40%
assignGradesDS :: [(String, Int, Int)] -> [(String, String)]
assignGradesDS xs = map (\(n, k1, k2) -> if k1 < 20 || k2 < 20 || k1 + k2 < 80 then (n, "Fail") else (n, "Pass")) xs

-- Задача 6: Да се намери най-кратката дума ["Will", "I", "pass", "dstr", "?"] -> "I"
findShortest :: [String] -> String
findShortest (x:xs) = foldr (\x acc -> if length x < length acc then x else acc) x xs

-- Задачи от сборника
-- 28.2 Нека е даден списък l::[(Int,Int,Int)] с тройки (ai, bi, ci). С помощта
-- на map, fold и filter да се намерят:
-- а) Списъка от сумите на елементите на тройките [(ai + bi + ci)]
-- b) Тройката от сумите на отделните компоненти на l
-- c) Броя на тройките, за които ai + bi > ci
-- d) Дали има поне една тройка, за която ai = bi = ci (True или False)

zad28_a :: [(Int, Int, Int)] -> [Int]
zad28_a xs = foldr (\(a,b,c) acc -> (a + b + c) : acc) [] xs

zad28_b :: [(Int, Int, Int)] -> (Int, Int, Int)
zad28_b xs = foldr (\(a,b,c) acc@(sA,sB,sC) -> (sA+a,sB+b,sC+c)) (0,0,0) xs

zad28_c :: [(Int, Int, Int)] -> Int
zad28_c xs = length $ filter (\(a,b,c) -> if a + b > c then True else False) xs

zad28_d :: [(Int, Int, Int)] -> Bool
zad28_d xs = foldr (||) False (map (\(a,b,c) -> if a == b && b == c then True else False) xs)

-- 28.3. За списък от числа L да се намери списък с само с тези числа, които
-- съвпадат с поредния си номер в L. Например [1, 5, 3, 4, 2] → [1, 3, 4].
zad28_3 :: [Int] -> [Int]
zad28_3 xs = map snd (filter (\(x,y) -> x == y) (zip [1..] xs))

-- 28.4. За списък от числа L да се намери списък със сумите на всички двойки
-- последователни елементи на L. Например [1, 5, 3, 4, 2] → [6, 8, 7, 6]. Упът-
-- ване: Използвайте zip.
zad28_4 :: [Int] -> [Int]
zad28_4 xs = map (\(a,b) -> a + b) (zip xs (tail xs))

-- Да се дефинира функция separate :: (a->Bool) -> [a] -> ([a],[a]),
-- която по предикат p и списък l връща двойката (pref,suf). pref е най-
-- дългият възможен префикс, такъв че всички негови елементи увовлет-
-- воряват p. suf е останалата част от списъка l. Например, separate even
-- [2,4,6,7,8,10] -> ([2,4,6],[7,8,10]). Забележка: вижте функция-
-- та break в Prelude.
