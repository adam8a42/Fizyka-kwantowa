import qsharp
from Grover import runSudokuSearch
print(runSudokuSearch.simulate(n = 2))
from Grover import TestSudokuOracle
print(TestSudokuOracle.simulate())
from Grover import runTestSearch
print(runTestSearch.simulate(n = 1))
