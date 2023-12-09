No siempre la búsqueda de solución a las instancias demoran el mismo tiempo:
```
# Acá depende de la posición del elemento x
pertenencia(x, S[1..n])
	for i <- 1 to n do
		if x  == S[i] then
			return i
		end
	end
	return n + 1 
```
## [[Tiempo de Ejecución de Mejor Caso]]

## [[Tiempo de Ejecución de Peor Caso]]