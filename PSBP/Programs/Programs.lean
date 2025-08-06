import PSBP.Specifications.ProgramSpecifications

import PSBP.Programs.PrimitivePrograms

unsafe def fibonacci
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program] :
  program Nat Nat :=
    if_ isZero one $
      else_ $
        if_ isOne one $
          else_ $
            (minusOne >=> fibonacci) &&&
            (minusTwo >=> fibonacci) >=>
            add

unsafe def factorial
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program] :
  program Nat Nat :=
    if_ isZero one $
      else_ $
        let_ (minusOne >=> factorial) $
          in_ $
            multiply

def twiceMinusOne01
    [Functional program]
    [Functorial program]
    [Creational program] :
  program Nat Nat :=
    minusOne &&& minusOne >-> addF

def twiceMinusOne02
    [Functional program]
    [Sequential program]
    [Creational program] :
  program Nat Nat :=
    minusOne &&& minusOne >=> add
