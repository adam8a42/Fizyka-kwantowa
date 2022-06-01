namespace HostPython {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation SayHello(name : String) : Unit {
        Message($"Hello, {name}!");
    }

    function Plus(x : Int, y : Int) : Int {
    return x + y;
    }
    operation randomBit() : Result
    {
        use q = Qubit();
        H(q);
        return M(q);
    }

    operation Qrng(n : Int) : Int
    {
        mutable number = [];
        mutable output = 0;
        for i in 1..n
        {
            set number += [randomBit()];
        }
        set output = ResultArrayAsInt(number);
        return output;
    }
}


