```
Quicksort(L, m, n):
	if m < n then
		l := Partición(L, m, n)
		Quicksort(L, m, l-1)
		Quicksort(L, l+1, n)
```
