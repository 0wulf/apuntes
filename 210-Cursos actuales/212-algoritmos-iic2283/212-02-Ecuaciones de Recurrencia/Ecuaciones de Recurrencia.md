```
Fib(n):
	if n<=1 then
		return n
	else
		return Fib(n-1)+Fib(n-2)
	end
```
El tiempo de ejecución de `Fib(n)` puede expresarse como la **ecuación de recurrencia**:
![[Pasted image 20230816150051.png]]
para constantes $a,b\in\mathbb{N}$ con $a>0, b>0$

A pesar de que $T(n)$ puede definirse de forma simple y directa desde el algoritmo, no sabemos mucho respecto de la función que representa.
Nos gustaría encontrar la **forma cerrada** de $T$ para poder estudiarla
Para el caso de $Fib(n)$, ¿cuál es la función que acota a $T(n)$?
# [[Demostración Tiempo Fibonacci]]
# [[Búsqueda Binaria]]
# [[Solucionando una ecuación de recurrencia por inducción constructiva e inducción fuerte]]
# [[Un segundo ejemplo de inducción constructiva - inducción constructiva sobre una propiedad más fuerte]]
# [[El Teorema Maestro]]