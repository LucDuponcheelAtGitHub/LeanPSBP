import PSBP.Structures.ComputationValuedFunction

import PSBP.Implementations.WithFailureImplementation

import PSBP.Implementations.ActiveImplementations

abbrev ProgramWithFailure ε computation :=
  FromComputationValuedFunction (FailureT ε computation)

def materializeWithFailure
    [Monad computation] {α β : Type} :
      ProgramWithFailure ε computation α β →
      α →
      computation (ε ⊕ β) :=
  λ ⟨αftcβ⟩ α =>
    (αftcβ α).toComputationOfSum

def materializeActiveWithFailure {α β : Type} :
 ProgramWithFailure ε Active α β → α → (ε ⊕ β) :=
  materializeWithFailure
