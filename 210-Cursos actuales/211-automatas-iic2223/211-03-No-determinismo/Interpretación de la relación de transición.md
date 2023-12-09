Un Autómata Finito No-Determinista NFA es una estructura
$$\mathcal{A}=(Q,\Sigma,\Delta,I,F)$$
en donde:
1. $\Delta\subseteq{Q\times\Sigma\times{Q}}$ es la relación de transición:
		"si $(q,a,p)\in\Delta$ entonces existe una transición desde $q$ hasta $p$ al leer $a$".
2. $I\subseteq{Q}$ es un conjunto de estados iniciales.
		"si $p\in{I}$ entonces $p$ es un posible estado inicial del autómata"

también se puede definir como:
1. $\Delta:Q\times\Sigma\rightarrow{2^{Q}}$ es una función de transición: "si $q\in\Delta(p,a)$ entonces $q$ es un posible estado que puedo llegar desde $p$ al leer $a$"
