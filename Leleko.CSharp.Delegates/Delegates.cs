using System;

namespace Leleko.CSharp.Delegates
{
	public delegate void RefBuffer<T>(ref T @first, int count);

	public delegate Tresult BinaryOperation<Tresult,Tx>(Tx x);

	public delegate Tresult Operation<Tresult, Tx,Ty>(Tx x, Ty y);

}

