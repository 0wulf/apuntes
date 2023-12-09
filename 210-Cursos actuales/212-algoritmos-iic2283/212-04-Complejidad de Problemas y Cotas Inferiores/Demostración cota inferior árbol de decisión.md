# Demostrando cotas inferiores: Árboles de decisión
- Desafortunadamente, no es fácil ni práctico considerar todos los posibles algoritmos para resolver un problema dado
- Al probar cotas inferiores, primero debemos especificar precisamente qué clase de algoritmos consideraremos y precisamente qué tipo de operaciones se van a considerar al medir el tiempo de ejecución
- Esta especificación es llamada modelo de computación
- En particular, estudiaremos el modelo de árboles de decisión
---
# 2
- Un modelo asociado a los árboles de decisión es el modelo de comparaciones
	- el cómputo principal de un algoritmo puede ser realizado solo mediante comparaciones entre elementos de la entrada
	- El tiempo de ejecución de este modelo se mide en cantidad de comparaciones hechas por el algoritmo
- Muchos problemas importantes pueden resolverse comparando elementos de la entrada
	- Búsqueda en un conjunto ordenado
	- Ordenamiento
	- Selección
---
# 3
- Un árbol de decisión binario es un modelo de computación en el cual un algoritmo particular es representado mediante un árbol con las siguientes características:
	- Nodos internos: representan las comparaciones de elementos hechas por el algoritmo
	- Subárbol izquierdo de un nodo interno: representa el cómputo a realizar si la comparación del nodo actual es verdadera
	- Subárbol derecho de un nodo interno: representa el cómputo a realizar si la comparación del nodo actual es falsa
	- Nodos externos u hojas: representan las posibles salidas del algoritmo
---
# 4
- El modelo de árboles de decisión no permite iterar
- La idea es implementar las iteraciones mediante un árbol de ifs anidados
- Las hojas del algoritmo son los return del algoritmo
- Para cada $n\in\mathbb{N}$ definimos un árbol de decisión $\mathcal{T}_{\mathcal{A},n}$ que describe el funcionamiento del algoritmo $\mathcal{A}$ con entradas de largo $n$
	- Usamos el mismo árbol para todas las entradas de largo $n$
		- El árbol de decisión tiene un registro de las comparaciones hechas por el algoritmo $\mathcal{A}$
	- Para cada valor de $n$ se debe tener un árbol que procese entradas de ese tamaño.
---
# 5
Sea $\mathcal{P}$ un problema abstracto. Para todo algoritmo $\mathcal{A}$ que resuelve a $\mathcal{P}$ y su correspondiente árbol de decisión $\mathcal{T}_{\mathcal{A},n}$ (para un $n$ dado) hay que considerar:
- Cada posible salida debe tener al menos un nodo externo en $\mathcal{T}_{\mathcal{A},n}$ que le represente:
	- de otra manera, el algoritmo sería incorrecto
	- la cantidad de nodos externos del árbol debe ser al menos el número de posibles salidas del algoritmo
- La ejecución del algoritmo sobre una entrada en particular corresponde a un camino desde la raíz del árbol hasta el nodo externo correspondiente
- La cantidad de comparaciones realizadas para una entrada dada corresponde al largo del camino seguido en la ejecución.
- Así, el tiempo de ejecución de peor caso es la altura del árbol de decisión
---
# 6
La idea central detrás del modelo de árboles de decisión es la siguiente:
- Determinar el número de nodos externos $l$ que debe tener cualquier árbol que resuelve el problema $\mathcal{P}$ en cuestión
- Un árbol con $l$ nodos externos (posibles salidas) tiene que ser lo suficientemente alto para tener ese número de  nodos externos
- En particular, se cumple que para cualquier árbol binario con $l$ nodos externos y altura $h$
$$h\geq \lceil{\log_2(l)}\rceil$$
- Esto es, el número de nodos externos define una cota inferior respecto a la altura del árbol.
- Esto define una cota inferior para el número de comparaciones en el peor caso para cualquier algoritmo para el problema en cuestión.
- Recordemos que la altura $h$ se define como la distancia entre ele nodo raíz hasta el nodo hoja más lejano. Así, un árbol de un solo nodo tiene altura $h=0$.