"Almacenar en el autómata determinista todos los estados actuales de las ejecuciones en curso (sin repetirlos)"
# Subset construction
Para un autómata no-determinista $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$, definimos el autómata determinista (determinización de $\mathcal{A}$) como:
$$
\mathcal{A}^{\det}=(2^Q,\Sigma,\delta^{\det},q_0^{\det},F^{\det})
$$
donde:
- $2^Q=\{S|S\subseteq{Q}\}$ es el conjunto potencia de $Q$.
- $q_0^{\det}=I$.
- $\delta^{\det}:2^Q\times\Sigma\rightarrow 2^Q$ tal que:
	- $\delta^{\det}(S,a)=\{q\in Q | \exists p\in S: (p,a,q)\in\Delta\}$
- $F^\det=\{S\in 2^Q|S\cap F \neq \emptyset\}$ 
# Proposición
Dado un autómata no-determinista $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ se tiene que 
$$\mathcal{L}\mathcal(A)=\mathcal{L}(\mathcal{A}^\det)$$
## [[Demostración determinización]]