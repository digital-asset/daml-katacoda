# Maps

If you need to store associations from keys to values, the best data container to choose is a `Map`
from the `DA.Next.Map` module. For example, we could have a map from phone numbers to contacts for
quick number lookup:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
type PhoneNumber = Int
type PhoneBook =  M.Map PhoneNumber Person
</pre>

As a reminder, we import the module `DA.Next.Map` qualified with the prefix `M` because many
functions in the `DA.Next.Map` module have equally named corresponding functions in the already
imported `DA.Next.Set` module. For example, `insert` is defined in both of these modules.

Let's start with the empty phone book:
<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
emptyPhoneBook: PhoneBook
emptyPhoneBook = M.empty
</pre>

If we want to add a contact to the phone book, we use the `insert` function:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
testPhoneBook: PhoneBook
testPhoneBook = M.insert 123456789 testPerson emptyPhoneBook
</pre>

When you insert another element with the same key, the entry will be overwritten.

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
testPhoneBook1: PhoneBook
testPhoneBook1 = M.insert 123456789 (testPerson with name = "police") testPhoneBook
</pre>

If you want to lookup an entry in the book, use the `lookup` function
<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
maybeAPerson: Optional Person 
maybeAPerson = M.lookup 123456789 testPhoneBook
</pre>

Notice, that the lookup will return an `Optional Person`. This expresses the fact, that we don't
know whether the phone book contains the given phone number and the lookup might fail.

If we have a phone book as a list of tuples, we can construct a map with `fromList`:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
anotherPhoneBook: PhoneBook
anotherPhoneBook = M.fromList [(123456789, testPerson), (911, testPerson with name="police")]
</pre>

This is equivalent of inserting the elements one after another. If the list contains duplicate keys,
later elements will overwrite previous ones.

To convert a map back to a list of tuples you can use `toList.`

The `DA.Next.Map` module contains many useful functions to work with maps. Have a look at the
[documentation](https://docs.daml.com/daml/stdlib/DA-Next-Map.html) and then take the quiz:

>> 1) Which function constructs a 'Map a b' from a list of tuples '[(a, b)]'? <<
=== fromList

>> 2) How can you transform a given map 'm: Map a b' back to a list of tuples '[(a, b)]'? <<
=== toList m

>> 3) How do you insert a new element "hello world" with key 3 in a map 'm: Map Int Text' ?<<
=== insert 3 "hello world" m

>> 4) How do you lookup the element with key 3 in the map 'm' of the previous question? <<
=== lookup 3 m

>> 6) What's the return type of the lookup of the previous question? <<
() Text
(*) Optional Text

>> 7) Given the map 'm: Map Int Text', how do you filter for only even keys? <<
(*) filterWithKey (\k _v ->  k `mod` 2 == 0) m
() filter (k -> k `mod` 2 == 0) m

>> 8) What's the result of 'toList $ fromList [(1, "a"), (2, "b"), (2, "c")]'? Hint: Keep in mind that duplicate keys are overwritten in insertion oder. <<
=== [(1, "a"), (2, "c")]

**Scroll down to find the solutions for the quiz!**

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

### Solutions

1. `fromList`
1. `toList m`
1. `insert 3 "hello world" m`
1. `lookup 3 m`
1. `Optional Text`
1. `filterWithKey (\k _v ->  k `mod` 2 == 0) m`
1. `[(1, "a"), (2, "c")]` The element `(2, "b")` of the list is overwritten by the following `(2,"c")`.
