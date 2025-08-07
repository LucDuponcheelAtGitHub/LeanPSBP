import PSBP.Specifications.MonoidSpecification

import PSBP.Structures.ComputationValuedFunction

import PSBP.Implementations.WithFailureImplementation

import PSBP.Implementations.ActiveImplementations

abbrev ProgramWithValidation ε computation :=
  FromComputationValuedFunction (FailureT ε computation)

def materializeWithValidation
    [Monad computation]
    [Monoid ε] {α β : Type} :
  ProgramWithValidation ε computation α β →
  α →
  computation (ε ⊕ β) :=
    λ ⟨αftεcβ⟩ α =>
      (αftεcβ α).toComputationOfSum

def materializeActiveWithValidation
    [Monoid ε] {α β : Type} :
 ProgramWithValidation ε Active α β → α → (ε ⊕ β) :=
  materializeWithValidation
