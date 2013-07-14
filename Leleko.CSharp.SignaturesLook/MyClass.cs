using System;

/*
 * Проект создан для просмотра дампов и сигнатур
 * */
using System.Runtime.InteropServices;

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

		public static double Sum(double* first, int count)
		{
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
			*x = 2.222;
		}

		public static void ConverAll(myStruct* inputFirst, myStruct* outputFirst, int count, Converter<myStruct,myStruct> converter)
		{
			for(var end = inputFirst + count; inputFirst < end; *(outputFirst++)=converter(*(inputFirst++)));
		}
	}
}

