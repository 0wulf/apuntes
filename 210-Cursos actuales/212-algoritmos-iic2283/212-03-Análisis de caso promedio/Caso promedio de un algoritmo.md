Suponemos que para cada $n\in\mathbb{N}$ hay una distribución de probabilidades:
- $Pr_n(w)$ es la probabilidad de que $w\in\mathcal{I}_{\mathcal{P},n}$ aparezca como entrada de $\mathcal{A}$.

Nótese que $$\sum_{w\in\mathcal{I}_{\mathcal{P},n}}{Pr_n(w)}=1$$
Para definir el caso promedio, para cada $n\in\mathbb{N}$ usamos una variable aleatoria $X_n$
- Para cada $w\in\mathcal{I}_{\mathcal{P},n}$ se tiene que $X_n(w)=\text{tiempo}_\mathcal{A}(w)$

Para las entradas de largo $n$, el número de pasos de $\mathcal{A}$ en el caso promedio es el valor esperado de la variable aleatoria
$$E(X_n)=\sum\limits_{w\in\mathcal{I}_{\mathcal{P},n}}{X_n(w)\cdot Pr_n(w)}$$
# [[Complejidad en el caso promedio]]