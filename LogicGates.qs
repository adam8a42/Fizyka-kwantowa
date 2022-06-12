namespace LogicGates
{

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation TestEntanglement(n : Int) : Unit
    {
        mutable t1 = 0; // true values of q1
        mutable t2 = 0; // true values of q2
        mutable f1 = 0; // false values of q1
        mutable f2 = 0; // false values of q2

        for i in 1..n
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

         Display(t1, t2, f1, f2);
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
       
      DisplayArray(array, n);

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

   operation Deutsch(type : Int) : Unit
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

      Message($"\nResult of the simulation: {M(q1)}");
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

   operation Display(t1 : Int, t2 : Int, f1 : Int, f2 : Int) : Unit
   {
      let x = t1 + f1;

      if(x == 10)
      {
         Message($"\n.------------------.");
         Message($"|--------| Q1 | Q2 |");
         Message($"|------------------|");
         Message($"| trues  | {t1}  | {t2}  |");
         Message($"|------------------|");
         Message($"| falses | {f1}  | {f2}  |");
         Message($".------------------.\n");
      }
      elif(x == 100)
      {
         Message($"\n.------------------.");
         Message($"|--------| Q1 | Q2 |");
         Message($"|------------------|");
         Message($"| trues  | {t1} | {t2} |");
         Message($"|------------------|");
         Message($"| falses | {f1} | {f2} |");
         Message($".------------------.\n");
      }
      elif(x == 1000)
      {
         Message($"\n.----------------------.");
         Message($"|--------|  Q1  |  Q2  |");
         Message($"|----------------------|");
         Message($"| trues  | {t1}  | {t2}  |");
         Message($"|----------------------|");
         Message($"| falses | {f1}  | {f2}  |");
         Message($".----------------------.\n");
      }
      elif(x ==10000)
      {
         Message($"\n.----------------------.");
         Message($"|--------|  Q1  |  Q2  |");
         Message($"|----------------------|");
         Message($"| trues  | {t1} | {t2} |");
         Message($"|----------------------|");
         Message($"| falses | {f1} | {f2} |");
         Message($".----------------------.\n");
      }
   }

   operation DisplayArray(array : Result[], n : Int) : Unit
   {
      if(array[0] == One)
      {
         Message($"\nArray of {array[0]}s with {n} spots:");
      }
      else
      {
          Message($"\nArray of {array[0]}es with {n} spots:");
      }
   }
}
