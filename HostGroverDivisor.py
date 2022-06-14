import qsharp
import matplotlib.pyplot as plt
import numpy as np
qsharp.packages.add("Microsoft.Quantum.Numerics")
qsharp.reload()
# π/4 * sqrt(N/n_solutions)
N = int(np.ceil(np.pi/4 * np.sqrt(16/4)))
from GroverDivisor import findDivisors
x = []
print(N)
for i in range(50):
    var = findDivisors.simulate(num = 12, n = N)
    x.append(var)
    print(var)
fig, ax = plt.subplots( figsize= (5,6))
plt.bar(*np.unique(x, return_counts=True))
plt.show()