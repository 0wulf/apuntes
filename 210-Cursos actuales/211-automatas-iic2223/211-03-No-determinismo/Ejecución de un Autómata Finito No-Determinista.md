Sea
- un autómata finito no-determinista $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ y
- un input $w=a_1a_2...a_n\in\Sigma^{*}$

Una **ejecución** o run $\rho$ de $\mathcal{A}$ sobre $w$ es una secuencia:
$$
\rho:p_0\rightarrow^{a_1}{p_1}\rightarrow^{a_2}{...}\rightarrow^{a_n}{p_n}
$$
con
- $p_0\in{I}$
- para todo $i\in\{0,...,n-1\}, (p_{i},a_{i+1},p_{i+1})\in\Delta$

Una ejecución $\rho$ de $\mathcal{A}$ sobre $w$ es de **aceptación** si:
$$p_n\in{F}$$
Desde ahora hablaremos de las ejecuciones de $\mathcal{A}$ sobre $w$.