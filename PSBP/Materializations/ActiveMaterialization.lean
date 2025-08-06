import PSBP.Structures.ComputationValuedFunction

import PSBP.Implementations.ActiveImplementations

abbrev ActiveProgram α β :=
  FromComputationValuedFunction Active α β

def materializeActive :
    ActiveProgram α β → (α → β) :=
  λ ⟨αfaβ⟩ α => (αfaβ α).run
