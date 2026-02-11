-- 28.1 foldl, foldr, map
foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ acc [] = acc
foldl' f acc (x:xs) = foldl' f (f acc x) xs

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ acc [] = acc
foldr' f acc (x:xs) = f x $ foldr' f acc xs

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map f xs

-- 28.2
l :: [(Int, Int, Int)]
l = [(1,2,3), (2,3,4), (3,4,5), (4,4,4)]

sumTriplets :: [(Int, Int, Int)] -> [Int]
sumTriplets triplets = map (\(x,y,z) -> x + y + z) triplets

getSumComponents :: [(Int, Int, Int)] -> (Int, Int, Int)
getSumComponents triplets = foldr' (\(a1,a2,a3) (x,y,z) -> (a1+x,a2+y,a3+z)) (0,0,0) triplets

countInequality :: [(Int, Int, Int)] -> Int
countInequality triplets = length $ filter (\(x,y,z) -> x + y > z) triplets

getEquality :: [(Int, Int, Int)] -> Bool
getEquality triplets = not (null $ filter (\(x,y,z) -> x == y && y == z) triplets)

-- 28.3
getCoinciding :: [Int] -> [Int]
getCoinciding l = map fst (filter (\x -> fst x == snd x) $ (zip [1..] l))

-- 28.4
sumConsecutive :: [Int] -> [Int]
sumConsecutive l@(x:xs) = map (\el -> fst el + snd el) $ zip l xs

-- 28.5
sums :: [Int] -> [Int]
sums xs = zipWith (+) xs (0 : sums xs)

-- 28.6
-- separate :: (a -> Bool) -> [a] -> ([a], [a])
-- separate p l = foldr' (\x (a1,a2)  -> if p x then (x:a1,a2) else (a1,x:a2)) ([],[]) l