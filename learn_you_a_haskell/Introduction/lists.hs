--lists are denoted by square brackets
lostNumbers = [4,8,15,16,23,42]

--lists are a homogenous data structure. They store elements of the same type
--strings are lists in Haskell, therefore we can use list functions on them, which is really handy

--The "++" operator
myList1 = [1,2,3,4] ++ [9,13,3]
myList2 = "hello" ++ " " ++ "world"
--beware when using the "++" operator repeatedly on long strings. When you put two lists together, internally Haskell has to
--walk through the whole list on the left side
myList3 = "Eat a starfish hotdog" ++ "!"

--The ":" operator ( <element> : <list>)
--puts the element in the begging of the list
myList4 = 'A' : " cute cat"
myList5 = 1 : [2,3,4,5]

--The "!!" operator
--gets a element out of a list by index (<list> !! <index>)
var1 = "Steve Buscemi" !! 6

--lists of lists
--the elements can be of different lengths
myList6 = [[1,2,3,4], [5,6,7]]


--Comparing lists, using the "<, >, <=, >=, =="
--the lists are compared in a lexicographical order
var2 = [3,2,1] > [2,1,0]
var3 = "Az" <= "Ti"

--basic functions that operate on lists:
--"head" returns the first element of a list
--"tail" returns the list without the head
--"init" returns the list without the last element
--"last" returns the last element
--"null" checks if list is empty
--"reverse" reverses a list
--"take" takes a number and a list and returns n elements from that list (<number> take <list>)
--"drop" takes a number and a list, drops n characters and returns the remaining (<number> drop <list>)
--"maximum" returns the biggest element
--"minimum" returns the smallest element
--"sum" takes a list of numbers and returns their sum
--"product" takes a list of numbers and returns their product
--"elem" takes a object and a list and tells us if that object is an element of the list (<obj> elem <list>) 