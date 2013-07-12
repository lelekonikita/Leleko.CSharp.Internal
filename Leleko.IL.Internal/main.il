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
}
