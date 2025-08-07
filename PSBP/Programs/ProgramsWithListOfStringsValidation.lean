import PSBP.Specifications.ProgramSpecifications
import PSBP.Specifications.WithFailureSpecification

import PSBP.Programs.PrimitivePrograms

def accumulatingSafeDiv
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithFailure (List String) program] :
  program (Nat × Nat) Nat :=
    if_ (second >=> isNotZero) unsafeDiv $
      else_ $
        failureWith (λ (n, m) =>
          [s!"tried to divide {n} by {m}"])

def accumulatingSafeDivIsOne
[Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithFailure (List String) program] :
  program (Nat × Nat) Bool :=
    accumulatingSafeDiv >=> isOne

def twiceAccumulatingSafeDivIsOne
[Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithFailure (List String) program] :
  program ((Nat × Nat) × Nat) Nat :=
    ((first >=> accumulatingSafeDiv) &&& second) >=> accumulatingSafeDiv

def accumulatingSafeDivProduct
[Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithFailure (List String) program] :
  program ((Nat × Nat) × (Nat × Nat)) (Nat × Nat) :=
    (first >=> accumulatingSafeDiv) &&& (second >=> accumulatingSafeDiv)

def addAccumulatingSafeDivProduct
[Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithFailure (List String) program] :
  program ((Nat × Nat) × (Nat × Nat)) Nat :=
    (first >=> accumulatingSafeDiv) &&& (second >=> accumulatingSafeDiv) >=> add
