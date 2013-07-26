using System;

/*
 * Проект создан для просмотра дампов и сигнатур
 * */
using System.Runtime.InteropServices;
using System.Collections;

namespace Leleko.CSharp.SignaturesLook
{

	public struct myStruct
	{
		int x;
		int y;
	}
	unsafe public class MyClass
	{
		delegate T addDelegate<T>(T x, T y);


		public static void Get(Delegate @delegate) {}

		public static double Sum<T>(double* first, int count, ref int k, out T y, T value)
		{
			y = value;
			double result = 0;
			for(;(count--)>0; result += *(first++));

			return result;
		}

		public static T Sum<T>(T first, int count, Delegate addFunction, Converter<int,T> converter)
		{
			double* fix = stackalloc double[100];
			//double result = 0;
			//for(; count-- > 0 ; result += *(first++));
			//action(new T[1000]);
			return converter(count);
		}

		public static T Sum<T>(T first, int count, Func<T,T,T> addFunction)
		{
			//double result = 0;
			//for(; count-- > 0 ; result += *(first++));
			return addFunction(first,first);
		}


		[DllImport("TestDll.dll", EntryPoint="sum", 
		           ExactSpelling=false,CallingConvention=CallingConvention.Cdecl)]
		static extern int sum(int a,int b);

		public static void MySUM<T>(double *x)
		{
			string s = "AA";
			*x = 2.222;
		}

		public static bool Equals<T>(double x, double y, T g)
			where T:struct
		{
			double *ptr = stackalloc double[100];
			return x == y;
		}

		public static bool All(myStruct* first, int count, Predicate<myStruct> predicate)
		{
			for(var end = first + count; first < end;)
				if (!predicate(*(first)++))
					return false;
			return true;
		}

		public static bool AllEquals(myStruct* xArrFirst, myStruct* yArrFirst,  int count, Leleko.CSharp.Delegates.Operation<myStruct,myStruct,bool> operation)
		{
			for(var xArrEnd= xArrFirst + count; xArrFirst < xArrEnd;)
				if (!operation(*(xArrFirst++),*(yArrFirst++)))
					return false;
			return true;
		}
	}
}

