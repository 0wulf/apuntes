# El problema de mezclar dos arreglos
Sean $A[1..n]$ y $B[1..m]$ dos arreglos ordenados.
Se quiere producir un arreglo ordenado $C[1..n+m]$ que contiene los elementos de $A$ y $B$.
- Esta es, la subrutina principal sobre la que se construye $Mergesort$.
```
Merge(A[1..n], B[1..m]):
	i1 <- 1; i2 <- 2; i <- 1;
	while i <= n and i2 <= m do
		if A[i1] <= B[i2] then
			C[i] <- A[i1]
			i1 <- i1 + 1
		else
			C[i] <- B[i2]
			i2 <- i2 + 1
		end
		i <- i + 1
	end
	while i1 <= n do C[i++] <- A[i1++]
	while i2 <= m do C[iii] <- B[i2++]
	return C
```
- En el peor caso el algoritmo anterior hace $m+n-1$ comparaciones entre elementos de $A$ y $B$ (línea 3 del algoritmo).
- ¿Existe una manera más eficiente (en el peor caso) de resolver este problema?
- Demostraremos a continuación una cota inferior para el problema que nos permitirá entender mejor esa pregunta.
	- Usaremos árboles de decisión -> hay que estudiar cuántas salidas posibles tenemos
---
## Intento 1 (FALLIDO)
- Modificamos brevemente la definición del problema, para poder estudiarlo de mejor manera.
- Sean $A[1..n]$ y $B[n+1..n+m]$ dos arreglos ordenados
- Se quiere producir un arreglo ordenado $C[1..n+m]$ que contiene los elementos de $A$ y $B$
- De esta manera, todo algoritmo que resuelve este problema debe producir una permutación de $\{1,..,n+m\}$ como salida
- Eso podría significar que hay $(n+m)!$ posibles, por lo que la complejidad de mezclar dos arreglos ordenados sería $$\Omega(\log_2(n+m)!)=\Omega((n+m)\log_2(n+m))$$
- Sin embargo, el algoritmo estudiado anteriormente hace $n+m-1$ comparaciones en el peor caso, lo que es una contradicción.
- El error viene de que no todas las $(n+m)!$ permutaciones son válidas, ya que, el resultado debe estar ordenado.
---
## Intento 2 (VALIDO)
- Entendamos ese error a continuación, asumiendo que tenemos arreglos $A[1..3]=\langle{a_1,a_2,a_3}\rangle$ y $B[1..2]=\langle{b_1,b_2}\rangle$
- Note que si ubicamos los elementos de $A$ en cierta ubicación de la permutación de salida, no tenemos elección sobre dónde colocar los elementos de $B$:
![[Pasted image 20230902150928.png]]
![[Pasted image 20230902150955.png]]
- La cantidad distinta de salidas que debemos producir es igual a la cantidad de formas en que podemos ubicar los elementos de $A$ en la salida
- Hay $\binom{n+m}{n}$ formas distintas de ubicar los elementos de $A$ en la salida
- En consecuencia, todo algoritmo que mezcle dos arreglos ordenados debe ser capaz de producir esas $\binom{n+m}{n}$ salidas.
- Note que $$\binom{n+m}{n}=\binom{n+m}{m}$$ por lo que el análisis anterior es simétrico con los elementos de $B$.
- Así, todo algoritmo que mezcle dos arreglos ordenados $A[1..n]$ y $B[1..m]$ debe realizar $$\geq\lceil{\log_2\binom{n+m}{n}}\rceil$$ comparaciones entre elementos de $A$ y $B$ en el peor caso.
![[Pasted image 20230902151457.png]]
- Conclusión:
	- Todo algoritmo que mezcla dos arreglos ordenados de tamaño $n$ (cada uno) debe hacer $$\geq 2n-\frac{1}{2}$\log_2(n)-0.826$$ comparaciones
	- Note que el algoritmo estudiado anteriormente hace $2n-1$ comparaciones, por lo que, hay una (pequeña) brecha todavía