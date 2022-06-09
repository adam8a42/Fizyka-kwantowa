namespace HostPython {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation SayHello(name : String) : Unit {
        Message($"\nHello, {name}!");
    }

    function Plus(x : Int, y : Int) : Unit {
    Message($"\nSum is equal to: {x + y}");
    }

    operation randomBit() : Result
    {
        use q = Qubit();
        H(q);
        return M(q);
    }

    operation Qrng(n : Int) : Unit
    {
        mutable number = [];
        mutable range = [];

        use q = Qubit();
        X(q);
        for i in 1..n
        {
            set range += [M(q)];
        }
        Reset(q);

        for i in 1..n
        {
            set number += [randomBit()];
        }
        Message($"\nAt range [0,{ResultArrayAsInt(range)}] random number generated: {ResultArrayAsInt(number)}");
    }
}
