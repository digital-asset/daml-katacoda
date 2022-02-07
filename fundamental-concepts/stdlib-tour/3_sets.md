# Sets

In a previous step we added the `addresses` field to the `Person` data type.

<pre>
data Person = Person {
  name: Text,
  addresses: [Address],
  age: Int
}
</pre>

But does the order of the addresses matter to us? Shouldn't all addresses in each `Person` entry be
unique? If we choose `addresses` to be a `Set` instead we have these two properties by
construction. In order to use it let's add it to the list of imported modules:

<pre class="file" data-target="clipboard">
import DA.Set

</pre>

And let's replace the previous implementation of `Person` and `testPerson`:

<pre class="file" data-target="clipboard">
data Person = Person {
  name: Text,
  addresses: Set Address,
  age: Int
}

testPerson: Person
testPerson = Person {name = "Alice", addresses = fromList [Address {street = "RabbitStreet", city = "QueenOfHearts", country = "Wonderland"}], age = 7}
</pre>

Every element of a set is unique and there is no order defined between the elements. You can
construct a set from a list with the `fromList` function. `Set` is also a better choice for the container if you need to find, delete or check for membership often. Testing for membership of an element in the set is done with the `member` function.  `Set` is a worse choice if you find yourself iterating over big sets often. In that case you might want to
use a list. To convert a set back to a list you apply the `toList` function.

Take a look at the [documentation](https://docs.daml.com/daml/stdlib/DA-Set.html) for the
available algorithms operating on sets.

>> 1) How do check for membership of an element x in the set A ? <<
[*] x `member` A
[] x `in` A
[*] member x A
[] has x A

>> 2) How can you compute the intersection of two sets? <<
() A `difference` B
(*) A `intersect` B

>> 3) What's the result of size $ fromList [0, 1, 1, 2, 3, 5, 8] ? <<
() 7
(*) 6

**Scroll down to see the solutions to the quiz!**

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

1. - `[*] x `member` A` member is the right function here, in infix or normal position
   - `[] x `in` A`
   - `[*] member x A`
   - `[] has x A`

1. `A `intersect` B`. Set intersection is done with `intersect`.
1. `6` It's not 7, because there are 2 ones in the list.
