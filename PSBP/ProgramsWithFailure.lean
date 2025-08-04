import PSBP.Specifications
import PSBP.PrimitivePrograms

def safeDiv
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [WithFailure String program] :
  program (Nat × Nat) Nat :=
    if_ (second >=> isNotZero) unsafeDiv $
      else_ $
        failWith (λ (n, m) =>
          s!"tried to divide {n} by {m}")
