--ranges are a way of making lists of elements that can be enumerated. Numbers can be enumerated. Letters are as well.
--with ranges you generate arithmetic sequences
--list of the natural numbers [1;20]
myList1 = [1..20]

--lower case alphabet
myList2 = ['a'..'z']

--upper case alphabet
myList3 = ['A'..'Z']

--you can also specify a step when using ranges
myList4 = [2,4..20]
myList5 = [3,6..20]

--to make a list from 20 to 1, you can't just do [20..1]
--you must specify the step, therefore the correct way is to do [20,19..1]
myList6 = [20,19..1]

--watch out when using ranges with float numbers, because they are not completely precise, their use in ranges can produce some funky results
--it is advisory NOT to use float with ranges
myList7 = [0.1, 0.3..1]

--you can also generate infinite lists with ranges just by not specifying the upper limit
--here is an example of how to take the first 24 multiples of 13:
myList8 = [13,26..]
--take 13 myList8. Because Haskell is lazy it won't try ti evaluate infinte list immediately because it will never finish

--a few other functions that produce infinte lists are: "cycle" and "repeat"
--"cycle" takes a list and produces an infite list which loops the element of that input list
--cycle <list>
--take 10 (cycle [1,2,3])

--"repeat" takes an element and produces a list that consists only of that element
--repeat <element>
--take 10 (repeat "LOL")
