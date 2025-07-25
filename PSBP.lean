--------------------------------------------------------------------------------

/-!
generic, specification related, functions
-/

def foldSum (c2a : c → a) (b2a : b → a) (sum : c ⊕ b) : a :=
  match sum with
  | .inl tc => c2a tc
  | .inr tb => b2a tb


/-- clowns to the left, jokers to the right -/
def trueToLeftFalseToRightF : a × Bool → a ⊕ a
  | ⟨a, true⟩ => .inl a
  | ⟨a, false⟩ => .inr a

--------------------------------------------------------------------------------

/-!
specifications
-/

/-- functions are programs -/
class Functional (program : Type u → Type u → Type v) where
  function {a b : Type u} : (a → b) → program a b

export Functional (function)

/-- functions can act sequentially upon programs -/
class Functorial (program : Type u → Type u → Type v) where
  andThenF {a b c : Type u} : program a b → (b → c) → program a c

/-- programs can create product values -/
class Creational (program : Type u → Type u → Type v) where
  product {a b c : Type u} :
    program a b → program a c → program a (b × c)

export Creational (product)

infixl:60 " &&& " => product

/-- programs can act upon sequentially themselves -/
class Sequential (program : Type u → Type u → Type v) where
  andThen {a b c : Type u} : program a b → program b c → program a c

export Sequential (andThen)

infixl:50 " >=> " => andThen

/-- the identity function is a program -/
def identity [Functional program] : program a a :=
  function id

/-- programs can create intermediate values -/
def let_
    [Functional program] [Sequential program] [Creational program] :
  program a b → (program (a × b) c → program a c) :=
    fun a2b ab2c => identity &&& a2b >=> ab2c

/-- programs can consume sum values -/
class Conditional (program : Type u → Type u → Type v) where
  sum {a b c : Type u} : program c a → program b a → program (c ⊕ b) a

export Conditional (sum)

infixl:55 " ||| " => sum

def trueToLeftFalseToRight [Functional program] :
  program (a × Bool) (a ⊕ a) := function trueToLeftFalseToRightF

/-- trivial library level keyword -/
def in_ : a → a := id

/-- programs can perform conditional logic -/
def if_
    [Functional program]
    [Sequential program]
    [Creational program]
    [Conditional program] :
    program a Bool → program a b → program a b → program a b :=
  fun a2b la2b ra2b =>
    let_ a2b $
      in_ $
        (trueToLeftFalseToRight >=> la2b ||| ra2b)

/-- trivial library level keyword -/
def else_ {a} : a → a := id

--------------------------------------------------------------------------------

/-!
generic, implementation related, structure
-/

structure FromComputationValuedFunction
    (computation : (Type u → Type u)) (a b : Type u) where
  toComputationValuedFunction : a → computation b

--------------------------------------------------------------------------------

/-!
generic
Functional, Functorial, Creational, Sequential, Conditional
implementations
-/

instance [Applicative computation] :
    Functional (FromComputationValuedFunction computation) where
  function := fun a2b => ⟨fun a => pure $ a2b a⟩

instance [Functor computation] :
    Functorial (FromComputationValuedFunction computation) where
  andThenF := fun ⟨a2Cb⟩ => fun b2c => ⟨fun a => b2c <$> a2Cb a⟩

instance [Applicative computation] :
    Creational (FromComputationValuedFunction computation) where
  product := fun ⟨a2Cb⟩ ⟨a2Cc⟩ =>
    ⟨fun a => pure Prod.mk <*> a2Cb a <*> a2Cc a⟩

instance [Monad computation] :
    Sequential (FromComputationValuedFunction computation) where
  andThen := fun ⟨a2Cb⟩ ⟨b2Cc⟩ => ⟨fun a => a2Cb a >>= b2Cc⟩

instance :
    Conditional (FromComputationValuedFunction computation) where
  sum := fun ⟨c2Ca⟩ ⟨b2Ca⟩ => ⟨foldSum c2Ca b2Ca⟩

--------------------------------------------------------------------------------

/-!
specific
Functor, Applicative, Monad
implementations
-/

/-! the Active implementation is simply Id based -/

/-! the Reactive implementation is callback handler based -/

structure ReactiveT
    (result : Type u) (computation: Type u → Type u) (a : Type u) where
  runReactiveT : (a → computation result) → computation result

instance :
    Functor (ReactiveT result computation) where
  map: {a b : Type} →
    (a → b) →
    (ReactiveT result computation a → ReactiveT result computation b) :=
  fun a2b rCa =>
    ReactiveT.mk (fun callback =>
      rCa.runReactiveT (fun a => callback (a2b a)))

instance :
  Applicative (ReactiveT result computation) where
  pure := fun a => ReactiveT.mk (fun callback => callback a)
  seq: {a b : Type} →
    (ReactiveT result computation (a → b)) →
    (Unit → (ReactiveT result computation a)) →
    (ReactiveT result computation b) :=
  fun rCa2b u2rCa =>
    let rCa := u2rCa ()
    ReactiveT.mk (fun callback =>
      rCa2b.runReactiveT $
        (fun a2b =>
          rCa.runReactiveT (fun a => callback (a2b a))))

instance :
  Monad (ReactiveT result computation) where
  bind: {a b : Type} →
    (ReactiveT result computation a) →
    (a → ReactiveT result computation b) →
    (ReactiveT result computation b) :=
  fun rCa a2rCb =>
    ReactiveT.mk (fun callback =>
      rCa.runReactiveT (fun a => (a2rCb a).runReactiveT callback))

--------------------------------------------------------------------------------

/-!
specific implementation based materializations
-/

/-! Active materialization -/
abbrev Active := Id

abbrev ActiveProgram a b := FromComputationValuedFunction Active a b

def materializeActive : ActiveProgram a b → (a → b) :=
  fun ⟨a2Ab⟩ => fun a => (a2Ab a).run

/-! Reactive materialization -/
abbrev ReactiveProgram result computation :=
  FromComputationValuedFunction (ReactiveT result computation)

abbrev Reactive result := ReactiveT result Active

def materializeReactive : ReactiveProgram b Active a b → a → b :=
  fun a2Rb =>
    fun a =>
      (a2Rb.toComputationValuedFunction a).runReactiveT id

--------------------------------------------------------------------------------

/-!
primitive programs

actually, they are program specifications, but,
by abuse of notation, let's call them programs
-/

def isZeroF: Nat → Bool := fun a => a == 0

def isZero [Functional program] : program Nat Bool :=
  function isZeroF

def isOneF : Nat → Bool := fun a => a == 1

def isOne [Functional program] : program Nat Bool :=
  function isOneF

def oneF : Nat → Nat := fun _ => 1

def one [Functional program] : program Nat Nat := function oneF

def minusOneF : Nat → Nat := fun a => a - 1

def minusOne [Functional program] : program Nat Nat :=
  function minusOneF

def minusTwoF : Nat → Nat := fun a => a - 2

def minusTwo [Functional program] : program Nat Nat :=
  function minusTwoF

def addF : Nat × Nat → Nat :=
  fun ⟨a,b⟩ => a + b

def add [Functional program] : program (Nat × Nat) Nat :=
  function addF

def multiplyF : Nat × Nat → Nat :=
  fun ⟨a, b⟩ => a * b

def multiply [Functional program] : program (Nat × Nat) Nat :=
  function multiplyF

--------------------------------------------------------------------------------

/-!
composite (recursive) programs
'unsafe' keyword is used because Lean checks termination
-/

/-- fibonacci -/
unsafe def fibonacci
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program] :
    program Nat Nat :=
  if_ isZero one $
    else_ $
      if_ isOne one $
        else_ $
          (minusOne >=> fibonacci) &&& (minusTwo >=> fibonacci) >=> add

/-- factorial -/
unsafe def factorial
    [Functional program]
    [Creational program]
    [Sequential program]
    [Conditional program] :
    program Nat Nat :=
  if_ isZero one $
    else_ $
      let_ (minusOne >=> factorial) $
        in_ $
          multiply

--------------------------------------------------------------------------------

/-!
let's evaluate
-/

/-! active -/
#eval (materializeActive fibonacci) 10

#eval (materializeActive factorial) 10

/-! reactive -/
#eval (materializeReactive fibonacci) 10

#eval (materializeReactive factorial) 10

--------------------------------------------------------------------------------
