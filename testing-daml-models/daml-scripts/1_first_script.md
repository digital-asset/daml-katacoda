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

and just after the module declaration add the `Daml.Script` library to the imports. Your module
header will look like this

<pre>
{-# LANGUAGE ApplicativeDo #-}

module User where

import Daml.Script

...
</pre>

The `Daml.Script` library provides you with all the script functions you're going to need. Take a
look at its [documentation](https://docs.daml.com/daml-script/daml-script-docs.html)! The
`ApplicativeDo` language pragma is a trick to be able to reuse the `do` notation you already know
from DAML scenarios and upgrade blocks in choices.

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
   function. 
1. The `debug` line outputs the string "done!" once the script reaches the final step. 

In the next step we extend the script to allocate a couple more parties and let them follow each
other.
