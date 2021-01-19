# Sample code

**This repo contains sample code to help you get started with Daml. Please bear in mind that it is provided for illustrative purposes only, and as such may not be production quality and/or may not fit your use-cases. You may use the contents of this repo in parts or in whole according to the BSD0 license:**

> Copyright © 2020 Digital Asset (Switzerland) GmbH and/or its affiliates
>
> Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.
>
> THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# Katacoda configuration for Daml

This repo contains environment definitions and scenarios for using Daml within
the [Katacoda](https://www.katacoda.com) learning environment.

# Ensuring that Daml projects used in the scenarios are up to date with the latest Daml SDK version

When using external Daml projects in the scenario (e.g., via a downloaded `.tar` file) make sure that `daml.yaml` file references the Daml SDK version used in the Katacoda environment. You can do that by either

- Creating a new project with `daml new` command and moving the project files into the folder
- By changing the Daml SDK version in the `daml.yaml` file via shell and awk

# Upgrading the Daml SDK version in the Katacoda environment

When upgrading the Daml SDK version in the Katacoda environment make sure to go through all the scenarios and update
the code snippets that are used in the scenario with the appropriate version (mainly daml version in `daml.yaml` file)
