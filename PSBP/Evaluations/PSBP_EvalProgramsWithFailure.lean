import PSBP.Implementations.ProgramImplementations
import PSBP.Implementations.WithFailureImplementation

import PSBP.Materializations.WithFailureMaterialization

import PSBP.Programs.ProgramsWithFailure

#eval
  materializeActiveWithFailure safeDiv (10, 5) ==
    Sum.inr 2

#eval
  materializeActiveWithFailure safeDiv (10, 0) ==
    Sum.inl "tried to divide 10 by 0"

#eval
  materializeActiveWithFailure safeDivIsOne (10, 10) ==
    Sum.inr true

#eval
  materializeActiveWithFailure safeDivIsOne (10, 0) ==
    Sum.inl "tried to divide 10 by 0"

#eval
  materializeActiveWithFailure twiceSafeDiv ((10, 5), 2) ==
    Sum.inr 1

#eval
  materializeActiveWithFailure twiceSafeDiv ((10, 5), 0) ==
    Sum.inl "tried to divide 2 by 0"

#eval
  materializeActiveWithFailure twiceSafeDiv ((10, 0), 2) ==
    Sum.inl "tried to divide 10 by 0"

#eval
  materializeActiveWithFailure twiceSafeDiv ((10, 0), 0) ==
    Sum.inl "tried to divide 10 by 0"
