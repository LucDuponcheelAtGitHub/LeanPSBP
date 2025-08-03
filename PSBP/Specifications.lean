class Functional (program : Type → Type → Type) where
  asProgram {α β : Type} :
    (α → β) → program α β

export Functional (asProgram)

def identity
    [Functional program] :
  program α α :=
    asProgram id

def positionOne
    [Functional program] :
  program (σ × α) α :=
    asProgram  λ (_, α) => α

def positionTwo
    [Functional program] :
  program ((σ × β) × α) β :=
    asProgram λ ((_, β), _) => β

def positionOneAndTwo
    [Functional program] :
  program ((σ × β) × α) (α × β) :=
    asProgram λ ((_, β), α) => (α, β)

def first
    [Functional program] :
  program (α × β) α :=
    asProgram λ (α, _) => α

def second
    [Functional program] :
  program (α × β) β :=
    asProgram  λ (_, β) => β

-- ...

class Functorial (program : Type → Type → Type) where
  andThenF {α β γ : Type} :
    program α β → (β → γ) → program α γ

export Functorial (andThenF)

infixl:50 " >-> " => andThenF

class Creational (program : Type → Type → Type) where
  product {α β γ : Type} :
    program α β → program α γ → program α (β × γ)

export Creational (product)

infixl:60 " &&& " => product

class Sequential (program : Type → Type → Type) where
  andThen {α β γ : Type} :
    program α β → program β γ → program α γ

export Sequential (andThen)

infixl:50 " >=> " => andThen

def let_
    [Functional program]
    [Sequential program]
    [Creational program] :
  program α β → (program (α × β) γ → program α γ) :=
    λ αpβ αaβpγ => identity &&& αpβ >=> αaβpγ

def in_ : α → α := id

class Conditional (program : Type → Type → Type) where
  sum {α β γ : Type} :
    program γ α → program β α → program (γ ⊕ β) α

export Conditional (sum)

infixl:55 " ||| " => sum

def trueToLeftFalseToRightF : α × Bool → α ⊕ α
  | ⟨α, true⟩ => .inl α
  | ⟨α, false⟩ => .inr α

def trueToLeftFalseToRight
    [Functional program] :
  program (α × Bool) (α ⊕ α) :=
    asProgram trueToLeftFalseToRightF

def if_
    [Functional program]
    [Sequential program]
    [Creational program]
    [Conditional program] :
  program α Bool →
  program α β →
  program α β →
  program α β :=
    λ αpb t_apβ f_apβ =>
      let_ αpb $
        in_ $
          trueToLeftFalseToRight >=> t_apβ ||| f_apβ

def else_ : α → α := id

class Positional (program : Type → Type → Type) where
  at_ {σ α β γ : Type} :
    program α β →
    program σ α →
    program (σ × β) γ →
    program σ γ

export Positional (at_)

infixl:45 " @ " => at_

class Stateful
    (σ : Type)
    (program : Type → Type → Type) where
  readState {α : Type} : program α σ
  writeState : program σ Unit

export Stateful (readState writeState)

def modifyStateWith
    [Functional program]
    [Sequential program]
    [Creational program]
    [Stateful σ program] :
  (σ → σ) → program α α :=
    λ σfσ =>
      let_ ((readState >=> asProgram σfσ) >=> writeState) $
        in_ $
          first

def readingInitialStateAsInitialValueAndModifyingItWith
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program]
    [Stateful σ program] :
  (σ → σ) → program σ σ → program α σ :=
    λ σfσ =>
      λ σpσ =>
        (readState >=> modifyStateWith σfσ) >=> σpσ
