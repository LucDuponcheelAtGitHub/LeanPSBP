import PSBP.Specifications.ProgramSpecifications

import PSBP.Structures.ComputationValuedFunction

instance [Applicative computation] :
    Functional
      (FromComputationValuedFunction computation) where
  asProgram :=
    λ αfβ => ⟨λ α => pure $ αfβ α⟩

instance [Functor computation] :
    Functorial
      (FromComputationValuedFunction computation) where
  andThenF :=
    λ ⟨αfcβ⟩ βfγ => ⟨λ α => βfγ <$> αfcβ α⟩

instance [Monad computation] :
    Sequential
      (FromComputationValuedFunction computation) where
  andThen :=
    λ ⟨αfcβ⟩ ⟨βfcγ⟩ => ⟨λ α => αfcβ α >>= βfcγ⟩

instance [Applicative computation] :
    Creational
      (FromComputationValuedFunction computation) where
  product := λ ⟨αfcβ⟩ ⟨αfcγ⟩ =>
    -- ⟨λ α => pure .mk <*> αfcβ α <*> αfcγ α⟩
    ⟨λ α => .mk <$> αfcβ α <*> αfcγ α⟩

def foldSum {γ β α : Type}
    (γfα : γ → α)
    (βfα : β → α)
    (sum : γ ⊕ β) : α :=
  match sum with
  | .inl tc => γfα tc
  | .inr tb => βfα tb

instance :
    Conditional
      (FromComputationValuedFunction computation) where
  sum := λ ⟨γfγα⟩ ⟨βfγα⟩ => ⟨foldSum γfγα βfγα⟩
