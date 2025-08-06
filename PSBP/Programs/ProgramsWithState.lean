import PSBP.Specifications.ProgramSpecifications
import PSBP.Specifications.WithStateSpecification

import PSBP.Programs.Programs

unsafe def fibonacciIncrementingArgument
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithState Nat program] :
  program Unit Nat :=
    withInitialStateAsInitialValue fibonacci >=>
    modifyStateWith (. + 1)

unsafe def fibonacciIncrementingArgumentPair
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithState Nat program] :
  program Unit (Nat × Nat) :=
    fibonacciIncrementingArgument &&&
    fibonacciIncrementingArgument
