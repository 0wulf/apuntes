# Diseño y Análisis de Algoritmos
3 Tareas aproximadamente
2 interrogaciones
Examen
Podría echarle ojo a la bibliografía.

# Definición Informal
Un **algoritmo** es una secuencia finita, ordenada, y no ambigua de instrucciones o pasos a seguir que permiten *resolver un problema*.
Resolver un problema significa que para cada una de sus instancias obtenemos la solución correspondiente.
Un algoritmo recibe una instancia del problema como entrada produce su correspondiente ...

Los lenguajes de programación son lenguajes no-ambiguos
# Definición Formal
Para un problema abstracto $P$, sea:
* $I_P$ el conjunto, posiblemente infinito, de todas las instancias de $P$
* $S_P$ el conjunto de toda posible solución a las instancias de $P$
* $R_P \subseteq I_P \times S_P$ la relación binaria entre instancias de $P$ y sus soluciones.
* $R_P(i)=\{s|(i,s)\in R_p\}$  es el conjunto de soluciones de una instancia $i\in I_P$
Formalmente, todo el algoritmo $A_P$ que resuelve el problema $P$ es una representación del conjunto $R_P(i)$ para toda $i\in I_P$
## Ejemplo de algoritmo: Multiplicación de matrices
$A \times B = [a_{11}b_{11}+a_{12}b_{21},...]$
Existen maneras más rápidas de multiplicar matrices. Se puede ver la historia completa en Wikipedia.
Cotas inferiores.
Hay un diagrama interesante.
## Nuestro enfoque para el estudio de algoritmos
![[Pasted image 20230809145159.png]]

## Índice
[[Análisis de la eficiencia de un algoritmo]]

## Evaluaciones
* i1 viernes 8 de septiembre
* i2 vierens 3 de noviembre
* examen jueves 7 de diciembre
* Al menos tres tareas en python seguramente
![[Pasted image 20230810111641.png]]
