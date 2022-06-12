namespace GroverDivisor
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
    operation MarkDivisor(dividend :Int, divisor: Qubit[], target : Qubit) : Unit is Adj + Ctl
    {
        let size = BitSizeI(dividend);
        use dividendQ = Qubit[size]; //registers for dividend and reults
        use resultQ = Qubit[size];
        let dividendEndian = LittleEndian(dividendQ);
        let divisorEndian = LittleEndian(divisor);
        let result = LittleEndian(resultQ);
        within
        {
            ApplyXorInPlace(dividend, dividendEndian); // encoding in register
            DivideI(dividendEndian, divisorEndian, result); 
            ApplyToEachA(X, dividendEndian!); //dividend is now the remainder
        }
        apply
         {
            Controlled X(dividendEndian!, target);
            //target flips if remainder is 0
         }
    }
    operation ApplyMarkingOracleAsPhaseOracle(markingOracle : (Qubit[], Qubit) => Unit is Adj,q : Qubit[]) : Unit is Adj
    {
        use target = Qubit();
        within {
            X(target);
            H(target);
        } apply {
            markingOracle(q, target);
        }
    }
    operation findDivisors(num: Int, n: Int) : Int
    {
        let markingOracle = MarkDivisor(num, _, _);
        let phaseOracle = ApplyMarkingOracleAsPhaseOracle(markingOracle, _);
        let size = BitSizeI(num);
        use q = Qubit[size];
        use output = Qubit();
        groverSearch(n,q,phaseOracle);
        let res = MultiM(q);
        let answer = BoolArrayAsInt(ResultArrayAsBoolArray(res));
        return answer;
    }
     operation groverSearch(n: Int, q:Qubit[], phaseOracle : ((Qubit[]) => Unit is Adj)) : Unit
    {
        ApplyToEach(H, q);
        for _ in 1 .. n
        {
            phaseOracle(q);
            groverDiffusionOperator(q);
        }
   
    }
}
