Sea:
* Un autómata $\mathcal{A}=()$ con $\gamma:Q\times\Sigma\rightarrow{Q}$
* El input $w=a_1...a_n\in\Sigma^*$
Una **ejecución** o run $\rho$ de $\mathcal{A}$ sobre $w$ es una secuencia:
$$
\rho:p_0\rightarrow^{a_1}p_1\rightarrow^{a_2}p_2...\rightarrow^{a_n}p_n
$$
donde
* $p_0=q_0$ y
* para todo $i\in\{0,...,n-1\}$ está definido $\gamma(p_i,a_{i+1})=p_{i+1}$
Una ejecución $\rho$ de $\mathcal{A}$ sobre $w$ es de **aceptación** si:
$$p_n\in{F}$$
Una palabra puede NO tener ejecución.