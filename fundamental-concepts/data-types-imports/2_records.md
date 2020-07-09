# Records

One of the most basic data types in DAML is the record. Here's an example:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
data Address = Address {
  street: Text,
  city: Text,
  country: Text
} deriving (Eq, Show)
</pre>

You define a record by listing its field names together with their types. The `deriving (Eq, Show)`
makes your record instances of the `Equality` and `Show` type classes. This is necessary if you want
your record to be a field of a contract template.

Records can be nested:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
data Person = Person {
  name: Text,
  address: Address,
  age: Int
}
</pre>

You can create a new `Person` record by assigning each field with a value:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
testPerson: Person
testPerson = Person {name = "Alice", address = Address {street = "RabbitStreet", city = "QueenOfHearts", country = "Wonderland"}, age = 7}
</pre>

When you write a function and you need to **deconstruct** a record you can **pattern match**:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
prettyAddress: Address -> Text
prettyAddress (Address aStreet aCity aCountry) = aStreet <> " - " <> aCity <> " - " <> aCountry
</pre>

Here we bound the variables `aStreet`, `aCity` and `aCountry` to the fields of the given `Address`
record in order of its definition. The `<>` operator concatenates two strings.

Or you can simply use the field accessors:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
prettyAddress1: Address -> Text
prettyAddress1 addr = addr.street <> " - " <> addr.city <> " - " <> addr.country
</pre>

>> 1) What will the following return: 'testPerson.age' ? <<
=== 7

>> 2) What will the following return: 'prettyAddress $ testPerson.address'? <<
===  RabbitStreet - QueenOfHearts - Wonderland

You can think of a contract **template** as a record data type annotated with what **parties** are
**signatories**, what parties are **observing** the contract and what **choices** to build
transactions are made available by the contract. We will cover these concepts in depth in the
following Katacoda's of the [fundamental concepts
course](https://daml.com/learn/fundamental-concepts). For example, we can turn our `Person` data
type into a simple contract template:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
template PersonContract
  with
    name: Party
    address: Address
    age: Int
  where
    signatory name
</pre>

Here we replaced the `name` field with one of type `Party`, because at least one field needs to be
of type `Party` in a template, so it can be used as signatory. As with records, you can access the
data fields of a contract with the field accessor functions and use pattern matches to deconstruct
it.

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
test = scenario do
  alice <- getParty "Alice"
  p <- submit alice $ create $ PersonContract {name = alice, address = Address {street = "RabbitStreet", city = "QueenOfHearts", country = "Wonderland"}, age = 7}
  submit alice $ do
    c <- fetch p
    assert $ c.name == alice
</pre>

**Scroll down to find the solutions to the quiz!**

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

1. `7`. Because `testPerson.age` projects onto the `age` factor of the `Person` record. In
   `testPerson` this is set to `7`.
1. `RabbitStreet - QueenOfHearts - Wonderland`. `testPerson.address` projects onto the `address`
   factor of `testPerson`. `prettyAddress` then concatenates the strings found in the `street`,
   `city` and `country` fields interleaved with ` - `.
