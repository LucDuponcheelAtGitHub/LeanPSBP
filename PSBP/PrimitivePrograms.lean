import PSBP.Specifications
import PSBP.PrimitiveFunctions

def isZero [Functional program] :
  program Nat Bool :=
    asProgram isZeroF

def isOne [Functional program] :
  program Nat Bool :=
    asProgram isOneF

def one [Functional program] :
  program Nat Nat :=
    asProgram oneF

def two [Functional program] :
  program Nat Nat :=
    asProgram twoF

def three [Functional program] :
  program Nat Nat :=
    asProgram threeF

def minusOne [Functional program] :
  program Nat Nat :=
    asProgram minusOneF

def minusTwo [Functional program] :
  program Nat Nat :=
    asProgram minusTwoF

def add [Functional program] :
  program (Nat × Nat) Nat :=
    asProgram addF

def multiply [Functional program] :
  program (Nat × Nat) Nat :=
    asProgram multiplyF
