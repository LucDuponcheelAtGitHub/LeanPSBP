import PSBP.Structures.ComputationValuedFunction

import PSBP.Implementations.ActiveImplementations

abbrev ProgramWithState σ computation :=
  FromComputationValuedFunction (StateT σ computation)

def materializeWithState
    [Monad computation] {α β : Type} :
  ProgramWithState σ computation α β →
  α →
  σ →
  computation β :=
    λ ⟨αfstσcβ⟩ =>
      λ α =>
        λ σ =>
          StateT.run (αfstσcβ α) σ >>=
            λ (β, _) => pure β

def materializeActiveWithState {α β : Type} :
  ProgramWithState σ Active α β → α → σ → β :=
    materializeWithState
