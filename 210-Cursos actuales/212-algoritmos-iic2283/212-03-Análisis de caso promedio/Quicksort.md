Quicksort es un algoritmo de ordenación muy utilizado en la práctica.

Conceptualmente, sobre un arreglo $L[1..n]$ el algoritmo funciona así:
- Si $n\leq 1$ entonces $L$ está trivialmente ordenado.
- En otro caso:
	- Sea el pivote $p$ un elemento arbitrario del arreglo $L$.
	- Sea $L_{\min}=\{x\in L|x<p\}$
	- Sea $L_\max=\{x\in L|x>p\}$
	- Se aplica $Quicksort(L_\min)$ y $Quicksort(L_\max)$ recursivamente para ordenar $L_\min$ y $L_\max$
	- Luego de ordenar las partes, se produce el arreglo ordenado concatenado:
$$L_\min+\langle{p}\rangle+L_\max$$
Es decir, deja a cada pivote en su posición.
# [[Algoritmo de partición]]
# [[Definición de Quicksort]]
# [[Complejidad de Quicksort]]