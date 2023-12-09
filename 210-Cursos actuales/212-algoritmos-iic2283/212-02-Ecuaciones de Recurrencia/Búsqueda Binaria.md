Suponga que tiene una lista ordenada de menor a mayor $L[1...n]$ de números enteros con $n\geq{1}$ 
¿Cómo podemos verificar si un número $a$ está en $L$?
```
# Búsqueda binaria, versión recursiva
BinarySearch(a, L, i, j):
	if i>j then return false
	else if i==j then
		if L[i]==a then return i
		else return false
	else
		p <- floor((i+j)/2)
		if L[p]<a then return BinarySearch(a, L, p+1, j)
		else if L[p]>a then return BinarySearch(a, L, i, p-1)
		else return p

# Llamada inicial:
# BinarySearch(a, L, 1, n)
```
# [[Tiempo de ejecución de búsqueda binaria]]