In this example we will implement a simple rental agreement use case.

The goal of the tutorial is to teach you:
1. Authorisation & Consent
2. Propose/Accept pattern

## Rent Agreement:
![RentAgreement](/vivek-da/courses/dojos/dojo101/assets/agreement.png)

## Intro to Daml lingo

Imagine the piece of paper, where all the terms & conditions are written but the name of the tenant, landlord, property address etc. is not populated. This represents the rights and obligations of the parties involved in the rental agreement. In other words, this represents the rule book by which all the parties need to comply. This rulebook, essentially, is what you codify in Daml. This is done by writing `templates`. Now when the parties involved sign that document and populate the fields, it becomes a `contract`.
(covered in [Templates](https://docs.daml.com/daml/intro/1_Token.html#templates))



<!-- 3. Defining custom data
4. Writing functions
5. Using choices to enhance the workflow -->
