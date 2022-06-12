namespace Grover
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Preparation;
    
    operation groverDiffusionOperator(q : Qubit[]) : Unit
    {
        ApplyToEach(H, q);
        ApplyToEach(X,q);
        Controlled Z(Most(q), Tail(q)); //Tail - last element, most - opposite
        ApplyToEach(X,q);
        ApplyToEach(H, q);
    }
    
    operation runTestSearch(n: Int) : Result[]
    {
        use q = Qubit[2];
        groverSearchTest(q, n);

        mutable output = [];
        for i in q
        {
            set output += [M(i)];
        }
        return output;
    }

    operation groverSearchTest(q : Qubit[], n : Int) : Unit
    {
        ApplyToEach(H, q);
        for _ in 1 .. n
        {
            testOracle(q);
            groverDiffusionOperator(q);
        }
    }

    operation testOracle(q: Qubit[]) : Unit
    {
        Controlled Z([q[0]],q[1]);
    }
}
