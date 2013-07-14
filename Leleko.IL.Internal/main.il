.assembly Leleko.IL.Internal
{
	.ver 1:0:0:1
}
.module Leleko.IL.Internal.dll

.namespace Leleko.IL
{
	// Класс для манипуляций с памятью
	// C#: public static class Memory
	.class public auto ansi abstract sealed beforefieldinit Memory
	{		
		// Узнать размер типа (C# накладывает ряд ограничений)
		// C#: public static int Sizeof<T>()
		.method public hidebysig static int32 Sizeof<T>() cil managed
		{
			// C#: return sizeof(T)
			.maxstack 1 // размер стека
			sizeof !!T  // вычисляем размер типа T и помещаем результат в стек
			ret			// возвращаем значение с вершины стека
		}
		
		// C#: public static Copy(IntPtr,IntPtr,int)
		.method public hidebysig static void Copy(native int destination, native int source, int32 byteCount)
		{
			.maxstack 3
			ldarg.0	// помещаем в стек указатель на область-назначения
            ldarg.1 // помещаем в стек указатель на копируемую область
            ldarg.2 // помещаем в стек число копируемых байт
            cpblk	// копируем
            ret		// выходим из функции
		}
		
		// C#: public static Copy<Tx,Ty>(ref Tx,ref Ty,int)
		.method public hidebysig static void Copy<Tx,Ty>(!!Tx& destination, !!Ty& source, int32 byteCount) { .maxstack 3 ldarg.0 ldarg.1 ldarg.2 cpblk ret }
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
		// Тип претворится другим типом
		// C#: нет аналогов
		.method public hidebysig static !!T Pretend<T>(object obj){ .maxstack 1 ldarg.0 ret	}
		
		// Изменяет собственный тип на тип указанный в handleType
		// Ex: typeof(X).TypeHandle.Value
		// C#: нет аналогов
		.method public hidebysig static object ChangeType(object obj, native int handleType) cil managed { .maxstack 2 ldarg.0 ldarg.1 stind.i ldarg.0 ret }
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
			.locals init (
				[0] !!TInput&
			)
			ldarg.0
			ldarg.2
			sizeof !!TInput
			mul
			add
			stloc.0
			br.s cond
			// loop start
		for: 	ldarg.1
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
				blt.un.s for
			// end loop
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
	}
}
