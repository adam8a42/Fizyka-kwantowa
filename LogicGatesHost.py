import qsharp
from LogicGates import TestEntanglement
print(TestEntanglement.simulate())
from LogicGates import Deutsch_Jozsa
print(Deutsch_Jozsa.simulate(n = 2, type = 1))
from LogicGates import Deutsch
print(Deutsch.simulate(type = 0))
print(Deutsch.simulate(type = 1))
print(Deutsch.simulate(type = 2))