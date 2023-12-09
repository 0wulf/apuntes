- Los algoritmos codiciosos o *greedy* son usados, en general, para resolver problemas de optimización
- El principio fundamental de este tipo de algoritmos es lograr un óptimo global tomando decisiones locales que son óptimas
	- en general, la intuición detrás de estos algoritmos es simple
- Dos componentes fundamentales de un algoritmo codicioso:
	- Una función objetivo a minimizar o maximizar
	- Una función de selección usada para tomar decisiones locales óptimas

- Los problemas de optimización generalmente se resuelven mediante algoritmos que toman decisiones a lo largo de una secuencia de pasos
- Los algoritmos codiciosos construyen la solución a un problema mediante una secuencia de pasos
	- Cada paso expande la solución parcial construida hasta el momento, hasta llegar a la solución completa
- En cada paso, el algoritmo codicioso toma una decisión que debe cumplir con las siguientes propiedades
	1. Factible: debe satisfacer las restricciones al problema
	2. Localmente óptima: debe ser la mejor elección entre todas las elecciones factibles
	3. Irrevocable: una vez tomada una decisión, no puede ser cambiada en los siguientes pasos del algoritmo

- Lamentablemente en muchos casos los algoritmos codiciosos no encuentran un óptimo global
	- sin embargo, en muchos casos pueden ser utilizados como heurísticas para encontrar valores de la función objetivo cercanos al óptimo
- Una segunda dificultad con los algoritmos codiciosos es que, en general, se necesita de una demostración formal para asegurar que encuentran el óptimo global
	- Aunque pueden ser algoritmos simples, en algunos casos no es obvio por qué encuentran el óptimo global
	- La dificultad está en la demostración de optimalidad más que en el algoritmo

- Ejemplos clásicos
	- Algoritmo de Dijkstra para caminos más cortos en grafos
	- Algoritmos de Prim y Kruskal para MST (minimum spanning tree)
	- Algoritmo de Huffman para codificar fuentes de datos
	- Algoritmo de coloreo de grafos
	- etc.
---
# Ejemplos
## La fila de monedas
- Recordemos el problema de recoger $n$ monedas dispuestas sobre una fila sobre la mesa
- El problema consiste en tomar la mayor cantidad de dinero de la mesa
- Sujeto a la restricción de cada vez que se toma una moneda, quedan invalidadas las dos monedas contiguas a la moneda tomada.
- Por ejemplo, consideremos la siguiente fila de monedas
![[Pasted image 20231011154435.png]]
- Una estrategia *greedy* toma, sin dudas, la moneda de mayor denominación, en este caso la de 50
![[Pasted image 20231011154547.png]]
- A continuación, la estrategia *greedy* escoge la tercera moneda de la fila (10)
- Luego se escoge la quinta moneda de la fila (5)
- Finalmente las monedas de 1 de los extremos
![[Pasted image 20231011154654.png]]
- Total recogido = 67 -> en este caso coincide con la cantidad óptima para esa fila
- Eso podría hacernos sospechar que esta estrategia *greedy* es óptima
- Sin embargo, esto no es así
- El hecho de tomar siempre la moneda de mayor denominación, sin considerar el valor de las monedas contiguas que está invalidando (no piensa en las consecuencias) lleva a obtener soluciones sub-óptimas
- e.g
![[Pasted image 20231011154858.png]]
- El valor óptimo es $51>50$ que es el valor obtenido
---
## División de un texto en líneas
- Sea $$T=p_1,...,p_n$$ un texto formado por $n$ palabras $p_{i}$ con $1\leq i \leq n$ de longitudes $$l_1,...,l_n$$
- El problema consiste en imprimir el texto en la pantalla (o en una hoja de papel) teniendo en cuenta
	- El ancho de línea predefinido es $L$ (no se puede cambiar)
	- Las palabras no pueden cortarse para ajustarlas a una línea
	- La amplitud ideal de los espacios entre palabras es $b$
		- pueden ampliarse o reducirse para acomodar las palabras en una línea
- En resumen, se quiere dividir el texto en líneas para su impresión
- Considere la secuencia de palabras contiguas $p_i,...,p_j$ la cual está separada por $j-i$ espacios en blanco
- Si modificamos el valor $b$ por un valor alternativo $b'$, se obtiene una penalización de $$(j-i)|b'-b|$$ puntos
- Si queremos colocar la secuencia $p_i,...,p_j$ en una línea, entonces $$b'=\frac{L-l_{i}-l_{i+1}-...-l_{j}}{j-i}$$ 
- El objetivo es dividir el texto en líneas de manera que la penalización total sea mínima

Estudiemos una solución codiciosa para este problema
- La idea es comenzar agregando las palabras $p_1,p_2,...$ en la línea actual usando el espacio ideal de tamaño $b$ hasta que una palabra $p_a$ no quepa en la línea actual: $$l_1+...+l_a+(a-1)b>L$$
- En este punto se debe tomar una decisión:
	1. Imprimir $p_{a}$ en la línea actual, reduciendo la amplitud de los espacios en blanco 
	2. Imprimir $p_a$ en la línea siguiente, incrementando la amplitud de los espacios en blanco.
- La solución codiciosa elige la alternativa que produce la menor penalización para la línea actual
- Aunque esta solución es eficiente $T(n)\in\Theta(n)$, produce soluciones sub-óptimas
	- E.g. sean 
		- $L=26$
		- $b=2$
		- $n=7$
		- $l_1,...,l_7=10,10,4,8,10,12,12$
	- En este caso el algoritmo produce una división $(10,10,4)(8,10)(12,12)$ con penalización total $2+6+0=8$
	- Pero una división de la forma $(10,10)(4,8,10)(12,12)$ produciría una penalización menor de $4+0+0=4$


---
## Planificación de tareas
- Suponga un servidor que debe atender $n$ tareas, cuyos tiempos requeridos para completarse son $t_1,...,t_n$
- El servidor solo puede atender a una tarea a la vez
- Una vez que comenzó a resolver una tarea, ésta no puede ser abandonada hasta su finalización
- Las tareas están en una cola esperando a ser atendidas
- El servidor podría atenderlas en orden de llegada, o bien podría planificar en qué orden las atiende
- El problema es encontrar un qué orden ejecutar las tareas de manera que la suma total de tiempos de espera sea mínimo
- Suponga 3 tareas con tiempos requeridos $t_1=4,t_2=6,t_3=2$
- Si el servidor las ejecutara en ese orden, la primera tarea no tiene que esperar nada para ser realizada, completándose su servicio en 4 unidades de tiempo.
- La segunda tarea esperará 4 unidades mientras se ejecuta la primera tarea, completándose en $4+6=10$ unidades de tiempo
- La última tarea espera 10 unidades de tiempo hasta comenzar hasta comenzar a ser resuelta, y finaliza en el tiempo 12.
- El total de tiempos de espera es de $0+4+10=14$ unidades de tiempo
- Note que si ejecutamos la tarea 3 inicialmente, luego la tarea 1 y finalmente la tarea 2, el tiempo de espera sería $0+2+(2+6)=8$
- Diseñaremos un algoritmo codicioso para resolver este problema
- Sea $i_1,...,i_n$ una permutación de $[1,n]$ que indica el orden de ejecución de las tareas
- Ejemplo: para 5 tareas una permutación podría ser $3,4,2,5,1$
- Note que los tiempos de espera de cada tarea son 
	- Tarea $i_1$: $0$
	- Tarea $i_2$: $0+t_{i_1}$
	- ...
	- Tarea $i_n$: $0+t_{i_1}+...+t_{i_n}$
- Resumiendo, el tiempo de espera total es $$\sum\limits_{j=1}^{n}\sum\limits_{k=1}^{j-1}{t_{i_k}}$$
> así el tiempo de ejecución de una tarea más larga no afecta en el tiempo de una tarea más corta
---
## Codificación de una fuente de datos
- Estudiamos a continuación el problema de codificar una fuente que genera secuencias de símbolos (strings)
- Suponga una fuente aleatoria que genera símbolos de un alfabeto $\Sigma$ tal que para todo $a\in\Sigma$, $Pr(a)$ es la probabilidad de que el símbolo $a$ sea generado por la fuente
- La fuente genera secuencias de símbolos (llamados textos o strings) con esa distribución de probabilidad
- La secuencia de símbolos se enviará a través de un canal de comunicación a un destino
- Las aplicaciones son evidentes.
- En el destino, la secuencia debería poder leerse para entender qué datos fueron enviados
- El problema consiste en asignarle un código que permita identificar a cada uno de los símbolos generados por la fuente, para que puedan ser decodificados
- El problema se conoce como **codificación de la fuente** (_source encoding problem_)
- Uno quisiera transmitir la menor cantidad de bits posible, por lo que, buscamos codificaciones eficientes (que poseen pocos bits)
- Dado un string $w$ de símbolos de un alfabeto $\Sigma$, suponga que queremos codificar $w$ utilizando los símbolos $0$ y $1$.
	- Esta palabra puede ser pensada como un texto si $\Sigma$ incluye las letras del alfabeto español, símbolos de puntuación y el espacio, por lo tanto, puede ser muy larga
- Definimos entonces una función $\mathcal{C}:\Sigma\rightarrow\{0,1\}^*$ que asigna a cada símbolo $a\in\Sigma$ un código $\mathcal{C}(a)\not=\varepsilon$
	- Llamamos a $\mathcal{C}$ una $\Sigma$-codificación
	- e.g. para $\Sigma=\{a,b,c,d\}$ se podría definir $\mathcal{C}$ tal que $\mathcal{C}(a)=11$, $\mathcal{C}(b)=10$,$\mathcal{C}(c)=110$,$\mathcal{C}(d)=111$.
	- Las $\Sigma$-codificaciones deberán cumplir ciertas propiedades para ser útiles
- Una $\Sigma$-codificación $\mathcal{C}:\Sigma\rightarrow\{0,1\}^*$ es **no singular** si $$\forall x,x'\in\Sigma,x\not=x'\Longrightarrow \mathcal{C}(x)\not=\mathcal{C}(x')$$
- Esto es, cada elemento de $\Sigma$ es mapeado a un string distinto presente en $\{0,1\}^*$
- La no singularidad es suficiente para una descripción no ambigua de un único símbolo de $\Sigma$
- Sin embargo, queremos codificar un string (y no un único símbolo) de forma no ambigua, y en este caso la no singularidad no es suficiente.
- La extensión $\mathcal{C}^*$ de una $\Sigma$-codificación $\mathcal{C}$ a todas las palabras $w\in\Sigma^*$ se define como $$\mathcal{C}^*(w)=\left \{\begin{array}{lcc}
              \varepsilon & \text{si} & w=\varepsilon \\
              \mathcal{C}(a_1)...\mathcal{C}(a_l) & \text{si} & w=a_1...a_{l} \text{ con }l\geq 1
              \end{array}
\right.$$
- Una $\Sigma$-codificación $\mathcal{C}$ es unívocamente decodificable si su extensión $\mathcal{C}^*$ es no singular
- Esto es, $\forall w_{1},w_{2}\in\Sigma^{*}, w_{1}\not=w_{2}\Longrightarrow\mathcal{C}^{*}(w_{1})\not=\mathcal{C}^{*}(w_{2})$
- Por ejemplo, para $\Sigma=\{a,b,c,d\}$ la codificación $\mathcal{C}(a)=11$, $\mathcal{C}(b)=10$,$\mathcal{C}(c)=110$,$\mathcal{C}(d)=111$ no es unívocamente decodificable, ya que $$(db\not=ac)\wedge(\mathcal{C}^{*}(db)=\mathcal{C}^{*}(ac))$$
- Significa que si la fuente codifica $11110$, en el destino no sabremos si corresponde al string $db$ o a $ac$
- Note que una $\Sigma$-codificación $\mathcal{C}$ es unívocamente decodificable si su extensión $\mathcal{C}^{*}$ es una función inyectiva
> ¿Cómo podemos lograr esta propiedad de que $\mathcal{C}^*$ sea inyectiva?
## Codificaciones de largo fijo
- Una manera sencilla de obtener una codificación $\mathcal{C}$ unívocamente decodificable es imponiendo la siguiente condición: $$\forall a,b\in\Sigma\text{ se tiene }|\mathcal{C}(a)|=|\mathcal{C}(b)|$$
- Decimos entonces que $\mathcal{C}$ es una $\Sigma$-codificación de largo fijo

![[Pasted image 20231019175019.png]]
## Codificaciones de largo variable
Decimos que $\mathcal{C}$ es una $\Sigma$-codificación de largo variable si $$\exists a,b\text{ tales que }|\mathcal{C}(a)|\not=|\mathcal{C}(b)|$$
> ¿Por qué nos conviene utilizar codificaciones de largo variable?
> 	Podemos obtener representaciones más cortas para la palabra que queremos almacenas
![[Pasted image 20231019175254.png]]
> Pero nos falta responder una pregunta: ¿por qué $\mathcal{C}^{*}_{2}$ es inyectiva?
### Lema
Sea $\mathcal{C}$ una $\Sigma$-codificación no singular. Si existen $w_{1},w_{2}\in\Sigma^*$ tales que $w_1\not=w_2$ y $\mathcal{C}^{*}(w_{1})=\mathcal{C}^{*}(w_2)$, entonces existen $a,b\in\Sigma$ tales que $a\not=b$ y $\mathcal{C}(a)$ es un prefijo de $\mathcal{C}(b)$

![[Pasted image 20231019175553.png]]
![[Pasted image 20231016155001.png]]
## Codificaciones libres de prefijos
Decimos que una $\Sigma$-codificación $\mathcal{C}$ es libre de prefijos si para cada $a,b\in\Sigma$ tales que $a\not=b$ se tiene que $\mathcal{C}(a)$ no es un prefijo de $\mathcal{C}(b)$
#### e.g.
Para $\Sigma=\{a,b,c\}$ y $\mathcal{C}(a)=0,\mathcal{C}(b)=10,\mathcal{C}(c)=11$, se tiene que $\mathcal{C}$ es libre de prefijos.

### Corolario
Si $\mathcal{C}$ es una codificación libre de prefijos, entonces $\mathcal{C}^{*}$ es una función inyectiva.

## Frecuencias relativas de los símbolos
- String a codificar: $w\in\Sigma^*$
- Para $a\in\Sigma$ definimos $fr_{w}(a)$ como la frecuencia relativa de $a$ en $w$
- Para una $\Sigma$-codificación $\mathcal{C}$ definimos el largo promedio de la codificación de un símbolo de $w$ (en bits) como $$L_{w}(\mathcal{C})=\sum\limits_{a\in\Sigma}{fr_{w}(a)\cdot|\mathcal{C(a)}|}$$
- Tenemos entonces que $|\mathcal{C}^{*}(w)|=L_{w}(\mathcal{C})\cdot|w|$
	- Por lo tanto queremos una $\Sigma$-codificación $\mathcal{C}$ que minimice $L_{w}(\mathcal{C})$
## Frecuencias relativas de los símbolos y la función objetivo
#### Problema de optimización a resolver
Dado $w\in\Sigma^*$, encontrar una $\Sigma$-codificación $\mathcal{C}$ libre de prefijos que minimice el valor $L_{w}(\mathcal{C})$

- La función objetivo del algoritmo codicioso es entonces $L_{w}(\cdot)$
	- Queremos encontrar la $\Sigma$-codificación que minimice el valor de esta función
	- Resuelto por Huffman en el MIT
- La función $L_{w}(\cdot)$ se define a partir de la función $fr_{w}(\cdot)$
	- No se necesita más información sobre $w$. En particular, no se necesita saber cuál es el símbolo de $w$ en una posición específica
- Podemos entonces trabajar con funciones de frecuencias relativas en lugar de palabras
	- El input del problema no va a ser $w$ si no que $fr_{w}$
- Decimos que $f:\Sigma\rightarrow(0,1)$ es una función de frecuencias relativas para $\Sigma$ si se cumple que $$\sum\limits_{a\in\Sigma}{f(a)}=1$$
- Dada una función $f$ de frecuencias relativas para $\Sigma$ y una $\Sigma$-codificación $\mathcal{C}$ para $f$ se define como $$L_{f}(\mathcal{C})=\sum\limits_{a\in\Sigma}{f(a)\cdot|\mathcal{C}(a)|}$$
- Una instancia del problema es entonces una función $f$ de frecuencias relativas para $\Sigma$ y la función objetivo a minimizar es $L_{f}(\cdot)$
## Un ingrediente fundamental: codificaciones como árboles
- Una manera simple de obtener una $\Sigma$-codificación es mediante árboles binarios o árboles de codificación
- e.g. representemos la codificación $\mathcal{C}(a)=0,\mathcal{C}(b)=10,\mathcal{C}(c)=11$ como un árbol binario
![[Pasted image 20231019181556.png]]
- Si una $\Sigma$-codificación $\mathcal{C}$ es libre de prefijos, entonces el árbol que la representa satisface las siguientes propiedades:
	- Cada hoja tiene como etiqueta un elemento de $\Sigma$ y estos son los únicos nodos con etiquetas
	- Cada símbolo de $\Sigma$ es usado exactamente una vez como etiqueta
	- Cada arco tiene etiqueta $0$ o $1$
	- Su una hoja tiene etiqueta $e$ y las etiquetas de los arcos del camino desde la raíz hasta esta hoja forman una palabra $w\in\{0,1\}^*$, entonces $\mathcal{C}(e)=w$
## Codificaciones como árboles y las frecuencias relativas
. Podemos agregar al árbol binario que representa una codificación $\mathcal{C}$ la información sobre las frecuencias relativas dadas por una función $f$:
![[Pasted image 20231019181858.png]]
- Llamamos a este árbol $abf(\mathcal{C},f)$
	- Estos árboles son muy útiles!!
## Algunas propiedades importantes
![[Pasted image 20231018153509.png]]
## Calculando el mínimo de $L_{f}(\cdot)$
- Vamos a ver un algoritmo codicioso para calcular una $\Sigma$-codificación $\mathcal{C}$ libre de prefijos que minimiza $L_f(\cdot)$
	- El algoritmo calcula la codificación de Huffman
- El algoritmo tiene los ingredientes de un algoritmo codicioso
	- Función objetivo a minimizar $L_{f}(\cdot)$
	- Función de selección: elige los dos símbolos de $\Sigma$ con menor frecuencia relativa, los coloca como hermanos en el árbol binario que representa la $\Sigma$-codificación óptima, y continua la construcción con el resto de los símbolos de $\Sigma$
- Además, es necesario realizar una demostración para probar que el algoritmo es correcto
## El algoritmo de Huffman
En el siguiente algoritmo representamos a las funciones como conjuntos de pares ordenados y suponemos que $f$ es una función de frecuencias relativas que al menos tiene dos elementos en el dominio.
![[Pasted image 20231019182339.png]]
### Correctitud
![[Pasted image 20231018153610.png]]
![[Pasted image 20231018153633.png]]
![[Pasted image 20231018153644.png]]
![[Pasted image 20231018153652.png]]
![[Pasted image 20231018153704.png]]
![[Pasted image 20231018153715.png]]
## Dos comentarios finales
La siguiente función calcula la codificación de Huffman teniendo como entrada una palabra $w$:
![[Pasted image 20231019182423.png]]
> ¿Cuál es la complejidad de `CalcularCodificaciónHuffman`?
> 	¿Qué estructura de datos debería ser utilizada para almacenar $f$?
> 	Creo que la complejidad es de $O(n\log n)$ y la estructura un heap.