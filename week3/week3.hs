isInfixOf :: (Eq a) => [a] -> [a] -> Bool
isInfixOf [] _ = True
isInfixOf _ [] = False
isInfixOf a b@(y:ys) = if isPrefixOf a b then True else isInfixOf a ys

isPrefixOf :: (Eq a) => [a] -> [a] -> Bool
isPrefixOf [] _ = True
isPrefixOf _ [] = False
isPrefixOf (x:xs) (y:ys)
    | x == y = isPrefixOf xs ys
    | otherwise = False

-- Задачи с curry/uncurry

-- Задача 1: Приложете функцията calculateItems върху всеки от елементите на items
-- Задача 2: След като сте изпълнили първа задача добавете съответния елемент на additional_vals към резултата

items :: [(Int, Int)]
items = [(5, 1), (2, 5), (3, 4), (6, 5) ]

additionalVals :: [Int]
additionalVals = [2, 5, 3, 2]

calculateItems :: Int -> Int -> Int
calculateItems val modifier = val * modifier

zad1 :: [Int]
zad1 = zipWith (+) (map (uncurry calculateItems) items) additionalVals

-- Задача 4: повторете задача 1 и 2 за items2, modifiers2

items2 :: [Int]
items2 = [5, 2, 3, 6]

modifiers2 :: [Int]
modifiers2 = [1, 5, 4, 5]

calculateItems2 :: (Int, Int) -> Int
calculateItems2 (val, modifier) = val * modifier

zad2 :: [Int]
zad2 = zipWith (+) (zipWith (curry calculateItems2) items2 modifiers2) additionalVals

-- Задача 1: да се дефинира монада Maybe
data MyMaybe a = MyNothing | MyJust a

-- Задача 2: Напишете функция, която приема Maybe Int и връща Int (Nothing -> 0)
intFromMaybe :: MyMaybe Int -> Int
intFromMaybe MyNothing = 0
intFromMaybe (MyJust val) = val

-- Задача 3: safe head 
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

-- Задача 4: safe division
safeDivision :: Int -> Int -> Maybe Int
safeDivision _ 0 = Nothing
safeDivision x y = Just (x `div` y)

-- Задача 5: fmap
myFmap :: (a -> b) -> Maybe a -> Maybe b
myFmap f Nothing = Nothing
myFmap f (Just val) = Just (f val)

-- Задача 1: Да се дефинира монада Either
data MyEither a b = MyLeft a | MyRight b

-- Задача 2: Да се дефинира функция isAnAdult, която
    -- приема възраст
    -- проверява дали е в интервала [0, 120]
    -- ако не е - връща грешка (string)
    -- ако е: Връща True ако възрастта е >=18 и False, иначе
isAnAdult :: Int -> Either String Bool
isAnAdult x
    | x < 0 || x > 120 = Left "invalid age"
    | otherwise = Right (x >= 18)

-- Други задачи

-- Задача 1: Напишете функция, която връща третия елемент на списък 
thirdOfList :: [a] -> Maybe a
thirdOfList xs = if length xs < 3 then Nothing else Just $ head (drop 3 xs)

-- Задача 2: Напишете функция, която приема списък от списъци и ги конкатенира
-- Вградена функция: concat
myCat :: [[a]] -> [a]
myCat [] = []
myCat (x:xs) = x ++ myCat xs

-- Задача 3: Да се напише функцията filter
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter f (x:xs) = if f x == True then x : myFilter f xs else myFilter f xs

-- Задача 4: Да се приложи safeDiv върху елементите на 2 списъка. 
    -- Ако някъде се провали да се хвърли съобщение за грешка.
    -- В противен случай да се върне списък от резултатите
safeDivLs :: [Int] -> [Int] -> [Int]
safeDivLs [] _ = []
safeDivLs _ []= []
safeDivLs (x:xs) (y:ys) = 
    case safeDivision x y of
        Nothing -> []
        Just a -> a : (safeDivLs xs ys)

-- Задача 5: 
    -- а) Напишете тип за животно
    -- б) Напишете функция, която приема число и връща съответното животно
    -- в) Напишете обратната функция
    -- г) Напишете функция, която използва предните 2. Тя трябва да приема животно и да връща същото
data Animal = Cat | Dog | Parrot | Rabbit
    deriving (Show, Eq, Ord, Enum, Bounded)