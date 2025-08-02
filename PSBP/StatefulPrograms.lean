import PSBP.Specifications
import PSBP.Programs

unsafe def fibonacciIncrementingArgument
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [Stateful Nat program] :
  program Nat Nat :=
    usingAndModifyingStateAsArgumentWith (. + 1) fibonacci

unsafe def fibonacciIncrementingArgumentPair
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [Stateful Nat program] :
  program Nat (Nat × Nat) :=
    fibonacciIncrementingArgument &&&
    fibonacciIncrementingArgument
