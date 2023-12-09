A cada algoritmo $\mathcal{A}$ asociamos una función $tiempo_{\mathcal{A}}=\mathcal{I}_{\mathcal{P}}\rightarrow\mathbb{N}$ tal que:
* $tiempo_{\mathcal{A}}(I)$ es el numero de pasos realizados por $\mathcal{A}$ con entrada $I\in\mathcal{I}_{\mathcal{A}}$
Para definir esta función tenemos que definir qué operaciones vamos a contar y qué costo les asignamos.
Es importante definir el modelo de computación sobre el que vamos a trabajar.
## [[Modelos de Computación]]
## Definición
Sea $\mathcal{A}$ un algoritmo que resuelve un problema abstracto $\mathcal{P}$ , y sea $I\in\mathcal{I}_{\mathcal{P}}$ una instancia particular de $\mathcal{P}$ . El **tiempo de ejecución** del algoritmo $\mathcal{A}$ para la instancia $I$, denotado $tiempo_{\mathcal{A}}(I)$, es la cantidad de instrucciones que ejecuta $\mathcal{A}$ para resolver $I$.

El tiempo de ejecución es clave para comparar algoritmos que resuelven un mismo problema.
Medir el tiempo en base a la cantidad de operaciones elementales permite independizarnos de un algoritmos.
```
# Algoritmo óptimo. Realiza n-1 comparaciones
maximo(S[1..n])
	m <- 1
	for i <- 2 to n do
		if S[m] <= S[i] then
			m <- i
		end
	end
	return m
```

## [[Análisis de mejor y peor caso]]