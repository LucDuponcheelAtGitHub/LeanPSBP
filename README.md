# PSBP

*This is work in progress.*

## Program Spacification Based Programming

For now only one file `PSBP.lean` with comments.

All comments to improve the quality of the code (e.g. standard practices) 
are welcome.

## Comments on first commits

The first commit introduces *program* classes

- `Functional`,
- `Functorial`,
- `Creational`,
- `Sequential`,
- `Conditional`.

implements them *generically* as *computation valued functions* using

- `Functor`,
- `Applicative`,
- `Monad`,

and *materializes* them using

- `Active`,
- `Reactive`,

defines two *program specifications*

- `fibonacci`,
- `factorial`,

and runs them both with `10` in an *active* and in a *reactive* way.


```lean4
$ lean PSBP.lean
89
3628800
89
3628800
```



