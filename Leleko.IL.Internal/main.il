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
		
		// Копировать {byteCount} byte из {source} в {destination} в различных вариациях
		// C#: public static Copy(void*,void*,int)
		.method public hidebysig static void Copy(void* destination, void* source, int32 byteCount)
		{
			.maxstack 3
			ldarg.0	// помещаем в стек указатель на область-назначения
            ldarg.1 // помещаем в стек указатель на копируемую область
            ldarg.2 // помещаем в стек число копируемых байт
            cpblk	// копируем
            ret		// выходим из функции
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
		.method public hidebysig static void Copy<Tx,Ty>(!!Tx& destination, !!Ty& source, int32 byteCount)
		{
			.maxstack 3
			ldarg.0	// помещаем в стек указатель на область-назначения
            ldarg.1 // помещаем в стек указатель на копируемую область
            ldarg.2 // помещаем в стек число копируемых байт
            cpblk	// копируем
            ret		// выходим из функции
		}
	}
	
	// Класс для математических операций с произвольными примитивами
	// C#: public static class Memory
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
		
		// Вычитание чисел примитивного типа
		// C#: x-y
		.method public hidebysig static !!T Sub<T>(!!T x, !!T y)
		{
			.maxstack 2 
			ldarg.0 // помещаем 1й параметр в стек
			ldarg.1 // помещаем 2й параметр в стек
			sub 	// складываем 2 значения
			ret		// возвращаем результат
		}
		
		// умножение чисел примитивного типа
		// C#: x*y
		.method public hidebysig static !!T Mul<T>(!!T x, !!T y)
		{
			.maxstack 2 
			ldarg.0 // помещаем 1й параметр в стек
			ldarg.1 // помещаем 2й параметр в стек
			mul 	// складываем 2 значения
			ret		// возвращаем результат
		}
		
		// Вычитание чисел примитивного типа
		// C#: x/y
		.method public hidebysig static !!T Div<T>(!!T x, !!T y)
		{
			.maxstack 2 
			ldarg.0 // помещаем 1й параметр в стек
			ldarg.1 // помещаем 2й параметр в стек
			div 	// складываем 2 значения
			ret		// возвращаем результат
		}
	}
}
