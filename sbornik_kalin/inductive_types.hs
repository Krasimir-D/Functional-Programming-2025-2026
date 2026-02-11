import Data.Time.Calendar

data Task
    = SimpleTask        
    { simpleTaskName :: String
    , start :: Day, duration :: Integer
    }     
    | ComplexTask
    {complexTaskName :: String
    , subtasks :: [Task]
    }
    deriving (Show, Read, Eq)

completed :: Task -> Day -> Bool
completed (SimpleTask n s dur) d = addDays dur s <= d
completed (ComplexTask n ts) d = foldr (&&) True (map (\t -> completed t d) ts)
