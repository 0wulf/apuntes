## Expresiones regulares en la práctica
- En la práctica, las expresiones regulares se definen de manera ligeramente diferente a como lo hace la teoría
- Las sintaxis más usadas para definir RegEx son 
	1. POSIX (Portable Operating System Interface for uniX)
	2. PCRE (Perl Compatible Regular Expressions)
- El módulo `re` de python no sique ninguno de estos estándares pero es muy similar a PCRE
![[Pasted image 20231010123630.png]]
Más información [aquí](https://regex101.com/)

---
# Evaluación de expresiones regulares
## ¿Cómo evaluamos una expresión regular eficientemente?
- `PROBLEMA`: Evaluación de expresiones regulares
- `INPUT`: Una expresión regular $R$ y un documento $w$
- `OUTPUT`: `TRUE` si y solo si $w\in\mathcal{L}(R)$
- Tamaño del input
	- $|R|:=$ número de letras y operadores
	- $|w|:=$ largo del documento
- ¿Cuándo un algoritmo será considerado eficiente?
	- Podemos comenzar buscando un algoritmo polinomial en el tamaño del input
---
## Diferencia de tamaño entre expresión y documento
- En general tendremos que $|R|<<|w|$
	- $|R|$ puede ser del orden de decenas de operadores ($\sim 1$ KB)
	- $|w|$ puede ser del orden de miles a millones de símbolos ($\sim 100$ MB)
- Análisis de tiempo diferenciado
	- *Combined-complexity*: Expresión y documento son parte del input
	- *Data-complexity*: Solo el documento es parte del input (el tamaño de la expresión se considera constante)
- Buscamos algoritmos que sean lineales en *data-complexity* y ojalá polinomiales en *combined-complexity*
---
## ¿Cómo evaluamos una expresión regular?
1. Convertimos $R$ a un $\varepsilon$-NFA $\mathcal{A}_R$
2. Verificamos si $w\in\mathcal{L}(\mathcal{A}_R)$
---
## ¿Cómo evaluamos un NFA eficientemente?
- `PROBLEMA`: Evaluación de NFA
- `INPUT`: Un autómata NFA $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ y un documento $w$
- `OUTPUT`: `TRUE` si y solo si $w\in\mathcal{L}(R)$
- Tamaño del input
	- $|A|:=|Q|+|\Delta|$ 
	- $|w|:=$ largo del documento
---
## Algoritmos de evaluación de autómatas no deterministas
Veremos varias soluciones:
1. *Backtracking*
1. 5. DFA
2. Determinización de NFA
3. NFA *on-the-fly*
4. $\varepsilon$-NFA *on-the-fly*
---
### Solución 1: *Backtracking*
Dado un NFA $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ y una palabra $w=a_1...a_n$
```
Function eval-backtracking(A, w)
	return backtracking(A, w, q_0, 1)
Function backtracking(A, w, p, i)
	if q \in F then
		return TRUE
	else if i <= n then
		foreach (p, a_i, q) \in \Delta do
			if backtracking(A, w, q, i+1) == TRUE then
				return TRUE
	return FALSE
```
#### Análisis de tiempo
- El tiempo de ejecución de `eval-backtiracking` en el peor caso es de orden exponencial.
- Muchos motores de RegEx usan backtracking para la evaluación de expresiones regulares. 
- De hecho existe un ataque que se aprovecha de esto llamado ReDoS (regular expressions denial of service).
---
## Solución 1.5: DFA
Dado un DFA $\mathcal{A}=(Q,\Sigma,\delta,q_0,F)$ y una palabra $w=a_1...a_n$
```
Function eval-DFA(A, w)
	q <- q_0
	for i <- 1 to n do
		q <- \delta(q, a_i)
	return check(q \in F)
```
#### Análisis de tiempo:
- ¿Cómo hacemos `q <- \delta(q, a_i)` de manera eficiente?
- Toma tiempo lineal respecto al tamaño de la palabra
---
## Solución 2: Determinización de NFA
Para un NFA $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ y una palabra $w=a_1...a_n$
```
Function eval-NFA(A, w)
	A_det <- NFAtoDFA(A)
	return eval-DFA(A_det, w)
```
#### Análisis de tiempo
- Ahora será de orden exponencial respecto al total de estados del DFA
> Recordatorio:![[Pasted image 20231010131400.png]]
---
## Solución 3: NFA *on-the-fly*
![[Pasted image 20231010131505.png]]
#### Estrategia *on-the-fly*
1. Mantenemos un conjunto $S$ de estados actuales
2. Por cada nueva letra $a$ calculamos el conjunto $\delta^{\det}(S, a)$
![[Pasted image 20231010131618.png]]
Para un NFA $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ y una palabra $w=a_1...a_n$
```
Function eval-NFAonthefly(A, w)
	S <- I
	for i <- 1 to n do
		S_old <- S
		S <- \emptyset
		foreach p \in S_old do
			S <- S unión {q | (p, a_i, q) \in \Delta}
	return check((S intersección F) != \emptyset)
```
#### Análisis de tiempo 
- Ahora el tiempo de peor caso depende del largo del documento por el tamaño del NFA
---
## Solución 4: $\varepsilon$-NFA *on-the-fly*
Para un NFA $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ y una palabra $w=a_1...a_n$
```
Function eval-eNFAonthefly(A, w)
	S <- e-clousure(\Delta, I)
	for i <- 1 to n do
		S_old <- S
		S <- \emptyset
		foreach p \in S_old do
			S <- S unión { q | (p, a_i, q) \in \Delta}
		S <- e-clousure(\Delta, S)
	return check((S intersección F) != \emptyset)
```
#### Análisis de tiempo
- ¿Cómo calculamos `e-clousure(\Delta, S)` eficientemente?
- Ahora tiene un peor caso lineal entre los tamaños
---
## Resumen de técnicas de evaluación simple
Para un NFA $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ y una palabra $w=a_1...a_n$
![[Pasted image 20231010132159.png]]