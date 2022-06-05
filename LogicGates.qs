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
   operation Deutsch_Jozsa(n : Int, type : Int) : Result[]
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
      mutable array = [];
      for i in q
      {
         set array += [M(i)];
      }
      ResetAll(q);
      Reset(q2);
      return array;
   }
   operation f(n : Int, q : Qubit[], q2 : Qubit, type : Int) : Unit
   {
      if type == 0
      {
         X(q2);
      }
      elif type == 1
      {
         I(q2);
      }
      else
      {
         for i in q
         {
            CNOT(i,q2);
         }
      }
   }
   operation Deutsch(type : Int) : Result
   {
      use q1 = Qubit();
      use q2 = Qubit();
      X(q2);
      H(q1);
      H(q2);
      func(q1,q2,type);
      H(q1);
      H(q2);
      Reset(q2);
      return M(q1);
   }
   operation func(q1:Qubit, q2:Qubit,type : Int) : Unit
   {
      if type==0
      {
         I(q2);
      }
      elif type==1
      {
         X(q2);
      }
      else 
      {
         CNOT(q1,q2);
      }
   }
   operation funcTest(type : Int) : (Result,Result)
   {
      use (q1,q2) = (Qubit(),Qubit());
      X(q2);
      I(q1);

      if type==0
      {
         X(q2);
      }
      elif type==1
      {
         I(q2);
      }
      else 
      {
         CNOT(q1,q2);
      }
      return (M(q2),M(q1));
   }
}
