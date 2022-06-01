import qsharp
from LogicGates import TestEntanglement
print(TestEntanglement.simulate())
from LogicGates import Deutsch_Jozsa
print(Deutsch_Jozsa.simulate(n = 2, type = 2))
