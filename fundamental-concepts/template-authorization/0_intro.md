A central advantage of a Daml model over a traditional database schema is that Daml allows you to
specify fine grained access rights to each of its contract templates. This is a central ingredient
to write secure and privacy respecting multi-user applications. Whether your backing ledger is a
centralized database or a fully distributed ledger with hundreds of nodes, having data access rights
as part of your Daml model gives you the peace of mind that your application does not contain any
loop-holes and your users data is save.

In this scenario we'll have a close look at the Daml code of the [extended Getting Started
Guide](https://daml.com/learn/getting-started/your-first-feature) and examine the concepts behind

- **parties**
- **observers**
- **signatories**
- **controllers**

We test our understanding by writing Daml scripts and see what errors we get when we try to
violate the specified contract template permissions.
