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
    
    operation runSudokuSearch(n: Int) : Result[]
    {
        Message($"");
        use q = Qubit[4];
        groverSearch(q, n);

        mutable output = [];
        for i in q
        {
            set output += [M(i)];
        }

        Message($"Sudoku result");
        return output;
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

    operation sudokuOracle(q : Qubit[]) : Unit
    {
        use cases = Qubit[4];
        CNOT(q[0],cases[0]); //XOR gate
        CNOT(q[1],cases[0]);

        CNOT(q[0],cases[1]);
        CNOT(q[2],cases[1]);

        CNOT(q[3],cases[2]);
        CNOT(q[1],cases[2]);

        CNOT(q[3],cases[3]);
        CNOT(q[2],cases[3]);

        use output = Qubit();
        X(output);
        H(output);
        Controlled X(cases, output);
        X(output);
        H(output);
        Reset(output);
        ResetAll(cases);
    }

    operation groverDiffusionOperator(q : Qubit[]) : Unit
    {
        ApplyToEach(H, q);
        ApplyToEach(X,q);
        Controlled Z(Most(q), Tail(q)); //Tail - last element, most - opposite
        ApplyToEach(X,q);
        ApplyToEach(H, q);
    }
////////////////////////////////////////////// tests
    operation TestSudokuOracle():Result[]
    {
        use q = Qubit[4];
        sudokuOracle(q);
        mutable output = [];
        for i in q
        {
            set output += [M(i)];
        }
        return output;
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
