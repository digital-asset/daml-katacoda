Canton releases come in two variants: Community or Enterprise. Both support the full Canton protocol, but differ in terms of enterprise and non-functional capabilities:


<table class="colwidths-given docutils align-default" id="id1">
<colgroup>
<col style="width: 50%">
<col style="width: 25%">
<col style="width: 25%">
</colgroup>
<thead>
<tr class="row-odd"><th class="head"><p>Capability</p></th>
<th class="head"><p>Enterprise</p></th>
<th class="head"><p>Community</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><p>Daml Synchronisation</p></td>
<td><p>Yes</p></td>
<td><p>Yes</p></td>
</tr>
<tr class="row-odd"><td><p>Sub-Transaction Privacy</p></td>
<td><p>Yes</p></td>
<td><p>Yes</p></td>
</tr>
<tr class="row-even"><td><p>Transaction Processing</p></td>
<td><p>Parallel (fast)</p></td>
<td><p>Sequential (slow)</p></td>
</tr>
<tr class="row-odd"><td><p>High Availability</p></td>
<td><p><a class="reference internal" href="https://docs.daml.com/canton/usermanual/ha.html#ha-user-manual"><span class="std std-ref">Yes</span></a></p></td>
<td><p>No</p></td>
</tr>
<tr class="row-even"><td><p>High Throughput via Microservices</p></td>
<td><p><a class="reference internal" href="https://docs.daml.com/canton/usermanual/ha.html#ha-user-manual"><span class="std std-ref">Yes</span></a></p></td>
<td><p>No</p></td>
</tr>
<tr class="row-odd"><td><p>Resource Management</p></td>
<td><p>Yes</p></td>
<td><p>No</p></td>
</tr>
<tr class="row-even"><td><p>Ledger Pruning</p></td>
<td><p>Yes</p></td>
<td><p>No</p></td>
</tr>
<tr class="row-odd"><td><p>Postgres Backend</p></td>
<td><p>Yes</p></td>
<td><p>Yes</p></td>
</tr>
<tr class="row-even"><td><p>Oracle Backend</p></td>
<td><p>Yes</p></td>
<td><p>No</p></td>
</tr>
<tr class="row-odd"><td><p>Besu Driver</p></td>
<td><p>Yes</p></td>
<td><p>No</p></td>
</tr>
<tr class="row-even"><td><p>Fabric Driver</p></td>
<td><p>Yes</p></td>
<td><p>No</p></td>
</tr>
</tbody>
</table>

In this tutorial we will show you how to download and set up Canton Open Source.

Let's first download Canton's `.tar` file from the [GitHub repository](https://github.com/DACH-NY/canton).

```
 wget https://github.com/digital-asset/daml/releases/download/v2.1.1/canton-open-source-2.1.1.tar.gz
```{{execute T1}}

We'll extract it next.

```
tar xzf canton-open-source-2.1.1.tar.gz
```{{execute T1}}

This guide uses the example configurations you can find in the release bundle under `example/03-advanced-configuration` and explains you how to leverage these examples for your purposes. Therefore, any file named in this guide will refer to subdirectories of the advanced configuration example.
