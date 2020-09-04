# Optional fields

Sometimes you need to deal with data fields that are **optional**. This means that the value might
not be specified at the time of creating the record. For example, you might want to add an optional
email address field to the `Person` record. Replace the definition of the `Person` data type and add
the additional import:

<pre class="file" data-target="clipboard">
import DA.Optional

data Person = Person {
  name: Text,
  address: Address,
  age: Int,
  email: Optional Text
}
</pre>

Optional fields are either present or absent. Replace the `testPerson` function with

<pre class="file" data-target="clipboard">
testPerson: Person
testPerson = Person {name = "Alice", address = Address {street = "RabbitStreet", city = "TheBigUnknown", country = "Wonderland"}, age = 7, email = Some "alice@wonderland.com"}
</pre>

or

<pre class="file" data-target="clipboard">
testPerson: Person
testPerson = Person {name = "Alice", address = Address {street = "RabbitStreet", city = "TheBigUnknown", country = "Wonderland"}, age = 7, email = None}
</pre>

Likewise, you can pattern match against the two constructors `Some: a -> Optional a` and `None:
Optional a` to deconstruct an optional value:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
prettyEmail: Optional Text -> Text
prettyEmail mbEmail = case mbEmail of
  None -> " -- "
  Some email -> email
</pre>

Often, you want to replace the `None` case with a default value like in the `prettyEmail` function
above. The function `fromOptional` does just that. Replace `prettyEmail` with:

<pre class="file" data-target="clipboard">
prettyEmail: Optional Text -> Text
prettyEmail mbEmail = fromOptional " -- " mbEmail
</pre>

Optional values can also be used as return values of functions, if you want to indicate that the
computation might fail or might be undefined. `lookup` of `DA.Next.Map` is an archetypal example:

<pre>
lookup: Map k v -> Optional v
</pre>

The `lookup` function makes it very clear by its type that it might fail and there does not exist a
value with the given key. The `Optional` return value forces the consumer to deal with the possible
failure.


If you have a list of optional values, but you're only interested in the values that are present,
you can filter them with `catOptionals:`

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
allEmails: [Text]
allEmails = catOptionals [testPerson.email]
</pre>

Have a look at the
[documentation](https://docs.daml.com/daml/stdlib/DA-Optional.html#module-da-optional), then try to
answer the following quiz:

>> 1) Which function of type `f: a -> Optional a -> a` converts an optional value to a value, given a default case for when the optional value is None ? <<
=== fromOptional

>> 2) Which function of type `f: [Optional a] -> [a]` converts a list of optional values to a list which contains only the value constructed with 'Some'. <<
=== catOptionals

`DA.Either` is another and richer way to encode errors in your data types. Instead of returning
`None` in the error case, you can return `Left "a reason why the error happened"`. `DA.Either` is a
good type to return for a function that can fail.

**Scroll down to find the solution to the quiz!**

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

1. fromOptional
1. catOptionals
