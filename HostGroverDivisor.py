import qsharp
qsharp.packages.add("Microsoft.Quantum.Numerics")
qsharp.reload()

from GroverDivisor import findDivisors
for i in range(10):
    print(findDivisors.simulate(num = 4, n = 3))