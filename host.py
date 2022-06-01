import qsharp
from HostPython import SayHello

print(SayHello.simulate(name="quantum world"))

from HostPython import Plus

print(Plus.simulate(x=3, y=5))
from HostPython import Qrng

print(Qrng.simulate(n=10))