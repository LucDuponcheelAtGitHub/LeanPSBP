import PSBP.ComputationBasedImplementations
import PSBP.Active

abbrev ProgramWithFailure ε computation :=
  FromComputationValuedFunction (FailureT ε computation)

def materializeWithFailure
    [Monad computation] {α β : Type} :
      ProgramWithFailure ε computation α β →
      α →
      computation (ε ⊕ β) :=
  λ ⟨αpβ⟩ α =>
    αpβ α

def materializeActiveWithFailure {α β : Type} :
 ProgramWithFailure ε Active α β → α → (ε ⊕ β) :=
  materializeWithFailure
