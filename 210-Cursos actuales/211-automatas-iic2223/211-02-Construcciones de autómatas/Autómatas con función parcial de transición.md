# Definición
Un autómata finito determinista con **función parcial de transición** (DFAp):
$$\mathcal{A}=(Q,\Sigma,\gamma,q_0,F)$$
donde
* $Q$ es un conjunto finito de estados
* $\Sigma$ es el alfabeto de input
* $\gamma:Q\times\Sigma\rightarrow{Q}$ es una **función parcial** de transición
* $q_0\in{Q}$ es el estado inicial
* $F\subseteq{Q}$ es el conjunto de estados finales o aceptación

¿Qué significa que una función sea parcial?
No para todo par estado letra va a existir un ...

# [[Ejecución de un DFAp]]
# Definiciones
Sea un autómata $\mathcal{A}=(Q,\Sigma,\gamma,q_0,F)$ con $\gamma:Q\times\Sigma\rightarrow Q$ y $w\in\Sigma^*$
* $\mathcal{A}$ acepta $w$ si **existe una ejecución** de $\mathcal{A}$ sobre $w$ tal que es de aceptación.
* El **lenguaje aceptado** por $\mathcal{A}$ se define como:
$$\mathcal{L}(\mathcal{A})=\{w\in\Sigma^*|\mathcal{A}\text{ acepta }w\}$$

# ¿[[Es DFA distinto a DFAp]]?

# Advertencia
Desde ahora, utilizaremos autómatas con **funciones totales de transición**, pero **sin pérdida de generalidad** en algunos ejemplos utilizaremos **funciones parciales de transición** por simplicidad.