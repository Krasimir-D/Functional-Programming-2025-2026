--For most of the imperative programming languages there are case expressions (C, C++, Java). Much like if-expressions, the evaluate pieces of code
--based on the value of a parameter and end with a catch-all case. Hmm, taking a parameter, pattern matching and evaluating pieces of code based
--on the parameter's value... sound familiar, right? Well, pattern matching in function definitions is just a sugar syntax for just that.

head' :: [a] -> a
head' [] = error "No head, list is empty!"
head' (x:_) = x

head' :: [a] -> a
head xs = case xs of [] -> error "No head, list is empty"
                    (x:_) -> x

--as you can see the syntax for case-expressions is pretty simple

case expression of  pattern_1 -> <do_something>
                    pattern_2 -> <do_something>
                    ...
                    pattern_n -> <do_something>

--whereas pattern matching on function parameter can be done only when defining functions, case expressions can be used pretty much anywhere

describeList :: [a] -> String  
describeList xs = "The list is " ++ case xs of [] -> "empty."  
                                               [x] -> "a singleton list."  
                                               xs -> "a longer list."  
