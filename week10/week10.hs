import Data.List (nub, sort)

type Graph a = ([a], [(a,a)])

-- Задача 1: Да се дефинират типове за неориентиран, ориентиран и тегловен граф

-- Задачи с неориентирани графи:

-- Задача 1: Да се напише функция, която връща списък от всички свързани компоненти в граф
isAdjacent :: (Eq a) => Graph a -> a -> a -> Bool
isAdjacent (_, e) x y = (x,y) `elem` e || (y, x) `elem` e

getNeighbours :: (Eq a) => Graph a -> a -> [a]
getNeighbours (_, e) x = map (\(a,b) -> if x == a then b else a) $ filter (\(a,b) -> x == a || x == b) e

hasPath :: (Eq a) => Graph a -> a -> a -> Bool
hasPath gr v1 v2 = v2 `elem` getConnectedComponent gr [] [v1]

-- the first list tracks all processed nodes i.e. their neighbours have been visited -> at the end this list will yield the connected component of v1
-- the second list tracks all visited node i.e. their neighbours are yet to be inspected
-- when calling this function and your're trying to get the connected component where element v1 resides in
-- call getConnectedComponent like this getConnectedComponent graph [] [v1]
getConnectedComponent :: (Eq a) => Graph a -> [a] -> [a] -> [a]
getConnectedComponent gr processed [] = processed
getConnectedComponent gr processed visited@(x:xs) =
    let
        neighboursX = filter (\n -> not (n `elem` processed || n `elem` visited)) (getNeighbours gr x)
    in getConnectedComponent gr (x:processed) (xs ++ neighboursX)

graph1 :: Graph Int
graph1 = ([1,2,3,7,17,9,5,10], [(1,17),(1,9), (17,9),(1,2),(2,3),(2,7), (5,10)])

getAllConnectedComponents :: (Eq a) => Graph a -> [[a]]
getAllConnectedComponents gr =
  nub (map (\x -> sort (getConnectedComponent gr [] [x])) (fst gr))
    