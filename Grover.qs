namespace Grover
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;

    operation groverDiffusionOperator(q : Qubit[]) : Unit
    {

        ApplyToEach(H, q);
        ApplyToEach(X,q);
        Controlled Z(Most(q), Tail(q)); //Tail - last element, most - opposite
        ApplyToEach(X,q);
        ApplyToEach(H, q);
    }
    operation groverSearch(q : Qubit[], n : Int) : Unit
    {
        ApplyToEach(H, q);
        for _ in 1 .. n
        {
            sudokuOracle(q);
            groverDiffusionOperator(q);
        }
    }
    operation runSudokuSearch(n: Int) : Result[]
    {
        use q = Qubit[4];
        groverSearch(q, n);

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
    operation sudokuOracle(q : Qubit[]) : Unit
    {
        use cases = Qubit[4];
        CNOT(q[0],cases[0]);
        CNOT(q[1],cases[0]);

        CNOT(q[0],cases[1]);
        CNOT(q[2],cases[1]);

        CNOT(q[3],cases[2]);
        CNOT(q[1],cases[2]);

        CNOT(q[3],cases[3]);
        CNOT(q[2],cases[3]);
        use output = Qubit();
        Controlled X(cases, output);
        for qubit in q
        {
            CNOT(output,qubit);
        }
        ResetAll(cases);
        Message($"{M(output)}");
        Reset(output);
    }
    operation TestSudokuOracle():Result[]
    {
        use q = Qubit[4];
        X(q[0]);
        X(q[3]);
        sudokuOracle(q);
        mutable output = [];
        for i in q
        {
            set output += [M(i)];
        }
        return output;
    }
    operation testOracle(q: Qubit[]) : Unit
    {
        Controlled Z([q[0]],q[1]);
    }
}