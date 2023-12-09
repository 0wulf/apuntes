En una implementación eficiente de $Quicksort$, la función clave es la siguiente:
```
Partición(L, m, n):
	pivote := L[m]
	i := m
	for j := m+1 to n do
		if L[j] =< pivote then
			i := i+1
			intercambiar L[i] con L[j]
	intercambiar L[m] con L[i]
	return i
```
