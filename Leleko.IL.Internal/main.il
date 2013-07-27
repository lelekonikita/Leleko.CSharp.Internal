.assembly Leleko.IL.Internal
{
	.ver 1:0:3:0001
}
.module Leleko.IL.Internal.dll

.namespace Leleko.IL
{
	// Класс для манипуляций с памятью
	// C#: public static class Memory
	.class public auto ansi abstract sealed beforefieldinit Memory
	{
		.class public auto ansi abstract sealed beforefieldinit Type
		{	
			.method public hidebysig static int32 Sizeof<T>() cil managed { .maxstack 1 sizeof !!T ret }
			
			.method public hidebysig static valuetype [mscorlib]System.RuntimeTypeHandle RuntimeTypeHandle<T>() cil managed { .maxstack 1 ldtoken !!T ret }
			
			.method public hidebysig static native int TypeHandle<T>() cil managed { .maxstack 1 .locals init ( [0] valuetype [mscorlib]System.RuntimeTypeHandle ) ldtoken !!T stloc.0 ldloca.s 0 call instance native int [mscorlib]System.RuntimeTypeHandle::get_Value() ret }
		}
			
		// C#: public static Copy(IntPtr,IntPtr,int)
		.method public hidebysig static void Copy(native int destination, native int source, int32 byteCount) { .maxstack 3 ldarg.0 ldarg.1 ldarg.2 cpblk ret }
		
		// C#: public static Copy<Tx,Ty>(ref Tx,ref Ty,int)
		.method public hidebysig static void Copy<Tx,Ty>(!!Tx& destination, !!Ty& source, int32 byteCount) { .maxstack 3 ldarg.0 ldarg.1 ldarg.2 cpblk ret }
		
		// Получение 'внутреннего поля' из объекта
		.method public hidebysig static !!T GetIternal<T>(object @object, int32 offset) { .maxstack 2 ldarg.0 ldarg.1 add ldobj !!T ret }
		
		// Получение 'внутреннего поля' из объекта
		.method public hidebysig static void SetIternal<T>(object @object, int32 offset, !!T @value) { .maxstack 2 ldarg.0 ldarg.1 add ldarg.2 stobj !!T ret }

		// Преобразование фрагмента потока к типу
		.method public hidebysig static !!TValue Get<TStream,TValue>(!!TStream& @stream) { .maxstack 2 ldarg.0 ldobj !!TValue ret }
		
		// Помещение значения в поток
		.method public hidebysig static void Set<TStream,TValue>(!!TStream& @stream, !!TValue @value ) { .maxstack 2 ldarg.0 ldarg.1 stobj !!TValue ret }
		
		// Получение типизированного указателя на фрагмент потока
		.method public hidebysig static !!TValue* GetPointer<TStream,TValue>(!!TStream& @stream) { .maxstack 1 ldarg.0 ret }
		
		.class public auto ansi abstract sealed beforefieldinit Convert
		{
			.method public hidebysig static !!TOut As<TIn,TOut>(!!TIn obj) { .maxstack 1 ldarg.0 ret }
			
			.method public hidebysig static !!TOut As<TOut>(native int pointer) { .maxstack 1 ldarg.0 ret }
			
			.method public hidebysig static !!TOut As<TOut>(void* pointer) { .maxstack 1 ldarg.0 ret }
			
			.method public hidebysig static !!TOut As<TIn, TOut>(!!TIn& pointer) { .maxstack 1 ldarg.0 ret }
			
			.method public hidebysig static object ChangeType(object obj, native int handleType) cil managed { .maxstack 2 ldarg.0 ldarg.1 stind.i ldarg.0 ret }
		}
		
		.class public auto ansi abstract sealed beforefieldinit String
		{
			// Установить новую длину строки (настоятельно не рекомендуется устанавливать больше текущей
			.method public hidebysig static void SetLength(string s, int32 newLength) { .maxstack 2 ldarg.0 sizeof native int add ldarg.1 stind.i4 ret }
			
			// Задать символ на нужной позиции
			.method public hidebysig static void SetSymbol(string s, int32 index, char symbol) { .maxstack 3 ldarg.0 sizeof native int add ldc.i4.4 add ldarg.1 ldc.i4.2 mul add ldarg.2 stind.i2 ret }
			
			// Копирует символы из ссылки в буфферную строку
			.method public hidebysig static void Bfs(string s, char& @stream, int32 count) 
			{ 
				.locals init( [0] char&, [1] int32 )
				.maxstack 4
				ldarg.0 
				sizeof native int 
				add 
				dup 
				ldarg.2 
				stind.i4
				ldc.i4.4
				add
				dup
				stloc.0
				ldarg.1
				ldarg.2
				ldc.i4.2
				mul
				dup 
				stloc.1
				cpblk
				ldloc.0
				ldloc.1
				add
				ldc.i4.0
				stind.i2
				ret
			}
			
			// Копирует символы из ссылки в буфферную строку
			.method public hidebysig static void Bfs(string s, string source, int32 index, int32 count) 
			{ 
				.maxstack 4
				ldarg.0
				ldarg.1
				sizeof native int 
				add
				ldc.i4.4
				add
				ldarg.2
				ldc.i4.2
				mul
				add
				ldarg.3
				call void Leleko.IL.Memory/String::Bfs(string,char&,int32)
				ret
			}
		}
	}
	
	
	
	// Класс для математических операций с произвольными примитивами
	// C#: public static class MathOperation
	.class public auto ansi abstract sealed beforefieldinit MathOperation
	{
		// Сложение 2х чисел примитивного типа
		// С#: x + y
		.method public hidebysig static !!T Add<T>(!!T x, !!T y)
		{
			.maxstack 2 
			ldarg.0 // помещаем 1й параметр в стек
			ldarg.1 // помещаем 2й параметр в стек
			add 	// складываем 2 значения
			ret		// возвращаем результат
		}
		.method public hidebysig static !!T Sub<T>(!!T x, !!T y) { .maxstack 2 ldarg.0 ldarg.1 sub ret }
		.method public hidebysig static !!T Mul<T>(!!T x, !!T y) { .maxstack 2 ldarg.0 ldarg.1 mul ret }
		.method public hidebysig static !!T Div<T>(!!T x, !!T y) { .maxstack 2 ldarg.0 ldarg.1 div ret }
		.method public hidebysig static !!T Neg<T>(!!T x) { .maxstack 1 ldarg.0 neg ret }
	}
	
	// Класс для приведения типов
	// C#: public static class Converter
	.class public auto ansi abstract sealed beforefieldinit Converter
	{
		
		
		.method public hidebysig static bool ToBoolean<T>(!!T @value) cil managed { .maxstack 2 ldarg.0 conv.r8 ldc.r8 0.0 ceq ldc.i4.0 ceq ret }
		.method public hidebysig static uint8 ToByte<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.ovf.u1 ret }
		.method public hidebysig static int8 ToSByte<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.ovf.i1 ret }
		.method public hidebysig static char ToChar<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.ovf.u2 ret }
		.method public hidebysig static uint16 ToUInt16<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.ovf.u2 ret }
		.method public hidebysig static int16 ToInt16<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.ovf.i2 ret }
		.method public hidebysig static uint32 ToUInt32<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.ovf.u4 ret }
		.method public hidebysig static int32 ToInt32<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.ovf.i4 ret }
		.method public hidebysig static uint64 ToUInt64<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.ovf.u8 ret }
		.method public hidebysig static int64 ToInt64<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.ovf.i8 ret }
		.method public hidebysig static float32 ToSingle<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.r4 ret }
		.method public hidebysig static float64 ToDouble<T>(!!T @value) cil managed { .maxstack 1 ldarg.0 conv.r8 ret }
		
		.method public hidebysig static void CovertAll<TInput,TOutput>(!!TInput& inputFirst, !!TOutput& outputFirst, int32 count, class [mscorlib]System.Converter`2<!!TInput, !!TOutput> converter)
		{
			.maxstack 5
			.locals init ( [0] !!TInput& )
			ldarg.0
			ldarg.2
			sizeof !!TInput
			mul
			add
			stloc.0
			br.s cond
		for: 	ldarg.1 // loop start
				dup
				sizeof !!TOutput
				add
				starg.s outputFirst
				ldarg.3
				ldarg.0
				dup
				sizeof !!TInput
				add
				starg.s inputFirst
				ldobj !!TInput
				callvirt instance !1 class [mscorlib]System.Converter`2<!!TInput, !!TOutput>::Invoke(!0)
				stobj !!TOutput
		cond:	ldarg.0
				ldloc.0
				blt.un.s for // end loop
			ret
		}
	}
	
	// Класс для приведения типов
	// C#: public static class Converter
	.class public auto ansi abstract sealed beforefieldinit Comparer
	{
		.method public hidebysig static bool IsNull<T>(!!T @value) cil managed { .maxstack 2 ldarg.0 conv.r8 ldc.r8 0.0 ceq ret }
		.method public hidebysig static bool IsOne<T>(!!T @value) cil managed { .maxstack 2 ldarg.0 conv.r8 ldc.r8 1.0 ceq ret }
		.method public hidebysig static bool Equals<T>(!!T @valueA, !!T @valueB) cil managed { .maxstack 2 ldarg.0 ldarg.1 ceq ret }
	}
	
	.class public auto ansi abstract sealed beforefieldinit Sequence
	{
		.method public hidebysig static bool All<T>(!!T& first, int32 count, class [mscorlib]System.Predicate`1<!!T> predicate) cil managed 
		{
			.maxstack 4
			.locals init (
				[0] !!T&
			)
			ldarg.0
			ldarg.1
			sizeof !!T
			mul
			add
			stloc.0
			br.s cond
			// loop start (head: IL_002d)
		for:	ldarg.2
				ldarg.0
				dup
				sizeof !!T
				add
				starg.s first
				ldobj !!T
				callvirt instance bool class [mscorlib]System.Predicate`1<!!T>::Invoke(!0)
				brfalse.s no
		cond: 	ldarg.0
				ldloc.0
				blt.un for
			// end loop
			ldc.i4.1
			ret
		no:	ldc.i4.0
			ret
		} // end of method MyClass::All
		
		.method public hidebysig static bool Any<T>(!!T& first, int32 count, class [mscorlib]System.Predicate`1<!!T> predicate) cil managed 
		{
			.maxstack 4
			.locals init (
				[0] !!T&
			)
			ldarg.0
			ldarg.1
			sizeof !!T
			mul
			add
			stloc.0
			br.s cond
			// loop start (head: IL_002d)
		for:	ldarg.2
				ldarg.0
				dup
				sizeof !!T
				add
				starg.s first
				ldobj !!T
				callvirt instance bool class [mscorlib]System.Predicate`1<!!T>::Invoke(!0)
				brtrue.s yes
		cond: 	ldarg.0
				ldloc.0
				blt.un for
			// end loop
			ldc.i4.0
			ret
		yes:ldc.i4.1
			ret
		} // end of method MyClass::All
		
		.method public hidebysig static bool SequenceAll<Tx,Ty>(!!Tx& xArrFirst, !!Ty& yArrFirst, int32 count, class [mscorlib]System.Delegate @delegate) cil managed 
		{
			.maxstack 5
			.locals init (
				[0] !!Tx&
			)
			ldarg.0
			ldarg.2
			sizeof !!Tx
			mul
			add
			stloc.0
			br.s cond
			// loop start (head: IL_002d)
		for:	ldarg.3
				ldarg.0
				dup
				sizeof !!Tx
				add
				starg.s xArrFirst
				ldobj !!Tx
				ldarg.1
				dup
				sizeof !!Ty
				add
				starg.s yArrFirst
				ldobj !!Ty
				callvirt instance !2 class [Leleko.CSharp.Delegates]Leleko.CSharp.Delegates.Operation`3<!!Tx, !!Ty, bool>::Invoke(!0, !1)
				brfalse.s no
		cond: 	ldarg.0
				ldloc.0
				blt.un for
			// end loop
			ldc.i4.1
			ret
		no:	ldc.i4.0
			ret
		} // end of method MyClass::All
		
		.method public hidebysig static bool EqualsAll<T>(!!T& xArrFirst, !!T& yArrFirst, int32 count) cil managed 
		{
			.maxstack 3
			.locals init (
				[0] !!T&
			)
			ldarg.0
			ldarg.2
			sizeof !!T
			mul
			add
			stloc.0
			br.s cond
			// loop start (head: IL_002d)
		for:	ldarg.0
				dup
				sizeof !!T
				add
				starg.s xArrFirst
				ldobj !!T
				ldarg.1
				dup
				sizeof !!T
				add
				starg.s yArrFirst
				ldobj !!T
				ceq
				brfalse.s no
		cond: 	ldarg.0
				ldloc.0
				blt.un for
			// end loop
			ldc.i4.1
			ret
		no:	ldc.i4.0
			ret
		} // end of method MyClass::All
	}
	
	.class public auto ansi abstract sealed beforefieldinit Algorithm
	{
		// Суммирование диапазона значений
		// С#: public static double Sum<T>(ref T first, int count)
		.method public hidebysig static float64 Sum<T>(!!T& first, int32 count) cil managed
		{
			/*	
			double result = 0;
			for(var end = first + count; first < end; result += *(first++));
			return result;
			*/
			.maxstack 4
			.locals init (
				[0] float64,
				[1] !!T&
			)
			ldc.r8 0.0
			stloc.0
			ldarg.0
			ldarg.1
			sizeof !!T
			mul
			add
			stloc.1
			br.s cond
			// loop start
		for: 	ldloc.0
				ldarg.0
				dup
				sizeof !!T
				add
				starg.s first
				ldobj !!T
				conv.r8
				add
				stloc.0
		cond:	ldarg.0
				ldloc.1
				blt.un.s for
			// end loop
			ldloc.0
			ret
		}
		
		// Перемножение диапазона значений
		// С#: public static double Mul<T>(ref T first, int count)
		.method public hidebysig static float64 Mul<T>(!!T& first, int32 count) cil managed
		{
			/*	
			double result = 0;
			for(var end = first + count; first < end; result *= *(first++));
			return result;
			*/
			.maxstack 4
			.locals init (
				[0] float64,
				[1] !!T&
			)
			ldc.r8 0.0
			stloc.0
			ldarg.0
			ldarg.1
			sizeof !!T
			mul
			add
			stloc.1
			br.s cond
			// loop start
		for: 	ldloc.0
				ldarg.0
				dup
				sizeof !!T
				add
				starg.s first
				ldobj !!T
				conv.r8
				add
				stloc.0
		cond:	ldarg.0
				ldloc.1
				blt.un.s for
			// end loop
			ldloc.0
			ret
		}
		
		// Аккумулирование диапазона значений
		// C#: public static Tresult Accumulate<T,Tresult>(Tresult emptyValue, ref T first, int32 count, IntPtr handleMethod)
		// C#: handleMethod = typeof(Funk<T,T,TResult).MethodHandle.GetFunctionPointer()
		.method public hidebysig static !!Tresult Accumulate<T,Tresult>(!!Tresult emptyValue, !!T& first, int32 count, native int handleMethod) cil managed
		{
			/*
			for(var end = first + count; first < end; emptyValue = handleMethod(emptyValue,*(first++)));
			return emptyValue;
			*/
			.maxstack 4
			.locals init ( 
				[0] !!T& 
			)
			ldarg.1
			ldarg.2
			sizeof !!T
			mul
			add
			stloc.0
			br.s cond
			// loop start
		for: 	ldarg.0
				ldarg.1
				dup
				sizeof !!T
				add
				starg.s first
				ldobj !!T
				ldarg.3
				calli !!Tresult(!!Tresult,!!T)
				starg.s emptyValue
		cond:	ldarg.1
				ldloc.0
				blt.un.s for
			// end loop
			ldarg.0
			ret
		}
		
		
		// Аккумулирование диапазона значений
		// C#: public static Tresult Accumulate<T,Tresult>(Tresult emptyValue, ref T first, int32 count, IntPtr handleMethod)
		// C#: handleMethod = typeof(Funk<T,T,TResult).MethodHandle.GetFunctionPointer()
		.method public hidebysig static !!Tresult Accumulate<T,Tresult>(!!Tresult emptyValue, !!T& first, int32 count, class [Leleko.CSharp.Delegates]Leleko.CSharp.Delegates.Operation`3<!!Tresult, !!T, !!Tresult> methodDelegate) cil managed
		{
			.maxstack 5
			.locals init ( 
				[0] !!T& 
			)
			ldarg.1
			ldarg.2
			sizeof !!T
			mul
			add
			stloc.0
			br.s cond
			// loop start
		for: 	ldarg.3
				ldarg.0
				ldarg.1
				dup
				sizeof !!T
				add
				starg.s first
				ldobj !!T
				callvirt instance !2 class [Leleko.CSharp.Delegates]Leleko.CSharp.Delegates.Operation`3<!!Tresult, !!T, !!Tresult>::Invoke(!0, !1)
				starg.s emptyValue
		cond:	ldarg.1
				ldloc.0
				blt.un.s for
			// end loop
			ldarg.0
			ret
		}

		
		.method public hidebysig static !!Tresult Accumulate<Tx,Ty,Tresult>(!!Tresult emptyValue, !!Tx& xArrFirst, !!Ty& yArrFirst, int32 count, native int handleMethod) cil managed
		{
			.maxstack 5
			.locals init ( 
				[0] !!Tx& 
			)
			ldarg.1
			ldarg.3
			sizeof !!Tx
			mul
			add
			stloc.0
			br.s cond
			// loop start
		for: 	ldarg.0
				ldarg.1
				dup
				sizeof !!Tx
				add
				starg.s xArrFirst
				ldobj !!Tx
				ldarg.2
				dup
				sizeof !!Ty
				add
				starg.s yArrFirst
				ldobj !!Ty
				ldarg.s handleMethod
				calli !!Tresult(!!Tresult,!!Tx,!!Ty)
				starg.s emptyValue
		cond:	ldarg.1
				ldloc.0
				blt.un.s for
			// end loop
			ldarg.0
			ret
		}
		
		.method public hidebysig static !!Tresult Accumulate<Tx,Ty,Tresult>(!!Tresult emptyValue, !!Tx& xArrFirst, !!Ty& yArrFirst, int32 count, class [mscorlib]System.Delegate methodDelegate) cil managed
		{
			.maxstack 6
			.locals init ( 
				[0] !!Tx& 
			)
			ldarg.1
			ldarg.3
			sizeof !!Tx
			mul
			add
			stloc.0
			br.s cond
			// loop start
		for: 	ldarg.s 4
				ldarg.0
				ldarg.1
				dup
				sizeof !!Tx
				add
				starg.s xArrFirst
				ldobj !!Tx
				ldarg.2
				dup
				sizeof !!Ty
				add
				starg.s yArrFirst
				ldobj !!Ty
				callvirt instance !3 class [Leleko.CSharp.Delegates]Leleko.CSharp.Delegates.Operation`4<!!Tresult, !!Tx, !!Ty, !!Tresult>::Invoke(!0, !1, !2)
				starg.s emptyValue
		cond:	ldarg.1
				ldloc.0
				blt.un.s for
			// end loop
			ldarg.0
			ret
		}
	}
}
