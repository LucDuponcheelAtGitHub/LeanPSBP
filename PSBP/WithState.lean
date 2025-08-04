import PSBP.ComputationBasedImplementations
import PSBP.Active

abbrev ProgramWithState σ computation :=
  FromComputationValuedFunction (StateT σ computation)

def materializeWithState
    [Monad computation] {α β : Type} :
      ProgramWithState σ computation α β →
      α →
      σ →
      computation β :=
  λ ⟨αpβ⟩ =>
    λ α =>
      λ σ =>
        StateT.run (αpβ α) σ >>=
          λ (β, _) => pure β

def materializeActiveWithState {α β : Type} :
  ProgramWithState σ Active α β → α → σ → β :=
    materializeWithState
