import PSBP.Structures.ComputationValuedFunction

import PSBP.Implementations.ActiveImplementations

import PSBP.Implementations.ReactiveImplementations

abbrev ReactiveProgram ρ computation :=
  FromComputationValuedFunction (ReactiveT ρ computation)

def materializeReactive {α β : Type} :
    ReactiveProgram β Active α β → α → β :=
  λ ⟨αfrtacβ⟩ α =>
      (αfrtacβ α).runReactiveT id
