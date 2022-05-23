# Mapping and folding

If you're coming from an imperative language like Java or C/C++, you might be wondering how to write
a `for` loop to iterate over a list. There are no loop constructs in Daml! Instead, you can map over
a list with `map: (a -> b) -> [a] -> [b]` and accumulate local state with  folding functions like
`foldl: (b -> a -> b) -> b -> [a]-> b`. Take a look at the following `for`-loop in Java:

```java
int[] xs = {0, 1, 2, 3, 5, 8, 13};
int[] ys = {};
for (int i = 0; i < xs.length(); i++) {
  ys[i] = xs[i] * 3;
}

```

>> 1) How would you implement the above loop in Daml? <<
() ys = foldl (\y x -> x::y) [0] [0, 1, 2, 3, 5, 8, 13]
() ys = foldl (\_y x -> x * 3) 0 [0, 1, 2, 3, 5, 8, 13]
(x) ys = map (\x -> x * 3) [0, 1, 2, 3, 5, 8, 13]

Another syntax to map over lists is to use **list comprehension**. List comprehension lets you
express mappings over a list elegantly in mathematical set notation. For example, to express the
above Java loop with a list comprehension, you could simply write

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
timesThree: [Int]
timesThree = [x * 3 | x <- [0, 1, 2, 3, 5, 8, 13]]
</pre>

Another example is

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
evenElements: [Int]
evenElements = [x | x <- [0, 1, 2, 3, 5, 8, 13], x % 2 == 0]
</pre>

This filters the list `[0, 1, 2, 3, 5, 8, 13]` for only even elements. And the next list
comprehension computes all products of two given lists:

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
products: [Int]
products = [x * y | x <- [1, 2, 3], y <- [1, 2, 3]] -- [1, 2, 3, 2, 4, 6, 3, 6, 9]
</pre>

Now let's take a look at the following Java loop:

```java
int[] xs = {0, 1, 2, 3, 5, 8, 13};
y = 0;
for (int i = 0; i < xs.length(); i++) {
  y = y + x[i];
}
```

This example is different from the previous one, because it accumulates state in the `y` variable
while looping through the input list. Accumulating state while iterating over a list is done with
the `foldl` function.

```
foldl: (b -> a -> b) -> b -> [a] -> b
```

`foldl` takes a function, an initial state and a list as input. It then iterates over the list by
taking the current state and a list element and feeds it to the function to compute the next state.
Once the iteration has processed the last element of the list, it returns the accumulated state.

For example, you can implement the above Java loop in just one line with

<pre class="file" data-filename="daml/AddressBook.daml" data-target="append">
total: Int
total = foldl (\y x -> y + x) 0 [0, 1, 2, 3, 5, 8, 13]
</pre>

Not surprisingly, `sum: Additive a => [a]` is already provided by the `Prelude` module.

Here's another Java loop:

```java
int[] xs = {1, 2, 3, 5, 8, 13};
y = 1;
for (int i = 0; i < xs.length(); i++) {
  y = y * x[i];
}
```

>> 2) How would you implement the above loop in Daml? <<
(x) ys = foldl (\y x -> y * x) 1 [1, 2, 3, 5, 8, 13]
() ys = foldl (\y x -> x::y) [1] [1, 2, 3, 5, 8, 13]
() ys = foldl (\y x -> x * y) 0 [1, 2, 3, 5, 8, 13]

**Scroll down to find the solutions for the quiz!**

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

### Solutions

1. `ys = map (\x -> x * 3) [0, 1, 2, 3, 5, 8, 13]` This takes the list and maps the function `\x -> x * 3' over each element.
1. `ys = foldl (\y x -> y * x) 1 [1, 2, 3, 5, 8, 13]` This accumulates the product of the given elements, starting at `1`.
