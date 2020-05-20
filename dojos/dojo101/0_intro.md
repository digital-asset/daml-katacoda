# Rental Agreement

In this example we will implement a simple rental agreement use case. 

The goal of the tutorial is to teach you:
1. Authorisation & Consent
2. Propose/Accept pattern
3. Definting custom data
4. Writing functions
5. Using choices to enhance the workflow

## Task 1

Create a template named `RentAgreement`.
Add following fields:
1. `tenant` - what should be the data type?
2. `landlord` - what should be the data type?
3. `address` - what should be the data type?
4. `rent` - what should be the data type?
5. `terms` - this should be a list of terms, what should be the data type?

### Hint
<pre class="file" data-filename="daml/Rentals.daml">
template RentAgreement
  with
    tenant: ??
    landlord : ??
    address: ??
    rent:??
    terms: ??
  where
    signatory ??    
</pre>

### Key Question
Who all should be the signatories of this template?