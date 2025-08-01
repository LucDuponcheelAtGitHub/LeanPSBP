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
  map : {α β : Type} →
      (α → β) →
      (ReactiveT ρ computation α →
      ReactiveT ρ computation β) :=
    λ αfβ rpa =>
      ReactiveT.mk (λ γ => rpa.runReactiveT (γ ∘ αfβ))

instance {ρ: Type} :
  Applicative (ReactiveT ρ computation) where
  pure := λ α => ReactiveT.mk (λ afcr => afcr α)
  seq: {α β : Type} →
      (ReactiveT ρ computation (α → β)) →
      (Unit → (ReactiveT ρ computation α)) →
      (ReactiveT ρ computation β) :=
    λ rpafc ufrpa =>
      ReactiveT.mk (λ bfcr =>
        rpafc.runReactiveT $
          (λ αfβ =>
            (ufrpa ()).runReactiveT (bfcr ∘ αfβ)))

instance {ρ: Type} :
  Monad (ReactiveT ρ computation) where
  bind: {α β : Type} →
      (ReactiveT ρ computation α) →
      (α → ReactiveT ρ computation β) →
      (ReactiveT ρ computation β) :=
    λ rpa afrpb =>
      ReactiveT.mk (λ bfcr =>
        rpa.runReactiveT (λ α =>
        (afrpb α).runReactiveT bfcr))

abbrev ReactiveProgram ρ computation :=
  FromComputationValuedFunction (ReactiveT ρ computation)

def materializeReactive {α β : Type} :
    ReactiveProgram β Active α β → α → β :=
  λ αpβ =>
    λ α =>
      (αpβ.toComputationValuedFunction α).runReactiveT id
