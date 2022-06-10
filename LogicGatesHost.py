import qsharp
from LogicGates import TestEntanglement
print(TestEntanglement.simulate())
from LogicGates import Deutsch_Jozsa
for j in range(3):
    for i in range(1,6):
        print(f"{j=}, result = {Deutsch_Jozsa.simulate(n = i, type = j)}")
from LogicGates import Deutsch
print(f"type = 0, {Deutsch.simulate(type = 0)}")
print(f"type = 1, {Deutsch.simulate(type = 1)}")
print(f"type = 2, {Deutsch.simulate(type = 2)}")
from LogicGates import funcTest


