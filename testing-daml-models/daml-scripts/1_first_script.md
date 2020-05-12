The first thing you need to do when writing a DAML script is to include the DAML script package in
your dependencies. 

- First, **open the IDE and wait for it to load**
- After that, click on `daml.yaml`{{open}} to open the `daml.yaml` file.
- Add the line

<pre class="file" data-target="clipboard">
- daml-script
</pre>

  under the `dependencies` stanza. 

Now open the `daml/User.daml`{{open}} file and just before the module declaration line add the
language pragma

<pre class="file" data-target="clipboard">
{-# LANGUAGE ApplicativeDo #-}
</pre>

The `ApplicativeDo` language pragma is a trick to be able to reuse the `do` notation you already
know from DAML scenarios and upgrade blocks in DAML script.

Just after the module declaration add the `Daml.Script` library to the imports.  The `Daml.Script`
library provides you with all the script functions you're going to need. Take a look at its
[documentation](https://docs.daml.com/daml-script/daml-script-docs.html)! 

<pre class="file" data-target="clipboard">
import Daml.Script
</pre>

Your module header will now look like this

<pre class="file">
{-# LANGUAGE ApplicativeDo #-}

module User where

import Daml.Script

...
</pre>


You can now write you're first script. Append the following declaration to `daml/User.daml`:

<pre class="file" data-filename="daml/User.daml" data-target="append">

initialize: Script ()
initialize = do
  allocatePartyWithHint "operator" (PartyIdHint "operator")
  debug "done!"
</pre>

This script just allocates a new party on the ledger. 

1. The `Script ()` type tells you that this function is a script that doesn't return anything. 
1. Depending on the ledger, you can't choose party identifiers at will, but you can give it a
   display name and an identifier hint. This is accomplished with the `allocatePartyWithHint`
   function. The display name is a human readable name, used for example in log messages but *not*
   the real identifier. How the hint is used to allocate a party identifier depends on the ledger.
   For more information read
   [here](https://docs.daml.com/concepts/identity-and-package-management.html#identity-management).
1. The `debug` line outputs the string "done!" once the script reaches the final step. 

Note that `allocatePartyWithHint` will allocate a new party and should be used only for
initialization and testing of a ledger. If you are interacting with an already running and
initialized ledger, you would want to use existing party identifiers of that ledger.

In the next step we extend the script to allocate a couple more parties and let them follow each
other.
