using System;

namespace Leleko.CSharp.Delegates
{
	public delegate Tresult Operation<Tx,Ty,Tresult>(Tx x, Ty y);

	public delegate Tresult Operation<Tx,Ty,Tz,Tresult>(Tx x, Ty y, Tz z);

}

