-- Дървета

-- Задача 1: Да се дефинира тип за бинарно дърво
data BTree = Empty | Node Int BTree BTree

-- Задача 2: Да се дефинира тип за дърво
data Tree = Empty1 | Node1 Int [Tree]

-- За следващите задачи дърво ще означава бинарно дърво
tree :: BTree
tree = Node 1 (Node 2 (Node 3 Empty Empty) (Node 4 Empty Empty)) (Node 22 (Node 33 Empty Empty) (Node 44 Empty Empty))

ordTree :: BTree
ordTree = Node 4 (Node 2 (Node 1 Empty Empty) (Node 3 Empty Empty)) (Node 6 (Node 5 Empty Empty) (Node 7 Empty Empty))

-- Задача 3: Да се напише функция, която връща броя на елементите на дърво, които удовлетворяват даден предикат
zad3 :: (Int -> Bool) -> BTree -> Int
zad3 _ (Empty) = 0
zad3 f (Node val l r) =
    if f val then
        1 + (zad3 f l + zad3 f r)
    else
        (zad3 f l + zad3 f r)

elemCount :: BTree -> Int
elemCount (Empty) = 0
elemCount (Node _ l r) = 1 + elemCount l + elemCount  r

-- Задача 4: Да се напише функция, която приема бинарно дърво и връща сумата на всичките му листа
zad4 :: BTree -> Int
zad4 (Empty) = 0
zad4 (Node val Empty Empty) = val
zad4 (Node _ l r) = zad4 l + zad4 r

-- Задача 5: Да се напише функция, която намира най-големия по стойност елемент на дърво. 
-- Приемете, че всички стойности са положителни
zad5 :: BTree -> Int
zad5 (Empty) = 0
zad5 (Node v l r) = maximum [v, zad5 l, zad5 r]

-- Задача 6: Да се напише функция, която приема списък и връща BST
sublist :: Int -> Int -> [a] -> [a]
sublist x y xs = take (y - x + 1) (drop x xs)

mySort :: (Eq a, Ord a) => [a] -> [a]
mySort [] = []
mySort (x:xs) =
    let
        less = mySort (filter (<x) xs)
        more = mySort (filter (>=x) xs)
    in less ++ [x] ++ more

zad6 :: [Int] -> BTree
zad6 [] = Empty
zad6 ls =
    let
        lsSorted = mySort ls
        mid = length lsSorted `div` 2
        root = lsSorted !! mid
        lSub = sublist 0 (mid - 1) lsSorted
        rSub = sublist (mid + 1) (length lsSorted - 1) lsSorted
    in (Node root (zad6 lSub) (zad6 rSub))

createBST :: [Int] -> BTree
createBST [] = Empty 
createBST (x : xs) = Node x (createBST $ filter (<x) xs) (createBST $ filter (>=x) xs)

-- Задача 7: Да се дефинира функция isOrdered, проверява дали дадено дърво е двоично наредено.
isOrdered :: BTree -> Bool
isOrdered (Empty) = True
isOrdered (Node _ Empty Empty) = True
isOrdered (Node v l@(Node x _ _) Empty) = x < v && isOrdered l
isOrdered (Node v Empty r@(Node x _ _)) = v <= x && isOrdered r
isOrdered (Node v l@(Node lV _ _) r@(Node rV _  _))
    | lV < v && v < rV = isOrdered l && isOrdered r
    | otherwise = False