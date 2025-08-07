import PSBP.Specifications.MonoidSpecification

instance : Monoid (List α) where
  ν := []
  combine := .append
