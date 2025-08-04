import PSBP.ComputationBasedImplementations

abbrev Active := Id

abbrev ActiveProgram α β :=
  FromComputationValuedFunction Active α β

def materializeActive :
    ActiveProgram α β → (α → β) :=
  λ ⟨αpβ⟩ α => (αpβ α).run
