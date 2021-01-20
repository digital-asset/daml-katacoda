# Importing modules 1/2: Importing your own modules

It greatly helps to read and maintain your code, when you structure it in several modules. Let's
import the previously created `AddressBook` module of the file `AddressBook.daml` in a new
`Organizer` module:

<pre class="file" data-filename="daml/Organizer.daml" data-target="append">
import AddressBook
</pre>

You can now use the exported data types, functions and templates as usual:

<pre class="file" data-filename="daml/Organizer.daml" data-target="append">
data Organizer = Organizer {
  owner: Person
}
</pre>

Your module names can have hierarchical namespaces like `Organizer.AddressBook`. In this case your
file needs to be in `Organizer/AddressBook.daml` relative to the root directory of your Daml source
code and the import will look like

<pre>
import Organizer.AddressBook
</pre>

You can also be more specific on what definitions you want in scope from your import:

<pre class="file" data-target="clipboard">
import AddressBook (Person(..), Address(..))
import Calendar (Calendar(..))
</pre>

The `(..)` means that the data type as well as all its constructors should be imported. If the
imported module declares a name that is already declared in the importing module or any of its
imports you can **qualify** the import:

<pre class="file" data-target="clipboard">
import qualified AddressBook as A
import qualified Calendar as C
</pre>

Now you can use the exported names of the `AddressBook` module by prepending the qualifier
`A.` and those of the `Calendar` module by prepending `C.`:

<pre class="file" data-target="clipboard">
data Organizer = Organizer {
  owner: A.Person,
  calendar: C.Calendar
}
</pre>

The [Prelude](https://docs.daml.com/daml/stdlib/Prelude.html#module-prelude-6842) module will always
be imported for you. You can read more on module imports and file structure
[here](https://docs.daml.com/daml/reference/file-structure.html#imports).

>> Which of the following functions/types will be in scope after the import statement "import AddressBook" <<
[*] Address (the constructor)
[*] Address (the type)
[*] street: Address -> Text
[*] city: Address -> Text
[*] country: Address -> Text
[] lookup: Map k v -> Optional v
[*] length: [a] -> Int

>> Which of the following functions/types will be in scope after the import statement "import qualified AddressBook as A" <<
[*] A.Address (the type)
[] street: Address -> Text
[*] A.street: Address -> Text
[*] length: [a] -> Int
[] lookup: Map k v -> Optional v

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

1.
  - `[*] Address` (the constructor) Type and constructor are imported
  - `[*] Address` (the type)
  - `[*] street: Address -> Text` The projection functions of the imported record types are imported
  - `[*] city: Address -> Text`
  - `[*] country: Address -> Text`
  - `[] lookup: Map k v -> Optional v` This belongs to the module `DA.Next.Map` which is not imported.
  - `[*] length: [a] -> Int` This belongs to `Prelude`, which is always imported.

1.

  - `[*] A.Address (the type)` Now the type as well as the constructor are imported qualified with a preceding `A.`.
  - `[] street: Address -> Text` This is missing the `A.` qualifier and hence is not in scope.
  - `[*] A.street: Address -> Text` As before, the projection functions of the records are imported, just with a qualifying `A.`.
  - `[*] length: [a] -> Int` This is imported from the `Prelude` module, which is always imported.
  - `[] lookup: Map k v -> Optional v` This is defined in the `DA.Next.Map` module, which is not imported.
