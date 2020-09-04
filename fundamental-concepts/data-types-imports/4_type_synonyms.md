# Type synonyms

Sometimes, you don't want to create a new data type, but rather just rename it. This is what type
synonyms are for. Naming your types to indicate their function can greatly enhance clarity of your
code. Here's an example

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
type PhoneNumber = Int

prettyPhoneNumber: PhoneNumber -> Text
prettyPhoneNumber n = show n
</pre>

Later, you might decide that `Text` would be a more appropriate type for the phone number. Just
change the type synonym, while all function signatures with a `PhoneNumber` as argument stay the
same:

<pre class="file" data-target="clipboard">
type PhoneNumber = Text

prettyPhoneNumber: PhoneNumber -> Text
prettyPhoneNumber n = n
</pre>

Notice that while you can leave the type signature unchanged, you'll need to adapt the function
implementation.

You could also change the `PhoneNumber` synonym to an actual data definition: 

<pre class="file" data-target="clipboard">
data PhoneNumber = PhoneNumber {
  countryCode: Int,
  digitsGroup1: Int,
  digitsGroup2: Int,
  digitsGroup3: Int
}
</pre>

With this definition for `PhoneNumber` you have a more precise structure and can exclude a big
number of faulty phone numbers by construction of your data type.

Again, you're type signatures will remain valid, while you'll have to adapt the implementations.

<pre class="file" data-target="clipboard">
prettyPhoneNumber: PhoneNumber -> Text
prettyPhoneNumber pn = 
  "+" 
  <> (show pn.countryCode)
  <> " " <> (show pn.digitsGroup1)
  <> " " <> (show pn.digitsGroup2) 
  <> " " <> (show pn.digitsGroup3)
</pre>
