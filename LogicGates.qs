namespace LogicGates
{

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation TestEntanglement() : (Int, Int, Int, Int)
    {
        mutable t1 = 0;
        mutable t2 = 0;
        mutable f1 = 0;
        mutable f2 = 0;

        for i in 1..1000
        {
            use (q1,q2) = (Qubit(), Qubit());
            H(q1);
            CNOT(q1,q2);
            if(M(q2)==One)
            {
               set t2 = t2 + 1;
            }
            if(M(q2)==Zero)
            {
               set f2 = f2 + 1;
            }
            if(M(q1)==One)
            {
               set t1 = t1 + 1;
            }
            if(M(q1)==Zero)
            {
               set f1 = f1 + 1;
            }
        }
        return (t1,f1,t2,f2);
    }
   operation Deutsch_Jozsa(n : Int, type : Int) : Result
   {
      use q = Qubit[n];
      use q2 = Qubit();
      X(q2);
      for i in q
      {
         H(i);
      }
      H(q2);
      f(n,q,q2,type);
      for i in q
      {
         H(i);
      }
      H(q2);
      //mutable measurements = 0;
      //for i in 1..n
      //{
      //   set measurements += [M(q[i])];
      //}
      mutable array = [];
      for i in q
      {
         set array += [PauliZ];
      }
      let result = Measure(array,q);
      ResetAll(q);
      Reset(q2);
      return result;
   }
   operation f(n : Int, q : Qubit[], q2 : Qubit, type : Int) : Unit
   {
      if type == 0
      {
         I(q2);
      }
      if type == 1
      {
         X(q2);
      }
      else
      {
         for i in q
         {
            CNOT(i,q2);
         }
      }
   }
}
