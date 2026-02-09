-- Да се имплементират Stack и Queue
type Stack a = [a]

stackPush :: Stack a -> a -> Stack a
stackPush s a = a : s

stackPop :: Stack a -> Stack a
stackPop s = if null s then [] else tail s

type Queue a = [a]

queuePush :: Queue a -> a -> Queue a
queuePush q a = a : q

queuePop :: Queue a -> Queue a
queuePop q = if null q then [] else init q

-- Да се създаде клас Parser
class Parser p where
    run :: String -> p -> Maybe Int

-- Да се създаде тип ArithmeticParser
    -- Целта на ArithmeticParser е по подаден списък от оператори да пресмята изрази
    -- (оператор наричаме наредена тройка от символ, приоритет и операция)

type Operator = (Char, Int, (Int -> Int -> Int))

getSymbol :: Operator -> Char
getSymbol (x, _, _) = x

getPriority :: Operator -> Int
getPriority (_, x, _) = x

getFunc :: Operator -> (Int -> Int -> Int)
getFunc (_, _, x) = x

--"undefined" is temporary placeholder for something that's yet undefined.
--the code compiles, however when invoked run-time, it crashes
getOperator :: [Operator] -> Char -> Operator
getOperator _ '('       = ('(', 0, undefined)
getOperator _ ')'       = (')', 0, undefined)
getOperator (x:xs) s    = if getSymbol x == s then x else getOperator xs s
getOperator [] _        = error "Uknown symbol"

data ArithmeticParser = ArithmeticParser [Operator]

instance Parser ArithmeticParser where
    run :: String -> ArithmeticParser -> Maybe Int
    run s a = 
        case shuntingYard a s of
            Nothing -> Nothing
            Just r -> Just $ evalRevPolish a r


isDigit :: Char -> Bool
isDigit c =  c `elem` ['0'..'9']

shuntingYard :: ArithmeticParser -> String -> Maybe String
shuntingYard _ "" = Just ""
shuntingYard (ArithmeticParser ops) l = helper l [] []
    where
        helper :: String -> Queue Char -> Stack Char -> Maybe String
        helper "" q s = Just (reverse (reverse s ++ q))
        helper (x:xs) q s
            | isDigit x = helper xs (queuePush q x) s
            | x `elem` map getSymbol ops =
                let
                    getOpPriority = getPriority . getOperator ops
                    p = getOpPriority x
                in
                    helper xs (takeWhile (\y -> getOpPriority y >= p) s ++ q) (stackPush (dropWhile (\y -> getOpPriority y >= p) s) x)

            | x == '(' = 
                    helper xs q (stackPush s x)

            | x == ')' =
                    let
                        subExpr = takeWhile (\y -> y /= '(') s                    
                    in
                        if not (null subExpr) then
                            helper xs (subExpr ++ q) (tail (dropWhile (\y -> y /= '(') s))
                        else
                            Nothing
            | otherwise = Nothing

