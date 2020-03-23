## Quizzes

>>Q1: Enter the extract string test<<
=== test

>>Q2: Enter the string containing test<<
=~= test

>>Q3: Multiple Choice <<
[*] Correct
[*] Correct
[ ] Incorrect

>>Q4: Single Choice <<
(*) Correct
( ) Incorrect

## Copy to Clipboard

```
var http = require('http');
var requestListener = function (req, res) {
  res.writeHead(200);
  res.end('Hello, World!');
}

var server = http.createServer(requestListener);
server.listen(3000, function() { console.log("Listening on port 3000")});
```{{copy}}

## Copy to Editor

Can't demo here :(

## Doing stuff in additional terminals

`echo "Hello From Terminal 2"`{{execute T2}}

## Interrupts

`echo "Shut Down"`{{execute T1 interrupt}}

