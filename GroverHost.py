import qsharp

from Grover import runSudokuSearch
correct = 0
for i in range(100):
    x = runSudokuSearch.simulate(n = 2)
    if(x == [0,1,1,0] or x == [1,0,0,1]):
        correct+=1
    print(x)
print(correct)


from Grover import TestSudokuOracle
#print(TestSudokuOracle.simulate())

from Grover import runTestSearch
#print(runTestSearch.simulate(n = 1))
