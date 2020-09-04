# Enumeration

The next fundamental data structure is the enumeration:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
data Gender
  = M
  | F
</pre>

Each option is named with an upper-case constructor and preceded by a `|`. An enumeration is just a
special case of a **sum data type**:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
  | Other Text
</pre>

Here, we added a third constructor with a text field. Sum data types can have any number of
constructors listed with a preceding `|`. Every constructor can take one or more arguments. To
construct the data, only one constructor of the listed ones is used.

In contrast, a record is a product data type, where every field of the record needs to be specified
to construct it.

When you want to **deconstruct** a sum type in a function, you need to use a **case** statement:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
prettyGender: Gender -> Text
prettyGender gender = case gender of
  M -> "male"
  F -> "female"
  Other o -> o
</pre>

>> What will 'prettyGender M' return ? <<
=== male

>> What will 'prettyGender $ Other "hello world"' return ? <<
=== hello world

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

1. male
1. hello world
