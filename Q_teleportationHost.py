import qsharp
from Q_Teleportation import Teleportation
from Q_Teleportation import Main
# here we type the message we wish to send (1/true or 0/false)
print(Teleportation.simulate(sentMessage = 1))
# here we can set the number of attempts that program will simulate with random messeges
print(Main.simulate(numberOfAttempts = 10000))
