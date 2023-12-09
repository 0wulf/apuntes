- La palabra "programación" se refiere más a planificación que a programación de computadores
- Permite diseñar algoritmos para problemas con dos ingredientes:
	1. Se espera que los sub-problemas estén traslapados
		- Un mismo sub-problema es resuelto varias veces en diferentes ramas del árbol de recursión
		- Eso generalmente suele conducir a tiempos de ejecución elevados, de órdenes exponenciales o factoriales.
		- Se busca resolver cada sub-problema una única vez, reduciendo el tiempo a polinomial
	2. Se espera que se cumpla el principio de optimalidad
		- En general se usa para resolver problemas de optimización
		- Para que un problema pueda ser resuelto con esta técnica se debe cumplir el siguiente principio de optimalidad para los sub-problemas
		- Una solución óptima para un problema contiene soluciones óptimas para sus sub-problemas.
- Programación dinámica = fuerza bruta recursiva + almacenamiento de resultados parciales
---
# E.g. Secuencia de Fibonacci
![[Pasted image 20231002162919.png]]
![[Pasted image 20231002162942.png]]
- Tenemos $\Theta(\varphi^n)$ nodos en el árbol de recursión, por lo que el tiempo de ejecución también es exponencial
- Usaremos una técnica de *memoization* manteniendo una tabla o arreglo `memo[0..n]`
![[Pasted image 20231002163337.png]]
```
Fib-Memo(n)
	if n <= 1 then
		return n
	else
		if memo[n] == -1 then
			memo[n] <- Fib-Memo(n-1) + Fib-Memo(n-2)
		end
		return memo[n]
	end
end
```
- Hemos reducido el tiempo de ejecución de exponencial a lineal !!!!
- a cambio de uso de espacio en memoria de $\Theta(n)$
- Sin embargo, el algoritmo sigue construyendo el árbol de recursión de forma top-down
	- Lo que necesita marcas para los sub-problemas no calculados e introduce ineficiencias por la recursión y el uso del stack
---
# E.g. Secuencia de Fibonacci bottom-up
```
Fib-Bottom-Up(n)
	f[0] <- 0
	f[1] <- 1
	for i <- 2,...,n do
		f[i] <- f[i-1] + f[i-2]
	end
	return f[n]
end
```
- El tiempo de ejecución y el espacio son $\Theta(n)$ 
- En ciertos casos no será necesario almacenar todo el arreglo `f` en este caso solo necesitamos las dos posiciones anteriores, usando espacio en memoria de $\Theta(1)$
```
Fib-Bottom-Up-2(n)
	if n <= 1 then
		return n
	else
		f2 <- 0
		f1 <- 1
		for i <- 2,...,n-1 do
			f <- f1 + f2
			f2 <- f1
			f1 <- f
		end
		return f1 + f2
	end
end
```
---
# Midiendo la distancia entre dos strings
- Sea $\Sigma$ un alfabeto de símbolos.
- Sean $w_1,w_2\in\Sigma^*$ dos strings sobre el alfabeto $\Sigma$
- Vamos a utilizar la distancia de Levenshtein para medir cuán similares son dos strings
	- Esta es una de las medidas de similitud entre strings más populares, por lo que, usualmente, es llamada _edit distance_.
- Dado dos strings $w_1,w_2\in\Sigma^*$, utilizamos la notación $ed(w_1,w_2)$ para la _edit distance_ entre $w_1$ y $w_2$.
	- Tenemos que $ed:\Sigma^*\times\Sigma^*\rightarrow\mathbb{N}$
- Sea $w\in\Sigma^*$ con $w=a_1...a_n$ y $n\geq 0$
	- Si $n=0$ entonces $w=\varepsilon$
- Para $i\in\{1,...,n\}$ y $b\in\Sigma$ tenemos que:
	- $eliminar(w,i)=a_1...a_{i-1}a_{i+1}...a_n$
	- $agregar(w,i,b)=a_1...a_{i}ba_{i+1}...a_n$
	- $cambiar(w,i,b)=a_1...a_{i-1}ba_{i+1}...a_n$
- Además, tenemos que $agregar(w,0,b)=b\cdot w$
---
## La distancia de Levenshtein
Dados dos strings $w_1,w_2\in\Sigma^*$, definimos $ed(w_1,w_2)$ como el **mínimo** número de operaciones eliminar, agregar y cambiar que aplicadas desde $w_1$ generan $w_2$
![[Pasted image 20230927150739.png]]
### Calculando la distancia de Levenshtein
- Una manera de calcular $ed(w_1,w_2)$ es por fuerza bruta
	- Se deben considerar todas las posibles secuencias de operaciones de edición que permiten transformar $w_1$ en $w_2$
	- De todas estas secuencias, nos quedamos con la que necesite la menor cantidad de operaciones
	- Es importante que los strings intermedios nunca tengan longitud mayor a $|w_1|+|w_2|$, para evitar operaciones que no son estrictamente necesarias
- Luego entenderemos que esto requiere tiempo exponencial en la longitud de los strings a causa de la repetición en la solución de subproblemas
- Luego usaremos programación dinámica para implementar el mismo proceso, reduciendo el tiempo a polinomial

#### Notación preliminar
Dado $w\in\Sigma^*$ tal que $|w|=n$, y dado $i\in\{1,..,n\}$, definimos $w[i]$ como el símbolo de $w$ en la posición $i$
- Tenemos que $w=w[1]...w[n]$
Además, definimos el infijo de $w$ entre las posiciones $i$ y $j$ como:
![[Pasted image 20230927151510.png]]
### La distancia  un principio de optimalidad para sub-secuencias
- Sean $w_1,w_2\in\Sigma^*$ tal que $ed(w_1,w_2)=k$
- Eso significa que existe una secuencia $o_1,...,o_k$ óptima de operaciones que aplicadas desde $w_1$ generan $w_2$ con $k\geq1$ 
- Considere $0\leq i\leq |w_1|$ y suponga que 
$$o_{i_1},...,o_{i_l}$$
	(para $1\leq i_{1}\leq i_{2}\leq...\leq i_{l}\leq k$ y $1\leq l\leq k$) es la sub-secuencia de la secuencia óptima de operaciones $o_1,...,o_k$ que aplicadas desde $w_{1}[1,i]$ generan $w_{2}[1,j]$ con $1\leq j\leq |w_2|$
- Eso significa que la sub-secuencia debería también ser óptima, es decir,
$$ed(w_{1}[1,i],w_{2}[1,j])=l$$
- Demostraremos que eso último es cierto, por contradicción
![[Pasted image 20230927152400.png]]
![[Pasted image 20230927152407.png]]
## Una definición recursiva de la distancia de Levenshtein
![[Pasted image 20230927152627.png]]
![[Pasted image 20230927152615.png]]
![[Pasted image 20230927153040.png]]
![[Pasted image 20230927153050.png]]
![[Pasted image 20230927153100.png]]
![[Pasted image 20230927153108.png]]
![[Pasted image 20230927153137.png]]
## Una implementación recursiva de la distancia de Levenshtein
```
EditDistance(w1, i, w2, j)
	if i == 0 then return j
	else if j == 0 then return i
	else
		t <- EditDistance(w1, i-1, w2, j-1)
		s <- EditDistance(w1, i, w2, j-1)
		r <- EditDistance(w1, i-1, w2, j)
		if w1[i] == w2[j] then
			d <- 0
		else
			d <- 1
		end
		return min{t+d, s+1, r+1}
	end
end
```
## Una versión bottom-up de la distancia de Levenshtein
- Notemos que los sub-problemas recursivos a resolver son de la forma $ed(i,j)$ con $0\leq i\leq|w_1|=m$ y $0\leq j\leq|w_2|=n$
- Eso significa que cada sub-problema es identificado con dos parámetros, por lo que, la tabla de programación dinámica debe ser de dimensión 2
- Definimos la tabla $M[0..m][0..n]$ tal que $M[i][j]=ed(i,j)$
- Ahora tenemos que definir cómo llenar la tabla para evitar repetir la solución de subproblemas
![[Pasted image 20231002165940.png]]
![[Pasted image 20231002165947.png]]
![[Pasted image 20231002165959.png]]
![[Pasted image 20231002170011.png]]
```
EditDistanceBottomUp(w1, w2)
	m <- |w1|
	n <- |w2|
	for i <- 0..m do M[i][0] <- i end
	for j <- 0..n do M[0][j] <- j end
	for i <- 1..m do
		for j <- 1..n do
			M[i][j] <- min{M[i-1][j-1]+dif(i, j), M[i-1][j]+1, M[i][j-1]+1}
		end
	end
end
```

Luego se puede pensar en un algoritmo que almacene solamente los valores que seguirá utilizando, e.g. guardar solamente la "frontera". 
