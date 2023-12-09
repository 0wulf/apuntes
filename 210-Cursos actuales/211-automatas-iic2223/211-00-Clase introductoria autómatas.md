# Teoría de Autómatas y Lenguajes Formales
Estudio de las máquinas abstractas y ...
Máquina abstracta que representa a un programa
Nos surgen preguntas como ¿siempre se detiene este código?
## Máquina abstracta que representa programas concurrentes
```
while true do
	if x < 2 then
		x <- x+1
while true do
	if x > 0 then
		x <- x-1
while true do
	if x = 2 then
		x <- 0
```
$l_1, l_2, l_3 | x$
$l_1, l_2, l_3 \in \{2,3\}$
$x \in \{0,1,2,\blacksquare\}$ donde $\blacksquare$ representa un comportamiento indefinido.
Surge la pregunta: ¿Siempre se cumple que $0\leq x\leq 2$ ?
Hacemos un esquema como un árbol que representará todos los estados por los que va pasando el código

# Model checking
Verificación formal de software. Dado modelo de un sistema, verficar automáticamente si el modelo cumple una especificación dada. Dos premios turing en esta área.

# Secuencias de ADN y verificación de patrones: Pattern matching
El programa iterativo es tiempo $O(P\cdot N)$
El programa que revisamos es tiempo $O(|s|+|d|)$

1. Teoría de autómatas constituye una noción fundamental y útil en ciencia de la computación.
2. Aplicaciones de teoría de autómatas en diversas áreas de la computación.
3. La modelación con teoría de autómatas nos permite abstraernos del código (...)

# Programa
Profesor: Dante Pinto - drpinto1@uc.cl

Seis tareas durante el semestre y se borra la peor tarea
Puntos en las preguntas de las tareas: $\in{0,2,3,4}$ 
Deben ser escritas en $\LaTeX$ basta con el pdf.
Cupón único durante el semestre, extiende el plazo de jueves 23:59 a lunes 23:59.
Dos interrogaciones y un examen. Son las que sale en el portal. Van a ser parecidas y más fáciles que las tareas. Siempre la pregunta 1 tanto en las ies como examen será  una demostración vista en clases. Son 4 preguntas. Duración de 2 a 3 horas a las 17:30. Examen a las 8:20* el profe busca cambiarlo a las 9 pero está viendo.
Se puede faltar a una interrogación: se reemplazará automáticamente la peor nota por el examen.

## Índice
[[211-01-Palabras y Autómatas]]

## Evaluaciones
![[Pasted image 20230810112024.png]]
![[Pasted image 20230810112033.png]]
PT = promediomejores5(tareas) >= 2.95
PE = promediomejores3(i1, i2, ex, ex) >= 3.95
