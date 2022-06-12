import qsharp

from LogicGates import TestEntanglement
print(TestEntanglement.simulate(n = 10000))

from LogicGates import Deutsch_Jozsa
print(Deutsch_Jozsa.simulate(n = 2, type = 2))
print(Deutsch_Jozsa.simulate(n = 3, type = 2))
print(Deutsch_Jozsa.simulate(n = 4, type = 2))
print(Deutsch_Jozsa.simulate(n = 5, type = 2))
print(Deutsch_Jozsa.simulate(n = 2, type = 1))
print(Deutsch_Jozsa.simulate(n = 3, type = 0))
print(Deutsch_Jozsa.simulate(n = 4, type = 1))
print(Deutsch_Jozsa.simulate(n = 5, type = 0))

from LogicGates import Deutsch
print(Deutsch.simulate(type = 0))
print(Deutsch.simulate(type = 1))
print(Deutsch.simulate(type = 2))
