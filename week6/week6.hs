-- Enum - Репрезентация от и към Int
-- Bounded - Най-малък и най-голям елемент
data Weekdays = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
    deriving (Show, Read, Enum, Bounded)
    
-- use toEnum and fromEnum
nextDay :: Weekdays -> Weekdays
nextDay day = toEnum ((fromEnum day + 1) `mod` 7)

-- minBound
firstDay :: Weekdays
firstDay = minBound :: Weekdays

-- maxBound
lastDay :: Weekdays
lastDay = maxBound :: Weekdays

-- Задача 1: Да се напише функция, чете изречение от конзолата и му слага точка накрая, ако няма такава
zad1 :: IO String
zad1 = do
    input <- getLine
    if last input /= '.' then
        return $ input ++ "."
    else
        return input

-- Задача 2: Да се напише функция, която чете от конзолата ден от седмицата и принтира следващия ден
zad2 :: IO ()
zad2 = do
    input <- getLine
    let day = read input :: Weekdays
    putStrLn (show (nextDay day))

-- Задача 3: Да се напише функция, която чете от конзолата две числа и принтира тяхната сума
zad3 :: IO ()
zad3 = do
    num1 <- getLine
    num2 <- getLine
    putStrLn (show ((read num1) + (read num2)))

-- pure и return
-- Задача 4: Да се напише функция, която приема булев аргумент (needsInput). 
    -- Ако той е истина, чете String от конзолата и го връща
    -- В противен случай връща "Default name"
zad4 :: Bool -> IO String
zad4 needsInput = do
    if needsInput then
        do
            input <- getLine
            return input
    else
        return "Default name"

-- Задача 5: Да се напише функция, която чете цяло число n от конзолата, след това чете n числа и връща тяхната сума
zad5 :: IO Int
zad5 = do
    n <- getLine
    helper (read n) 0
    where
        helper :: Int -> Int -> IO Int
        helper n sum = do
            if n == 0 then
                return sum
            else do
                input <- getLine
                helper (n - 1) (sum + read input)

-- Задача 6: Да се напише функция, която чете цяло число n от конзолата, след това чете n изречения и ги принтира в обратен ред
zad6 :: IO ()
zad6 = do
    n <- getLine
    helper (read n) []
    where
        helper :: Int -> [String] -> IO ()
        helper 0 list =  mapM_ putStrLn list
        helper x list = do
            newStr <- getLine
            helper (x - 1) (read newStr : list)
