class Functional
    (program : Type → Type → Type) where
  asProgram {α β : Type} :
    (α → β) → program α β

export Functional (asProgram)

class Functorial
    (program : Type → Type → Type) where
  andThenF {α β γ : Type} :
    program α β → (β → γ) → program α γ

export Functorial (andThenF)

infixl:50 " >-> " => andThenF

class Sequential
    (program : Type → Type → Type) where
  andThen {α β γ : Type} :
    program α β → program β γ → program α γ

export Sequential (andThen)

infixl:50 " >=> " => andThen

class Creational
    (program : Type → Type → Type) where
  product {α β γ : Type} :
    program α β → program α γ → program α (β × γ)

export Creational (product)

infixl:60 " &&& " => product

class Conditional
    (program : Type → Type → Type) where
  sum {α β γ : Type} :
    program γ α → program β α → program (γ ⊕ β) α

export Conditional (sum)

infixl:55 " ||| " => sum

--
-- Functional
--

def identity
    [Functional program] :
  program α α :=
    asProgram id

def first
    [Functional program] :
  program (α × β) α :=
    asProgram λ (α, _) => α

def second
    [Functional program] :
  program (α × β) β :=
    asProgram λ (_, β) => β

def applyAtFirst
    [Functional program] :
  (α → β) → program (α × γ) (β × γ) :=
    λ αfβ => asProgram λ (α, γ) => (αfβ α, γ)

def applyAtSecond
    [Functional program] :
  (β → γ) → program (α × β) (α × γ) :=
    λ βfγ => asProgram λ (α, β) => (α, βfγ β)

def assoc
    [Functional program] :
  program ((α × β) × γ) (α × (β × γ)) :=
    asProgram (λ ((a, b), c) => (a, (b, c)))

def swap
    [Functional program] :
  program (α × β) (β × α) :=
    asProgram  λ (a, β) => (β, a)

def left
    [Functional program] :
  program γ (γ ⊕ β) :=
    asProgram .inl

def right
    [Functional program] :
  program β (γ ⊕ β) :=
    asProgram .inr

-- positional

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

-- ...

--
-- Creational
--

def let_
    [Functional program]
    [Sequential program]
    [Creational program] :
  program α β → (program (α × β) γ → program α γ) :=
    λ αpβ αaβpγ => identity &&& αpβ >=> αaβpγ

def in_ : α → α := id

def onlyFirst
    [Functional program]
    [Creational program]
    [Sequential program] :
  program α β → program (α × γ) (β × γ) :=
    λ αpβ => (first >=> αpβ) &&& second

infixl:50 " <&& " => onlyFirst

def onlySecond
    [Functional program]
    [Creational program]
    [Sequential program] :
  program β γ → program (α × β) (α × γ) :=
    λ βpγ => first &&& (second >=> βpγ)

infixl:50 " &&> " => onlySecond

def both
      [Functional program]
      [Sequential program]
      [Creational program] :
    program α γ → program β δ → program (α × β) (γ × δ) :=
      λ αpγ βpδ =>
        onlyFirst αpγ >=> onlySecond βpδ

infixl:50 " <&> " => both

--
-- Conditional
--

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
          asProgram (
            λ αab => match αab with
              | ⟨α, true⟩ => .inl α
              | ⟨α, false⟩ => .inr α
          ) >=>
          t_apβ ||| f_apβ

def else_ : α → α := id
