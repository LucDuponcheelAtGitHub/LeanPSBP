class WithFailure
    (ε : outParam Type)
    (program : Type → Type →Type) where
  failureWith {α β : Type} : (α → ε) → program α β

export WithFailure (failureWith)
