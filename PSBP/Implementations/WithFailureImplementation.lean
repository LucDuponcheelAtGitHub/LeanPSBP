import PSBP.Specifications.WithFailureSpecification

import PSBP.Structures.ComputationValuedFunction

structure FailureT
    (ε : Type)
    (computation : Type → Type)
    (β : Type) : Type where
  toComputationOfSum : computation (ε ⊕ β)

instance [Monad computation] :
    Monad (FailureT ε computation) where
  map :=
  λ αfβ ⟨cεoα⟩  =>
    ⟨cεoα >>= λ εoα => match εoα with
      | (.inr α) => pure $ .inr (αfβ α)
      | (.inl ε) => pure $ .inl ε⟩
  pure :=
    λ α =>
      .mk (pure (Sum.inr α))
  bind :=
    λ ⟨cεoα⟩ αfftεcβ =>
      ⟨cεoα >>= λ εoα => match εoα with
        | .inr α  => (αfftεcβ α).toComputationOfSum
        | .inl ε  => pure (.inl ε)⟩

instance {ε : Type}
    [Applicative computation] :
  WithFailure ε
    (FromComputationValuedFunction
      (FailureT ε computation)) where
  failureWith :=
    λ αfε =>
      ⟨λ α =>
        ⟨pure $ Sum.inl $ αfε α⟩⟩
