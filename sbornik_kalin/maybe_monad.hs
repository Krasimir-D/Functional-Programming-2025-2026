type Scales = (Int, Int)

addLeft :: Int -> Scales -> Maybe Scales
addLeft diff (w1,w2)
    | w1 + diff > 100 || w1 + diff - w2 > 50    = Nothing
    | otherwise                                 = Just (w1+diff,w2)

addRight :: Int -> Scales -> Maybe Scales
addRight diff (w1,w2)
    | w2 + diff > 100 || w2 + diff - w1 > 50    = Nothing
    | otherwise                                 = Just (w1,w2+diff)

scale :: Scales
scale = (0, 0)

-- example that computes chained >>= sequences
exampleSample1 = Just scale >>= (addLeft 15) >>= (addRight 42)

--example that computes to Nothing
exampleScale2 = Just scale >>= (addLeft 10) >>= (addRight 50) >>= (addRight 11)

state :: Scales -> Int
state (w1,w2) = max w1 w2

