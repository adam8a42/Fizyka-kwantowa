import qsharp
from LogicGates import TestEntanglement
print(TestEntanglement.simulate())
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

from LogicGates import funcTest


