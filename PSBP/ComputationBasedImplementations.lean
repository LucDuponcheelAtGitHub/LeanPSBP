import PSBP.Specifications

structure FromComputationValuedFunction
    (computation : (Type → Type)) (α β : Type) where
  toComputationValuedFunction : α → computation β

instance [Applicative computation] :
    Functional
      (FromComputationValuedFunction computation) where
  asProgram :=
    λ αfβ => ⟨λ α => pure $ αfβ α⟩

instance [Functor computation] :
    Functorial
      (FromComputationValuedFunction computation) where
  andThenF :=
    λ ⟨αfcβ⟩ => λ βfγ => ⟨λ α => βfγ <$> αfcβ α⟩

instance [Applicative computation] :
    Creational
      (FromComputationValuedFunction computation) where
  product := λ ⟨αfcβ⟩ ⟨αfcγ⟩ =>
    ⟨λ α => pure Prod.mk <*> αfcβ α <*> αfcγ α⟩

instance [Monad computation] :
    Sequential
      (FromComputationValuedFunction computation) where
  andThen :=
    λ ⟨αfcβ⟩ ⟨βfcγ⟩ => ⟨λ α => αfcβ α >>= βfcγ⟩

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

instance [MonadStateOf σ computation] :
    Stateful σ
      (FromComputationValuedFunction computation) where
  readState := .mk λ _ => get
  writeState := .mk set

