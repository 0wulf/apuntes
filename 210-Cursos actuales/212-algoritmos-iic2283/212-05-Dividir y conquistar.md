- La técnica de diseño de algoritmos dividir y conquistar permite resolver un problema mediante su división en **subproblemas** que **no se solapan entre si.**
- Cada subproblema es una instancia más pequeña del problema original, y es resuelta recursivamente usando el mismo algoritmo.
- Al ser más pequeños, los subproblemas son más "fáciles" de resolver.
- El proceso se repite recursivamente, dividiendo en subproblemas cada vez más pequeños, hasta que sean lo suficientemente pequeños para resolverlos de manera simple.
---
## Etapas
Un algoritmo del tipo dividir y conquistar consiste en las siguientes etapas:
- Caso base:
	- Si la instancia a resolver es suficientemente pequeña, se resuelve directamente.
- Dividir:
	- El problema original de tamaño $|w|=n$ es dividido en $l$ subproblemas $w_1,...,w_l$ de tamaños $n_1,...,n_l$, respectivamente.
- Conquistar:
	- Los subproblemas $w_1,...,w_n$ se resuelven recursivamente, obteniendo soluciones $S_1,...,S_l$.
- Combinar:
	- Las soluciones $S_1,...,S_l$ se combinan para formar la solución al problema original $w$.
---
Esta es la forma genérica de un algoritmo que utiliza la técnica de dividir para conquistar:
```
DividirParaConquistar(w):
	if |w| <= k then return InstanciasPequeñas(w)
	else
		Dividir w en w_1,...,w_l
		for i:=1 to l do
			S_i := DividirParaConquistar(w_i)
		return Combinar(S_1,...,S_l)
```
---
Ejemplos típicos de algoritmos que usan esta técnica:
- MergeSort
- QuickSort
- Busqueda Binaria
- El problema de multiplicar dos enteros
---
# Dividir y conquistar: El algoritmo de multiplicación de Karatsuba
- Denotemos con $x[n..1]$ e $y[n..1]$ a los números que queremos multiplicar, asumiendo que $n$ es una potencia de 2:
	- $x[n]$ e $y[n]$ son los dígitos más significativos.
	- $x[1]$ e $y[1]$ son los dígitos menos significativos.
- Vamos a denotar con $x_S=x[n..\frac{n}{2}+1]$ y $x_I[\frac{n}{2}..1]$ a la mitad superior $S$ e inferior $I$ de $x$, respectivamente. Hacemos lo mismo para $y$
![[Pasted image 20230911190809.png]]
---
![[Pasted image 20230911190846.png]]
```
MULT(x[n..1], y[n..1])
	if n == 1 then
		return x[1] * y[1]
	else
		// dividir
		x_I <- x[n/2..1]
	-......
	.....
```
El tiempo de ejecución es
![[Pasted image 20230911190904.png]]
$T(n)\in\Theta(n²)$

---
Karatsuba hizo un trucaso a lo Gauss:
![[Pasted image 20230911191023.png]]
Ahora calculamos tres en vez de cuatro productos
```
KARATSUBA(x[n..1], y[n..1])
	if n == 1 then
		return x[1] * y[1]
	else
		// Dividir
		x_I <- x[n/2..1], x_S <- x[n..n/2+1]
		y_I <- y[n/2..1], y_S <- y[n..n/2+1]
		// Conquistar
		p_1 <- KARATSUBA(x_S, y_S)
		p_2 <- KARATSUBA(x_I, y_I)
		p_3 <- KARATSUBA(x_S+x_I, y_S+y_I)
		// Combinar
		return 10^n * p_1 + 10^(n/2) * (p_3-p_1-p_2) + p_2
	end  
```
![[Pasted image 20230911191555.png]]
$T(n)\in\Theta(n^{\log_2{3}})$ 
![[Pasted image 20230911191655.png]]

---
# El problema de la mayoría absoluta
Pensemos en un sistema que permite realizar votaciones:
- $n$ usuarios pueden votar por una de entre $k$ opciones posibles
- Al finalizar la votación, el sistema debe informar cuál fue la opción más votada e indicar si hubo mayoría absoluta o no:
	- hay mayoría absoluta si la opción ganadora recibió al menos $\lfloor\frac{n}{2}\rfloor+1$ votos
- El problema puede plantearse abstractamente así
	- Dado un arreglo $A[1..n]$ de elemento de algún tipo (no necesariamente ordenado), determinar si existe un elemento que se repita al menos $\lfloor\frac{n}{2}\rfloor+1$ veces en $A$.
- Si las alternativas a votar están representadas por elementos de tipo entero en el rango $[1..k]$
	- Se usa un arreglo de contadores $C[1..k]$
	- Se recorre el arreglo $A$ incrementando $C[A[i]]$ por cada $i=1,...,n$
	- Finalmente, se recorre $C$ para determinar si alguna de las opciones es mayoría absoluta
- El tiempo total es $\Theta(n+k)$ mientras el espacio adicional utilizado es $\Theta(k)$
- No funciona si las alternativas a votar no son enteros en $[1..k]$
- Para objetos sobre los que existe una relación de orden total pero no necesariamente están en el rango $[1..k]$ (e.g. strings)
	- Una alternativa simple sería ordenar el arreglo $A$
	- Note que si $A$ tiene una mayoría, entonces este sería el elemento $A[n/2]$ después de ordenar
	- Si usamos `MergeSort` para ordenar $A$, el tiempo de ejecución será $\Theta(n\log(n))$ con espacio adicional usado de $\Theta(n)$
- A continuación estudiaremos una solución con espacio adicional $\Theta(\log n)$ y que solo necesita comparar con $=$
---
![[Pasted image 20231002152949.png]]
![[Pasted image 20231002153002.png]]
![[Pasted image 20231002153016.png]]
![[Pasted image 20231002153024.png]]
![[Pasted image 20231002153040.png]]
![[Pasted image 20231002153153.png]]

---
# Una aplicación en geometría computacional: *convex hull*
![[Pasted image 20231002153508.png]]
![[Pasted image 20231002153524.png]]
![[Pasted image 20231002153535.png]]
![[Pasted image 20231002153554.png]]
![[Pasted image 20231002153625.png]]
![[Pasted image 20231002153642.png]]
![[Pasted image 20231002153705.png]]
![[Pasted image 20231002153731.png]]
Esta propiedad nos permite definir el siguiente enfoque de fuerza bruta:
- por cada posible par de puntos $p_i$ y $p_j$ del conjunto, chequear que el resto de los puntos de $P$ se ubiquen en el mismo semiplano respecto a la recta infinita que pasa por $p_i$ y $p_j$
- si eso se cumple, agregar el segmento $\overline{p_ip_j}$ al *convex hull*
- aquí es necesario usar el test del determinante, visto anteriormente.
Resultado: Algoritmo de fuerza bruta de tiempo $O(n³)$
- $\sim n^2/2$ pares de puntos distintos
- por cada par de puntos, recorrer el resto de puntos chequeando que todos quedan en el mismo lado
---
## Enfoque dividir y conquistar al problema de calcular el *convex hull*
- Fundamento: obtener el *convex hull* de un conjunto de puntos pequeños es más fácil que para un conjunto de puntos mayor:
	- E.g. para un conjunto de tres puntos, es trivial calcular el *convex hull* pues es el triángulo definido por los tres puntos.
- solo necesitamos poder combinar los *convex hulls*
![[Pasted image 20231002154807.png]]
- Asumimos que los puntos han sido ordenados por coordenada $x$ creciente antes de invocar el algoritmo por primera vez
```
MergeHull(P={p_1,...,p_n})
	if |P| <= 5 then
		return ConvexHullFuerzaBruta(P)
	else
		# Dividir
		P1 <- {p_1,...,p_(n//2)}
		P2 <- {p_(n//2+1),...,p_n}
		# Conquistar
		C1 <- MergeHull(P1)
		C2 <- MergeHull(P2)
		# Combinar
		return CombinarHulls(C1, C2)
	end
end
```
- La etapa más compleja es la de combinar los convex hulls ya calculados para las mitades del conjunto de puntos
- La idea es calcular dos tangentes (una superior y otra inferior) para los dos conjuntos de puntos
- Note que `C1` y `C2` son disjuntos y separables por una línea
- Eso simplifica un poco el cálculo de tangentes
- Es siguiente algoritmo de Preparata y Hong permite encontrar estas tangentes es $O(n)$
- El algoritmo asume que `C1` y `C2` se representan usando una lista circular ordenada en sentido antihorario
- Para un vértice $p$ del convex hull, $p+1$ es el siguiente vértice en sentido antihorario, mientras que $p-1$ es el vértice anterior.
```
CombinarHulls(C1, C2)
	p_1 <- punto de más a la derecha en C1
	p_2 <- punto de más a la izquierda en C2
	# Tangente inferior
	while recta(p_1, p_2) no es una tangente inferior de C1 y C2 do
		while recta(p_1, p_2) no es una tangente de C1 do
			p_1--
		end
		while recta(p_1, p_2) no es una tangente de C2 do
			p_2++
		end
	end
	# Tangente superior se calcula de forma similar
end
```
![[Pasted image 20231002161602.png]]
