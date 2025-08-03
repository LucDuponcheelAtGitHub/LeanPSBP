import PSBP.Specifications
import PSBP.Programs

unsafe def fibonacciIncrementingArgument
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [Stateful Nat program] :
  program Unit Nat :=
    withInitialStateAsInitialValue fibonacci >=>
    modifyStateWith (. + 1)


unsafe def fibonacciIncrementingArgumentPair
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [Stateful Nat program] :
  program Unit (Nat × Nat) :=
    fibonacciIncrementingArgument &&&
    fibonacciIncrementingArgument
