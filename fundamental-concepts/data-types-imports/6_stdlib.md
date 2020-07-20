# Importing modules 2/2: Importing the standard library

The same way you import your own module, you can import modules from the [standard
library](https://docs.daml.com/daml/stdlib/index.html). Let's import the `DA.Time` module and add a
birthday date to our `Person` data type in `daml/AddressBook.daml`{{open}}:

<pre class="file" data-target="clipboard">
import DA.Date
</pre>

Now we can extend the `Person` record in `daml/AddressBook`{{open}}

<pre class="file" data-target="clipboard">
data Person = Person {
  name: Text,
  address: Address,
  age: Int,
  birthday: Date
}
</pre>

And add the missing field to `testPerson`:

<pre class=file data-target="clipboard">
testPerson: Person
testPerson = Person {name = "Alice", address = Address {street = "RabbitStreet", city = "TheBigUnknown", country = "Wonderland"}, age = 7, birthday = date 30 Oct 2013}
</pre>

The functions `date` and the constructor `Oct` are provided by the `DA.Date` module of the standard
library. In the next steps we look at some of the most commonly used data types and functions
provided by the standard library.

The same way you import the standard library you can import modules of your own packages. You can do
this in three easy steps:

1. First compile the package with the module you want to import. In our case this would be the
   `organizer` package 

    ```
    cd organizer
    daml build
    ```{{execute T1}}

1. Next add the compiled package to your `daml.yaml` for the project you want to make the package
   available under the `dependencies` stanza:

    ```
    sdk-version: 1.2.0
    name: some-other-package
    version: 0.1.0
    source: daml
    parties:
    - Alice
    - Bob
    - Charlie
    dependencies:
    - daml-prim
    - daml-stdlib
    - daml-trigger
    - ../organizer/organizer-0.1.0.dar
    sandbox-options:
    - --wall-clock-time
    - --ledgerid=organzier-sandbox
    start-navigator: false
    ```

1. The last step is to add an `import` statement for the module you want to work with to your
   module source file. In our case this would be 

    ```
    import AddressBook
    ```
