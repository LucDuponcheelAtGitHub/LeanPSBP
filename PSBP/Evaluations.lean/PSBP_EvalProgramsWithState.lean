import Init.Control.State

import PSBP.Implementations.ProgramImplementations
import PSBP.Implementations.WithStateImplementation

import PSBP.Materializations.WithStateMaterialization

import PSBP.Programs.ProgramsWithState

#eval "fibonacciIncrementingArgumentPair () 10 = ..."
#eval (materializeActiveWithState fibonacciIncrementingArgumentPair) () 10
