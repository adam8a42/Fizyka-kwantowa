namespace Q_Teleportation {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    // this program simulates quantum communication
    // it transmites the informacion thanks to the quantum phenomena of teleportation
    
    operation Teleportation(sentMessage : Bool) : Bool {
        mutable receivedMessage = false;

        use register = Qubit[3] {
            let message = register[0]; // register = an array of Qubits

            if (sentMessage) {
                X(message); // flip the message to "true"
            }

            let sender = register[1];
            let receiever = register[2];

            // entanglement
            H(sender);
            // performs a Pauli-X gate on the target qubit when the control qubit is in state ∣1⟩
            CNOT(sender, receiever); 

            // transfers the state of the message qubit onto person_1. 
            CNOT(message, sender);
            H(message);

            // finds the Bell's state of the qubit
            let messageState = M(message);
            let senderState = M(sender);
            
            if (messageState == One) {
                Z(receiever);
            }

            if (senderState == One) {
                X(receiever);
            }

            if (M(receiever) == One) {
                set receivedMessage = true;
            }

            ResetAll(register); // restartes qubits states to make future measurements authoritative
        }

        return receivedMessage;
    }

    operation TeleportationResult(sentMessage : Bool) : Unit
    {
        Message($"\n Result of teleportation is {Teleportation(sentMessage)}.");
    }

    operation Simulator(count : Int) : (Int, Int, Int) {
        mutable trues = 0;
        mutable falses = 0;
        mutable equal = 0;
        mutable sentMessage = false;
        
        for i in 1..count {
            set sentMessage = (Random([0.5, 0.5]) == 0); // returns value 1 or 0 with the 50% probability on each

            mutable receivedMessage = Teleportation(sentMessage);

            if (receivedMessage) {
                set trues += 1;
            }
            else{
                set falses += 1;
            }

            if (receivedMessage == sentMessage) {
                set equal += 1;
            }
        }
        return (trues, falses, equal);
    }

    operation Main(numberOfAttempts : Int) : Unit {
        let (trues, falses, equal) = Simulator(numberOfAttempts);
        Display(trues, falses, equal);
    }

    operation Display(trues : Int, falses : Int, equal : Int) : Unit
    {
        if(equal < 10)
        {
            Message($"\n-------------------------------------");
            Message($"| Number of simulations         | {equal} |");
            Message($"-------------------------------------");
            Message($"| Number of false messages sent | {falses} |");
            Message($"-------------------------------------");
            Message($"| Number of trues messages sent | {trues} |");
            Message($"-------------------------------------\n");
        }
        if(10 <= equal && equal < 100)
        {
            Message($"\n--------------------------------------");
            Message($"| Number of simulations         | {equal} |");
            Message($"--------------------------------------");
            Message($"| Number of false messages sent | {falses}  |");
            Message($"--------------------------------------");
            Message($"| Number of trues messages sent | {trues}  |");
            Message($"--------------------------------------\n");
        }
        if(100 <= equal && equal < 1000)
        {
            Message($"\n---------------------------------------");
            Message($"| Number of simulations         | {equal} |");
            Message($"---------------------------------------");
            Message($"| Number of false messages sent | {falses}  |");
            Message($"---------------------------------------");
            Message($"| Number of trues messages sent | {trues}  |");
            Message($"---------------------------------------\n");
        }
        if(1000 <= equal && equal < 10000)
        {
            Message($"\n----------------------------------------");
            Message($"| Number of simulations         | {equal} |");
            Message($"----------------------------------------");
            Message($"| Number of false messages sent | {falses}  |");
            Message($"----------------------------------------");
            Message($"| Number of trues messages sent | {trues}  |");
            Message($"----------------------------------------\n");
        }
        if(10000 <= equal && equal < 100000)
        {
            Message($"\n-----------------------------------------");
            Message($"| Number of simulations         | {equal} |");
            Message($"-----------------------------------------");
            Message($"| Number of false messages sent | {falses}  |");
            Message($"---------------------------------------");
            Message($"| Number of trues messages sent | {trues}  |");
            Message($"-----------------------------------------\n");
        }
    }
}
