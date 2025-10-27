--22. Да се дефинира функция, която има стойност истина, ако посоченото
-- условие е вярно и стойност - лъжа, в противен случай:
--22.a)
func1 :: Int -> Bool
func1 a = if (mod a 4) == 0 || (mod a 7) == 0 then True
         else False

distSquared :: (Int, Int) -> (Int, Int) -> Int
distSquared (a, b) (c, d) = (c - a)*(c - a) + (d - b)*(d - b)

--22.b)
func2 :: Int -> Int -> Int -> Bool
func2 a b c = if b^2 - 4*a*c < 0 then True
            else False

--22.c)
--Center of circle (0, 1); rad = 5 
func3 :: (Int, Int) -> Bool
func3 (x, y) = if distSquared (x, y) (0, 1) <= 5^2 then True
                else False

--22.d)
func4 :: (Int, Int) -> (Int, Int) -> Int -> Bool
func4 (a, b) (c, d) f = if distSquared (a, b) (c, d) > f^2 then True
                        else False

--22.e)
func5 :: (Int, Int) -> Bool
func5 (a, b) = if distSquared (a, b) (0, 0) <= 25 && a < 0 && b < 0 then True
                else False


--22.4 Да се напише функция, която намира броя на цифрите в десетичния
-- запис на дадено естествено число.
getDigitsCount :: Int -> Int
getDigitsCount 0 = 1
getDigitsCount x = if x `div` 10 == 0 then getDigitsCount 0 
                    else getDigitsCount (x `div` 10) + 1

getDigitsCount' :: Int -> Int
getDigitsCount' x = length(show x)

--22.5 Да се напише функция, която намира сумата на цифрите в десетичния
--запис на дадено естествено число.
getDigitSum :: Int -> Int
getDigitSum 0 = 0
getDigitSum x = x `mod` 10 + getDigitSum (x `div` 10)

--22.6. Да се дефинира функцията pow(x, k) = x^k
--за цели положителни числа x и k.
powerHelper :: Int -> Int -> Int
powerHelper x 1 = x
powerHelper x y = x * powerHelper x (y-1)

calcPowOf :: Int -> Int -> Int
calcPowOf x y = if x <= 0 || y <= 0 then 0 
                else powerHelper x y

-- 22.10. Да се дефинира функция, която по естествени числа n и k намира дали
-- n е точна степен на числото k.
helperIsPowerOf :: Int -> Int -> Bool
helperIsPowerOf 1 k = True
helperIsPowerOf n 1 = False
helperIsPowerOf n k =
                if n `mod` k /= 0 then False
                else helperIsPowerOf (n `div` k) k

isPowerOf :: Int -> Int -> Bool
isPowerOf n k = if n < 1 || k < 1 then False
                else helperIsPowerOf n k

-- 22.11. Едно положително цяло число е съвършено, ако е равно на сумата от
-- своите делители (без самото число). Например, 6 е съвършено, защото
-- 6 = 1+2+3; числото 1 не е съвършено. Да се дефинира функция, която
-- проверява дали дадено положително цяло число е съвършено.
helperIsPerfectNum :: Int -> Bool
helperIsPerfectNum 1 = True
helperIsPerfectNum x = if x == sum [y | y <- [1..x], x `mod` y == 0, y < x] then True
                       else False

isPerfectNum :: Int -> Bool
isPerfectNum x = if x < 1 then False
                else helperIsPerfectNum x
