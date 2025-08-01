import PSBP.Programs
import PSBP.PositionalPrograms

#eval "------------------------------------------------------------------------"
#eval "------------------------------------------------------------------------"
#eval "Active"
#eval "------------------------------------------------------------------------"
#eval "fibonacci 10 = ..."
#eval (materializeActive fibonacci) 10
#eval "------------------------------------------------------------------------"
#eval "factorial 10 = ..."
#eval (materializeActive factorial) 10
#eval "------------------------------------------------------------------------"
#eval "2 * (10 - 1) = ..."
#eval (materializeActive twiceMinusOne01) 10
#eval "------------------------------------------------------------------------"
#eval "2 * (10 - 1) = ..."
#eval (materializeActive twiceMinusOne02) 10
#eval "------------------------------------------------------------------------"
#eval "(10 - 2) + 2 * (10 - 1) + 3 = ..."
#eval (materializeActive someProgram01) 10
#eval "------------------------------------------------------------------------"
#eval "(positional) factorialOfFibonacci 5 = ..."
#eval (materializeActive positionalFactorialOfFibonacci) ((), 5)
#eval "------------------------------------------------------------------------"
#eval "(positional) sumOfFibonacciAndFactorial 10 = ..."
#eval (materializeActive positionalSumOfFibonacciAndFactorial) ((), 10)
#eval "------------------------------------------------------------------------"
#eval "(positional) factorialOfFibonacci stack for 5 = ..."
#eval (materializeActive positionalFactorialOfFibonacci') ((), 5)
#eval "------------------------------------------------------------------------"
#eval "(positional) sumOfFibonacciAndFactorial stack for 10 = ..."
#eval (materializeActive positionalSumOfFibonacciAndFactorial') ((), 10)
#eval "------------------------------------------------------------------------"
#eval "------------------------------------------------------------------------"
#eval "Reactive"
#eval "------------------------------------------------------------------------"
#eval "fibonacci 10 = ..."
#eval (materializeReactive fibonacci) 10
#eval "------------------------------------------------------------------------"
#eval "factorial 10 = ..."
#eval (materializeReactive factorial) 10
#eval "------------------------------------------------------------------------"
#eval "2 * (10 - 1) = ..."
#eval (materializeReactive twiceMinusOne01) 10
#eval "------------------------------------------------------------------------"
#eval "2 * (10 - 1) = ..."
#eval (materializeReactive twiceMinusOne02) 10
#eval "------------------------------------------------------------------------"
#eval "(10 - 2) + 2 * (10 - 1) + 3 = ..."
#eval (materializeReactive someProgram01) 10
#eval "------------------------------------------------------------------------"
#eval "(positional) factorialOfFibonacci 5 = ..."
#eval (materializeReactive positionalFactorialOfFibonacci) ((), 5)
#eval "------------------------------------------------------------------------"
#eval "(positional) sumOfFibonacciAndFactorial 10 = ..."
#eval (materializeReactive positionalSumOfFibonacciAndFactorial) ((), 10)
#eval "------------------------------------------------------------------------"
#eval "(positional) factorialOfFibonacci stack for 5 = ..."
#eval (materializeReactive positionalFactorialOfFibonacci') ((), 5)
#eval "------------------------------------------------------------------------"
#eval "(positional) sumOfFibonacciAndFactorial stack for 10 = ..."
#eval (materializeReactive positionalSumOfFibonacciAndFactorial') ((), 10)
#eval "------------------------------------------------------------------------"
#eval "------------------------------------------------------------------------"
