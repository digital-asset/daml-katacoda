The analog of UNIX's read access right is the `observer` field in Daml. If you look at the `User`
contract template you see the line

<pre>
observer following
</pre>

in the template definition

![observers0](assets/observers0.png)

after the `where` keyword. This means that all party's that are element of the `following` field of
the contract are allowed to read, or in Daml speak *observe* the `User` contract.

Observers need to be specified in terms of fields of type `Party` of the contract template. Again,
this is because actual party identifiers are not available at the time you write a Daml model, but
are created on the actual underlying ledger after the Daml model has been deployed. This is similar
to specifying the UNIX access rights without knowing the names of the users on the system. The only
choice you have is to specify the rights in terms of the file contents.

If you click on the `Script results` above the test script you see that currently there is one
active `User` contract, and `Alice` is the only party to observe it.

![observers1](assets/observers1.png)

Who is observing what contract is indicated by the `X` under the parties name.

Now let `Alice` delete that contract and create one with the other two parties as followers. Replace
the last line in the script with

<pre class="file" data-target="clipboard">
  c0 <- submit alice $ createCmd User with username = alice, following = []
  submit alice $ archiveCmd c0
  submit alice $ createCmd User with username = alice, following = [bob, charlie]
</pre>

The table view changes to

![observers](assets/observers2.png)

You can see that the new `User` contract is not only observed by `Alice`, but also by `Bob` and
`Charlie` because they are in the `following` field and hence declared as observers by the line

<pre>
observer following
</pre>

The previous contract got archived and is still only observed by `Alice`.
