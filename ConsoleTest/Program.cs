using System;

using Leleko.IL;

namespace ConsoleTest
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			//MemoryTest.Entry(); //

			Func<int, int, int> F = (x, y) => { Console.WriteLine("{0}:{1}", x, y); return x + y; };

			//Console.WriteLine("{0} : {1}", F.Method.MethodHandle.Value, F.Method.MethodHandle.GetFunctionPointer());
			//Console.WriteLine(Alg.Accumulate(ref arr[1], 3,F.Method.MethodHandle.GetFunctionPointer()));
			//Console.WriteLine(Alg.CallN(2, 3, F.Method.MethodHandle.GetFunctionPointer()));
		}
	}
}
