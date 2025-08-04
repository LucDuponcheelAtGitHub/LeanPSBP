import PSBP.ComputationBasedImplementations
import PSBP.Active

structure ReactiveT
    (ρ : Type)
    (computation: Type → Type)
    (α : Type) where
  runReactiveT : (α → computation ρ) → computation ρ

abbrev Reactive ρ := ReactiveT ρ Active

instance {ρ: Type} :
    Functor (ReactiveT ρ computation) where
  map :=
    λ αfβ rcα =>
      ReactiveT.mk (λ γ => rcα.runReactiveT (γ ∘ αfβ))

instance {ρ: Type} :
    Applicative (ReactiveT ρ computation) where
  pure := λ α => ReactiveT.mk (λ αfcρ => αfcρ α)
  seq :=
    λ rcαfβ ufrcα =>
      ReactiveT.mk (λ bβfcρ =>
        rcαfβ.runReactiveT $
          (λ αfβ =>
            (ufrcα ()).runReactiveT (bβfcρ ∘ αfβ)))

instance {ρ: Type} :
    Monad (ReactiveT ρ computation) where
  bind :=
    λ rcα αfrcβ =>
      ReactiveT.mk (λ βfcρ =>
        rcα.runReactiveT (λ α =>
        (αfrcβ α).runReactiveT βfcρ))

abbrev ReactiveProgram ρ computation :=
  FromComputationValuedFunction (ReactiveT ρ computation)

def materializeReactive {α β : Type} :
    ReactiveProgram β Active α β → α → β :=
  λ ⟨αpβ⟩=>
    λ α =>
      (αpβ α).runReactiveT id

