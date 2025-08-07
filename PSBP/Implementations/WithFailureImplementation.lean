import PSBP.Specifications.WithFailureSpecification
import PSBP.Specifications.MonoidSpecification

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
      ⟨pure $ .inr α⟩
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

instance
    [Functor computation] :
  Functor (FailureT ε computation) where
    map :=
     λ αfβ ⟨cεoα⟩ =>
       ⟨(λ εoα =>
           match εoα with
            | .inl ε => .inl ε
            | .inr α => .inr (αfβ α)) <$> cεoα
       ⟩

instance
    [Applicative computation]
    [Monoid ε] :
  Applicative (FailureT ε computation) where
    pure :=
      λ α =>
        ⟨pure $ .inr α⟩
    seq :=
      λ ⟨cεoαfβ⟩ ufftεcα =>
        let cεoα :=
          (ufftεcα ()).toComputationOfSum
        let εoαfεoαfβfεoβ {α β : Type} :
          (ε ⊕ α) → (ε ⊕ (α → β)) → (ε ⊕ β) :=
            λ εoα εoαfβ =>
              match εoα with
                | .inl ε =>
                  match εoαfβ with
                    | .inr _  => .inl ε
                    | .inl ε' => .inl (ε' * ε)
                | .inr α =>
                  match εoαfβ with
                    | .inr αfβ  => .inr (αfβ α)
                    | .inl ε' => .inl ε'
        ⟨εoαfεoαfβfεoβ <$> cεoα <*> cεoαfβ⟩
