# Forma Normal de Chomsky
#### ¿Qué es una forma normal? e.g. Polinomios
Un polinomio cualquiera:
$$p(x):=(x³\cdot((x-2)+3x²)-(3x⁵-2x²))\cdot 2x+7$$
Si queremos hacer un algoritmo sobre el polinomio, nos conviene escribirlo como $$p(x):=2x⁵+4x³-4x+7$$
> Formas normales son útiles en computación para estudiar un objeto y diseñar algoritmos
## Definición
Una gramática $\mathcal{G}$ está en **forma normal de Chomsky** (CNF) si todas sus producciones son de la forma:
- $X\rightarrow YZ$
- $X\rightarrow a$
![[Pasted image 20231018102658.png]]
Si está en CNF:
- ¿Puede aceptar la palabra $\varepsilon$? No
- ¿Puede tener producciones unitarias? No
- ¿Puede tener producciones en vacío? No.
## ¿Podemos convertir toda gramática a CNF?
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG tal que $\varepsilon\not\in\mathcal(\mathcal{G})$
- Primero, suponga que $\mathcal{G}$ no contiene reglas en vacío o unitarias
- Por lo tanto, todas las reglas en $\mathcal{G}$ son de la forma:
	- $X\rightarrow\gamma$ pata $|\gamma|\geq2$
	- $X\rightarrow a$
> ¿Cómo transformamos $\mathcal{G}$ en forma normal de Chomsky?
## CFG a CNF
Sea una gramática $\mathcal{G}$ donde las reglas son de la forma:
- $X\rightarrow\gamma$ para $|\gamma|\geq2$
- $X\rightarrow a$
### Paso 1
##### Objetivo
Convertir todas las reglas a la forma:
- $X\rightarrow Y_1Y_2...Y_k$ para $k\geq 2$
- $X\rightarrow a$
##### Solución
- Para cada $a\in\Sigma$, agregamos una nueva variable $X_a$ y una regla $X_{a}\rightarrow a$
- Reemplazamos todas las ocurrencias antiguas de $a$ por $X_a$

![[Pasted image 20231018103505.png]]
##### Correctitud
Si $\mathcal{G}'$ es la gramática resultante, entonces se cumple que $\mathcal{L}(\mathcal{G}')=\mathcal{L}(\mathcal{G})$
### Paso 2
##### Objetivo
Convertir todas las reglas a la forma:
- $X\rightarrow YZ$
- $X\rightarrow a$
##### Solución
Para cada regla $p: X\rightarrow Y_1Y_2...Y_k$ con $k\geq 3$:
- Agregamos una nueva variable $Z$
- Reemplazamos la regla $p$ por dos reglas: $$\begin{gathered} X\rightarrow Y_{1}Z \\ Z\rightarrow Y_2...Y_k\end{gathered}$$
**Repetimos** este paso hasta llegar a la forma normal de Chomsky.

![[Pasted image 20231018103707.png]]
##### Correctitud
Si $\mathcal{G}''$ es la gramática resultante, entonces se cumple que $\mathcal{L}(\mathcal{G}'')=\mathcal{L}(\mathcal{G}')$
## Teorema: Toda CFG se puede convertir en CNF
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG tal que $\varepsilon\not\in\mathcal{L}(\mathcal{G})$
Entonces existe una gramática $\mathcal{G}'$ en forma normal de Chomsky tal que: $$\mathcal{L}(\mathcal{G}')=\mathcal{L}(\mathcal{G})$$

---
# Referencias
- Capítulo 21 - [[Automata and Computability.pdf]]
