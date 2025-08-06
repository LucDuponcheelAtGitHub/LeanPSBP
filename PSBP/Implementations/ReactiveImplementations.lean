import PSBP.Implementations.ActiveImplementations

structure ReactiveT
    (ρ : Type)
    (computation: Type → Type)
    (α : Type) where
  runReactiveT : (α → computation ρ) → computation ρ

abbrev Reactive ρ := ReactiveT ρ Active

instance {ρ: Type} :
    Functor (ReactiveT ρ computation) where
  map :=
    λ αfβ ⟨rcα⟩ =>
      ⟨λ γ => rcα (γ ∘ αfβ)⟩

instance {ρ: Type} :
    Applicative (ReactiveT ρ computation) where
  pure := λ α => ReactiveT.mk (λ αfcρ => αfcρ α)
  seq :=
    λ ⟨rcαfβ⟩ ufrtcα =>
      ⟨λ βfcρ =>
        rcαfβ $
          (λ αfβ =>
            (ufrtcα ()).runReactiveT (βfcρ ∘ αfβ))⟩

instance {ρ: Type} :
    Monad (ReactiveT ρ computation) where
  bind :=
    λ ⟨rcα⟩ αfrtcβ =>
      ⟨λ βfcρ =>
        rcα (λ α =>
        (αfrtcβ α).runReactiveT βfcρ)⟩
