Re-creating DAR's
=================

You can recreate the dar's shipped in the `assets/create-daml-app.tar.gz` with the provided sources
in `forum` and `migration`.

For `forum`: you need to change the imported `create-daml-app` package version to get the two
versions of forum. `forum-0.1.0` needs the `Init.daml.back` script (after renaming) and
`forum-0.1.1` the `Init.daml` initialization script.
