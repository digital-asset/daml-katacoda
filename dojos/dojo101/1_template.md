Let's begin!! 

Now please follow the two steps, highlighted in the image below:
1. Click on IDE
2. Open the file `Rentals.daml`

![IDE Help](/vivek-da/courses/dojos/dojo101/assets/idehelp.png)


A DAML file defines a module. The first line of a DAML file gives the module a name. In this case, its `Rentals`, thus the file name `Rentals.daml`.


## Task 1
Create a template named `RentAgreement`.
Add following fields:
1. `tenant` - what should be the data type?
2. `landlord` - what should be the data type?
3. `address` - what should be the data type?
4. `rent` - what should be the data type?
<!-- 5. `terms` - this should be a list of terms, what should be the data type? -->

Templates define a type of contract that can exist on the ledger, together with its data, and involved parties.

`RentAgreement` is a `template` that defines a `contract` that has some state like `address`, `rent` and `terms` and the  parties involved are stored in fields `tenant` and `landlord`.

Each `template` has a `with` block defining the data type of the data stored on an instance of that contract. Blocks are indicated through indentation. The `template` is a block so `with` is indented. The contents of the `with` block are indented further.

Here are some native types we will use (covered in [Data Types](https://docs.daml.com/daml/intro/3_Data.html#data-types)):
1. `Party` Stores the identity of an entity that is able to act on the ledger, in the sense that they can sign contracts and submit transactions. In general, Party is opaque.
2. `Text` Stores a unicode character string like "Alice".
3. `Decimal` Stores fixed-point number with 28 digits before and 10 digits after the decimal point. For example, 0.0000000001 or -9999999999999999999999999999.9999999999.

Following the `with` block is a `where` block, which gives the contract meaning by defining the roles parties play and how contract instances can be transformed.

Every `template` has a `signatory` expression in its `where` block. The `signatory` expression defines one or more _parties_ to be _signatories_. The signatories must authorize the creation of a contract instance and verify the validity of any action performed on it.


You can type in the file yourself or use "Copy to Editor" feature.
### Hint
<pre class="file" data-filename="daml/Rentals.daml">
template RentAgreement
  with
    tenant: ??
    landlord : ??
    address: ??
    rent:??
  where
    signatory ??    
</pre>

### Key Question
Who all should be the signatories of this template?