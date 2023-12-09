# Ordenando un arreglo
- Estudiaremos ahora el problema de ordenar un arreglo $L[1..n]$ de $n$ elementos.
- Los algoritmos más eficientes conocidos tienen un tiempo de ejecución de peor caso de $O(n\log(n))$
	- Mergesort
	- Heapsort
	- Quicksort (en el caso promedio)
- ¿Existen maneras más rápidas (en el modelo de comparaciones) para ordenar un arreglo?
- Vamos a demostrar que no existe tal algoritmo usando árboles de decisión
	- Mergesort y Heapsort son óptimos en el peor caso para el modelo de comparaciones.
---
# 2
- Para estudiar mejor el problema de ordenamiento, vamos a redefinirlo de la siguiente manera:
	- Dado un arreglo $L[1..n]$ de $n$ elementos de cierto tipo sobre el que se ha definido una relación de orden total $\leq$ (e.g. los elementos se pueden ordenar)
	- Queremos obtener una permutación $i_1,i_2,...,i_n$ de $\{1,2,...,n\}$ tal que:$$L[i_1]\leq L[i_2]\leq ... \leq L[n]$$
	- En la práctica, los elementos del arreglo original deben ser reorganizados de manera que: $$L[1]\leq L[2]\leq ... \leq L[n]$$ lo cual también puede hacerse a partir de nuestra definición.
- A partir de esta definición del problema queda claro que todo algoritmo de ordenamiento:
	- Debe producir una permutación de $\{1,...,n\}$ correspondiente al ordenamiento de la entrada
	- Es más, debe ser capaz de producir cualquiera de las posibles permutaciones de $\{1,...,n\}$
	- El algoritmo podría ser visto como que es capaz de distinguir la permutación que corresponde a cada entrada
	- Hay $n!$ permutaciones distintas de $\{1,...,n\}$
---
# 3
- A continuación, representamos cualquier algoritmo $\mathcal{A}$ de ordenamiento como un árbol de decisión
- Los nodos internos del árbol son las comparaciones entre elementos del arreglo
- Las ramas del árbol corresponden a las decisiones tomadas por el algoritmo al hacer comparaciones
- Los nodos externos del árbol corresponden a las permutaciones de salida
- Dado que para $n$ elementos hay $n!$ posibles permutaciones, para todo árbol de decisión $\mathcal{T}_{\mathcal{A},n}$ que represente un algoritmo de ordenamiento se debe cumplir:$$n!\leq\text{hojas}(\mathcal{T}_{\mathcal{A},n})$$ por lo que $$\lceil{\log2(n!)}\rceil\leq\lceil{\log_2(\text{hojas}(\mathcal{T}_{\mathcal{A},n}))}\rceil$$
- Para la altura $h$ de cualquiera de esos árboles también se cumple $$\lceil{\log_2(\text{hojas}(\mathcal{T}_{\mathcal{A},n}))}\rceil\leq h$$ por lo que, en total podemos acotar $h$ inferiormente como sigue: $$\lceil{\log_2(n!)}\rceil\leq h$$
- $\lceil{\log_2(n!)}\rceil$ es una cota inferior para la altura de todo árbol de decisión que represente un algoritmo de ordenamiento
- Ningún algoritmo de ordenamiento puede realizar menos de $\lceil{\log_2(n!)}\rceil$ comparaciones en el peor caso para ordenar un arreglo
	- una menor altura no le permitirá tener al menos $n!$ nodos externos necesarios para ordenar correctamente.
- Encontramos a continuación una forma más intuitiva para $\lceil{\log_2(n!)}\rceil$
	- La aproximación de Stirling: $n!\approx\sqrt{2\pi n}(\frac{n}{e})^n$ 
	- por lo que $\log_2(n!)\approx n\log(\frac{n}{e})$
---
# 4
- En conclusión, todo algoritmo de ordenamiento (en el modelo de comparaciones) debe hacer $\Omega(n\log(n))$ en el peor caso.
- Por otro lado, Mergesort y Heapsort hacen $O(n\log(n))$ comparaciones en el peor caso. Esto significa que
	- Mergesort y Heapsort son algoritmos de ordenamiento óptimos
	- La complejidad del problema de ordenamiento es $\Theta(n\log(n))$ comparaciones.