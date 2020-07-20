# Functions

DAML is a functional programming language. Not surprisingly, the most fundamental data type of DAML
is the function type. Here is a simple example, that you can copy to the `daml/AddressBook.daml`{{open}} file in the IDE (click on the IDE tab and wait for it to load):

<pre class="file" data-filename="daml/Functions.daml" data-target="append">
answer: Int
answer = 42
</pre>

This is a constant function - it will always return the number `42`. The first line is the function
type declaration. It consists of the function name, followed by a colon and its type. The second
line is the function implementation. It repeats the function name, followed by its argument
variables, followed by an equality sign, followed by the actual implementation.

Here's a more interesting example:

<pre class="file" data-filename="daml/Functions.daml" data-target="append">
square: Int -> Int
square x = x * x
</pre>

Notice the function type. It declares that the function `square` takes one argument of type `Int`
and returns an `Int`. The arguments type is followed by an arrow `->` pointing to the return type.

If a function takes multiple arguments, each argument type points to the next one with an arrow
until it point to the final return type:

<pre class="file" data-filename="daml/Functions.daml" data-target="append">
diagonal: Decimal -> Decimal -> Decimal
diagonal a b = (a^2 + b^2) ** 0.5
</pre>

Here the `**` operator takes the power of a given number and is exported by the `DA.Math` module of
the standard library.  You will learn more on imports and the standard library in the next steps.

>> 1) Which of the following is the type of a function, that returns the number of occurences of a given character in a given string? <<
() Int -> Int
() String -> Int
(*) Char -> String -> Int
() Char -> Int -> Int

You apply functions to an argument by writing the argument after the function name. For example

<pre>
square 3 -- 9
answer -- 42
</pre>

>> 2) What is the result of 'diagonal 3.0 4.0' ?<<
(*) 5
() 9
() 42

Sometimes it can make your code clearer when you use `infix` notation.

<pre>
3.0 `diagonal` 4.0 -- 5.0
</pre>

To use a function of two arguments in infix position, you need to write its first argument on the
left, followed by the function name **enclosed in backticks**, followed by its second argument.

**Scroll down to find the solutions to the quiz!**

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

### Solutions

1. `Char -> String -> Int`. The first argument is the character to look for, the second argument is
the string in which the function looks for the character.

1. `5`. Because `diagonal 3 4 == (3^2 + 4^2) ** 0.5 == (9 + 16) ** 0.5 == 25 ** 0.5 = 5`.
