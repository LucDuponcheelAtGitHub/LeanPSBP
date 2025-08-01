import PSBP.ComputationBasedImplementations

abbrev Active := Id

abbrev ActiveProgram α β :=
  FromComputationValuedFunction Active α β

def materializeActive :
    ActiveProgram α β → (α → β) :=
  λ ⟨αpβ⟩ => λ α => (αpβ α).run
