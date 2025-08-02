import PSBP.ComputationBasedImplementations
import PSBP.Active

abbrev StatefulProgram σ computation :=
  FromComputationValuedFunction (StateT σ computation)

def materializeStateful
    [Monad computation] {α β : Type} :
      StatefulProgram σ computation α β →
      α →
      σ →
      computation β :=
  λ αpβ =>
    λ α =>
      λ σ =>
        StateT.run (αpβ.toComputationValuedFunction α) σ >>=
          λ (β, _) => pure β

def materializeActiveStateful {α β : Type} :
  StatefulProgram σ Active α β → α → σ → β :=
    materializeStateful
