# Domain Specific Language Example

This is an implementation of a DSL using [Happy](https://www.haskell.org/happy/).
The DSL is the arithmetic language used in the [Happy tutorial/documentation](https://www.haskell.org/happy/doc/html/sec-using.html).
This project is an interpreter for the DSL.

Build the interpreter with the following commands:

```
happy calc.y -o Calc.hs
ghc --make Calc.hs -outputdir=lib
```

Test the interpreter with this example, put the following text into a `example.txt`:

```
let x = 10 in 
let y = 20 in 
x + y
```

Evaluate the example with command, `./Calc example.txt` which will generate the result `30.0`.

I wrote the code in `Interpret.hs`, most of the rest comes from the tutorial.
