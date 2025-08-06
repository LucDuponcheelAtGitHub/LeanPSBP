import PSBP.Specifications.ProgramSpecifications

import PSBP.Implementations.GenericImplementations

import PSBP.Programs.PrimitivePrograms
import PSBP.Programs.Programs

def somePositionalProgram01
    [Functional program]
    [Functorial program]
    [Creational program] :
  program Nat Nat :=
    minusOne &&& minusTwo &&& two &&& three >->
      λ (((n1, n2), n3), n4) =>
        n2 + n3 * n1 + n4 -- (10 - 2) + 2 * (10 - 1) + 3

def somePositionalProgram02
    [Functional program]
    [Sequential program]
    [Creational program] :
  program Nat Nat :=
    minusOne &&& minusTwo &&& two &&& three >=>
      asProgram (λ (((n1, n2), n3), n4) =>
        n2 + n3 * n1 + n4)

unsafe def positionalFactorialOfFibonacci
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program] :
  program (σ × Nat) Nat :=
    fibonacci @ positionOne $
      factorial @ positionOne $
        positionOne

unsafe def positionalSumOfFibonacciAndFactorial
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program] :
  program (σ × Nat) Nat :=
    fibonacci @ positionOne $
      factorial @ positionTwo $
        add @ positionOneAndTwo $
          positionOne

unsafe def positionalFactorialOfFibonacci'
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program] :
  program (σ × Nat) (((σ × Nat) × Nat) × Nat) :=
    fibonacci @ positionOne $
      factorial @ positionOne $
        identity

unsafe def positionalSumOfFibonacciAndFactorial'
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program] :
  program (σ × Nat) ((((σ × Nat) × Nat) × Nat) × Nat) :=
    fibonacci @ positionOne $
      factorial @ positionTwo $
        add @ positionOneAndTwo $
          identity
