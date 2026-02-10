import Data.List (nub)

-- 26.1.
data DayOfWeek = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
    deriving (Show, Read, Eq, Ord, Enum, Bounded)

-- 26.2.
-- Student: FN, Name, Courses, 
-- Lector: Name, Courses, Cabinet id

data Member = Student {fn :: String, studentName :: String, coursesTaken :: [String]}
            | Lector {lectorName :: String, coursesGive :: [String], cabinetId :: Int}
            deriving (Show, Eq)

members =    
  [ Student
      { fn = "F12345"
      , studentName = "Alice Ivanova"
      , coursesTaken = ["FP", "OOP", "DS"]
      }

  , Student
      { fn = "F23456"
      , studentName = "Bob Petrov"
      , coursesTaken = ["FP", "Databases"]
      }

  , Student
      { fn = "F34567"
      , studentName = "Maria Georgieva"
      , coursesTaken = ["OOP", "Networks"]
      }

  , Lector
      { lectorName = "Dr. Nikolov"
      , coursesGive = ["FP", "OOP"]
      , cabinetId = 312
      }

  , Lector
      { lectorName = "Prof. Dimitrova"
      , coursesGive = ["Databases"]
      , cabinetId = 214
      }
  ]

getStudentsCount :: [Member] -> Int
getStudentsCount ls =
    length $ filter (\m -> case m of
                            Student _ _ _ -> True
                            _             -> False
                    ) ls

attendees :: String -> [Member] -> Int
attendees crs ls =
    let
        temp = filter (\m -> case m of
                                Student _ _ l -> crs `elem` l
                                Lector  _ l _ -> crs `elem` l
                      ) ls
    in length temp

classmembers :: String -> [Member] -> [Member]
classmembers crs ls =
        filter (\m -> case m of
                        Student _ _ l -> crs `elem` l
                        Lector _ l _ -> crs `elem` l
                ) ls

bussiest :: [Member] -> Int
bussiest xs =
    let
        cabs = cabinetsCount
    in
        foldr (\cab acc -> if (snd cab) > acc then fst cab else acc) cabs -1

cabinetsCount :: [Member] -> [(Int, Int)]
cabinetsCount xs = [(c, length $filter (==c) $ cabinets xs) | c <- nub $ cabinets xs]
    where
        cabinets :: [Member] -> [Int]
        cabinets ms = [cab | Lector _ _ cab <- ms]