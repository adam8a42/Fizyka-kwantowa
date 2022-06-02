namespace Q_Teleportation {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation Teleportation(sentMessage : Bool) : Bool {
        mutable receivedMessage = false;

        use register = Qubit[3] {
            let message = register[0];

            if (sentMessage) {
                X(message); // flip the message to "true"
            }

            let person_1 = register[1];
            let person_2 = register[2];

            // entanglement
            H(person_1);
            CNOT(person_1, person_2);

            // teleportation: this order CNOT->H transfer the state of the message QuBit onto person_1. 
            CNOT(message, person_1);
            H(message);

            // Find the bell state was used
            let messageState = M(message);
            let person_1_state = M(person_1);
            
            if (messageState == One) {
                Z(person_2);
            }

            if (person_1_state == One) {
                X(person_2);
            }

            if (M(person_2) == One) {
                set receivedMessage = true;
            }

            ResetAll(register);
        }


        return receivedMessage;
    }

    operation QuantumSimulator(count : Int) : (Int, Int) {
        mutable trues = 0;
        mutable equal = 0;
        mutable sentMessage = false;
        
        for indx in 1..count {
            set sentMessage = (Random([0.5, 0.5]) == 0);

            mutable receivedMessage = Teleportation(sentMessage);

            if (receivedMessage) {
                set trues += 1;
            }

            if (receivedMessage == sentMessage) {
                set equal += 1;
            }
        }
        return (trues, equal);
    }

    @EntryPoint()
    operation Driver_Code() : Unit {
        let (trues, equal) = QuantumSimulator(1000);
        let falses = 1000-trues;
        Message($"Teleportation result: ");
        Message($"   One: {trues}");
        Message($"   Zero: {falses}");
        Message($"   Equal: {equal}");
    }
}