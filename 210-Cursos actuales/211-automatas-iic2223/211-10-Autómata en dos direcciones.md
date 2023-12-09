## Autómatas como modelo de cómputo
#### ¿Qué tienen en común un autómata y un algoritmo?
1. Lectura de un input
2. Ejecución de pasos de acuerdo al input
3. Registro de información en variables/memoria
#### ¿Qué características tiene un algoritmo pero no un autómata?
1. Uso de estructuras de datos
2. La cantidad de memoria puede depender del input
3. El input puede leerse varias veces
4. La lectura del input no necesariamente es secuencial
En esta clase, modificaremos la forma en que los autómatas leen el input
---
# 2DFA
![[Pasted image 20230913095354.png]]
## Definición
Un autómata finito determinista en 2 direcciones (2DFA) es una estructura
$$\mathcal{A}=(Q,\Sigma,\vdash,\dashv,\delta,q_0,q_f)$$
- $Q$ es un conjunto finito de estados
- $\Sigma$ es el alfabeto input
- $\vdash$ y $\dashv$ son las marcas o símbolos iniciales y finales
- $\delta: Q\times(\Sigma\cup\{\vdash,\dashv\})\rightarrow Q\times\{\leftarrow,\rightarrow\}$ es la función parcial de transición
- $q_0$ es el estado inicial
- $q_f$ es el estado final
![[Pasted image 20230913095843.png]]
---
## Configuración de un 2DFA
Sea
- Un 2DFA $\mathcal{A}=(Q,\Sigma,\vdash,\dashv,q_0,q_f)$
- Una palabra $w=a_1a_2...a_n\in\Sigma^*$
Defina $a_0=\vdash$ y $a_n+1=\dashv$
Una **configuración** de $\mathcal{A}$ sobre $w$ viene dado por un par
$$(q,i)\in Q\times\{0,...,n+1\}$$
- $q$ es el estado actual del autómata
- $i$ es la posición actual de la cabeza lectora.
Se define la relación de **siguiente configuración** $\xmapsto{\mathcal{A}}$ de $\mathcal{A}$ sobre $w$ como
$$(p,i)\xmapsto{\mathcal{A}}(q,j)$$

---
## Ejecución de un 2DFA
Sea
- Un 2DFA $\mathcal{A}=(Q,\Sigma,\vdash,\dashv,q_0,q_f)$
- Una palabra $w=a_1a_2...a_n\in\Sigma^*$
Una **ejecución** $\rho$ de $\mathcal{A}$ sobre $w$ es una secuencia de configuraciones
$$\rho:(p_0,i_0)\rightarrow(p_1,i_1)\rightarrow...\rightarrow(p_m,q_m)$$
- $p_0=q_0$ y $i_0=0$
- $(p_j,i_j)\xmapsto{\mathcal{A}}(p_{j+1},i_{j+1})$ para todo $j\in[0,m-1]$
Una ejecución $\rho$ de $\mathcal{A}$ sobre $w$ es de aceptación si
$$p_m=q_f\text{ y }i_m=n+1$$

---
## Lenguaje Aceptado por un 2DFA
Sea
- Un 2DFA $\mathcal{A}=(Q,\Sigma,\vdash,\dashv,q_0,q_f)$
- Una palabra $w=a_1a_2...a_n\in\Sigma^*$
$\mathcal{A}$ acepta $w$ si hay una ejecución de $\mathcal{A}$ sobre $w$ que es de aceptación
El lenguaje aceptado por $\mathcal{A}$ se define como
$$\mathcal{L}(\mathcal{A})=\{w\in\Sigma^*|\mathcal{A}\text{ acepta }w\}$$
Un 2DFA puede "parar por error" o nunca parar.

---
# 2DFA vs DFA
- ¿Es DFA $\subseteq$ 2DFA?
	- Sí. Para todo lenguaje regular $L$ existe un 2DFA $\mathcal{A}$: $L=\mathcal{L}(\mathcal{A})$
	- Demostraremos ahora que 2DFA $\subseteq$ DFA
---
![[Pasted image 20230913101652.png]]
![[Pasted image 20230913101703.png]]
![[Pasted image 20230913101758.png]]
![[Pasted image 20230913101818.png]]
![[Pasted image 20230913101827.png]]
