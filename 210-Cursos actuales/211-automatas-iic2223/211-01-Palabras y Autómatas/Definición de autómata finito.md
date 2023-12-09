Un **autómata finito determinista (DFA)** es una tupla
$$\mathcal{A}=(Q,\Sigma,\delta,q_0,F)$$
donde
* $Q$ es un conjunto finito de **estados**.
* $\Sigma$ es el **alfabeto del input**.
* $\delta:Q\times\Sigma\rightarrow Q$ es la **función de transición**.
* $q_0\in Q$ es el **estado inicial**.
* $F\subseteq Q$ es el **conjunto de estados finales** (o aceptación).
#### Ejemplo
* $Q=\{0,1,2\}$
* $\Sigma = \{a,b\}$
* $\delta:Q\times\Sigma\rightarrow{Q}$ se define como:
	* $\delta(0,a)=1$
	* $\delta(1,a)=2$
	* $\delta(2,a)=2$
	* $\delta(q,b)=q \forall{q\in\{0,1,2\}}$
* $q_0=0$
* $F=\{2\}$
$(Q,\Sigma,\delta,q_0,F)$ es el **código** de la máquina