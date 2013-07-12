using System;
using Leleko.IL;

namespace ConsoleTest
{
	public static class MemoryTest
	{
		public static void Entry()
		{
			// копирование строки матрицы с помощью Memory.Copy
			double[,] x = new double[,] { {1,2},{3,4},{5,6} };
			double[,] y = new double[3,2];
			Console.WriteLine("y[1,*] = ({0},{1})", y[1,0], y[1,1]); // (0,0)
			Memory.Copy(ref y[1,0], ref x[2,0], sizeof(double)*2); // копируем 3ю строку матрицы в 2ю строку матрицы y
			Console.WriteLine("y[1,*] = ({0},{1})", y[1,0], y[1,1]); // (5,6)
		}
	}
}

