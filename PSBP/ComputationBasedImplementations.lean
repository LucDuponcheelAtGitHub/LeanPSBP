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
    λ ⟨αfcβ⟩ βfγ => ⟨λ α => βfγ <$> αfcβ α⟩

instance [Applicative computation] :
    Creational
      (FromComputationValuedFunction computation) where
  product := λ ⟨αfcβ⟩ ⟨αfcγ⟩ =>
    ⟨λ α => pure .mk <*> αfcβ α <*> αfcγ α⟩

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
    WithState σ
      (FromComputationValuedFunction computation) where
  readState := ⟨λ _ => get⟩
  writeState := ⟨set⟩

def FailureT
    (ε : Type u)
    (computation : Type u → Type v)
    (β : Type u) : Type v :=
  computation (ε ⊕ β)

def FailureT.mk
    {ε : Type u}
    {computation : Type u → Type v}
    {α : Type u}
    (cεoα : computation (ε ⊕ α)) :
  FailureT ε computation α := cεoα

instance [Monad computation] :
    Monad (FailureT ε computation) where
  map  :=
  λ αfβ ftcα =>
    .mk (ftcα >>= λ εoα => match εoα with
      | (Sum.inr α) => pure $ Sum.inr (αfβ α)
      | (Sum.inl ε) => pure $ Sum.inl ε)
  pure :=
    λ α =>
      .mk (pure (Sum.inr α))
  bind :=
  λ ftcα αfftcβ =>
    .mk (ftcα >>= λ εoα => match εoα with
      | Sum.inr α  => αfftcβ α
      | Sum.inl ε  => pure (Sum.inl ε))

instance {ε : Type} [Applicative computation] :
    WithFailure ε
      (FromComputationValuedFunction
        (FailureT ε computation)) where
  failWith :=
    λ αfε =>
      ⟨λ α =>
        let cεpβ :=
          pure  $
            Sum.inl $
              αfε α
        cεpβ⟩
