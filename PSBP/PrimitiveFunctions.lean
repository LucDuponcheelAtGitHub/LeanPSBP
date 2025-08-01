def isZeroF: Nat → Bool :=
  λ ν => ν == 0

def isOneF : Nat → Bool :=
  λ ν => ν == 1

def oneF : Nat → Nat :=
  λ _ => 1

def twoF : Nat → Nat :=
  λ _ => 2

def threeF : Nat → Nat :=
  λ _ => 3

def minusOneF : Nat → Nat :=
  λ ν => ν - 1

def minusTwoF : Nat → Nat :=
  λ ν => ν - 2

def addF : Nat × Nat → Nat :=
  λ ⟨ν, μ⟩ => ν + μ

def multiplyF : Nat × Nat → Nat :=
  λ ⟨ν, μ⟩ => ν * μ
