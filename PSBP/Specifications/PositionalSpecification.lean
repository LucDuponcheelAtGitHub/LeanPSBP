class Positional
    (program : Type → Type → Type) where
  at_ {σ α β γ : Type} :
    program α β →
    program σ α →
    program (σ × β) γ →
    program σ γ

export Positional (at_)

infixl:45 " @ " => at_
