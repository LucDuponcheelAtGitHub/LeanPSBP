import PSBP.Specifications.ProgramSpecifications
import PSBP.Specifications.WithFailureSpecification

import PSBP.Programs.PrimitivePrograms

def safeDiv
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithFailure String program] :
  program (Nat × Nat) Nat :=
    if_ (second >=> isNotZero) unsafeDiv $
      else_ $
        failureWith (λ (n, m) =>
          s!"tried to divide {n} by {m}")

def safeDivIsOne
[Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithFailure String program] :
  program (Nat × Nat) Bool :=
    safeDiv >=> isOne

def twiceSafeDiv
[Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithFailure String program] :
  program ((Nat × Nat) × Nat) Nat :=
    ((first >=> safeDiv) &&& second) >=> safeDiv
