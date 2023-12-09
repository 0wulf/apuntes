# Definición
Un autómata finito no-determinista con $\varepsilon$-transiciones ($\varepsilon$-NFA) es
$$
\mathcal{A}=(Q,\Sigma,\Delta,I,F)
$$
donde
- $Q$ es un conjunto finito de estados
- $\Sigma$ es el alfabeto de input
- $I\subseteq Q$ es un conjunto de estados iniciales
- $F\subseteq Q$ es el conjunto de estados finales o conjunto de aceptación
- $\Delta\subseteq Q\times(\Sigma\cup\{\varepsilon\})\times Q$ es la relación de transición.
# [[Ejecución de un epsilon-NFA]]
# [[Lenguaje aceptado por un epsilon-NFA]]