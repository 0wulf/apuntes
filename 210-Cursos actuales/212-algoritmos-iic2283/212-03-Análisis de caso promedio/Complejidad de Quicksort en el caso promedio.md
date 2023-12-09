Sea $n\in\mathbb{N}$ tal que $n\geq 2$, y sea $\mathcal{E}_n$ el conjunto de listas $L$ con $n$ elementos distintos sacados desde el conjunto $\{1,...,n\}$ (esto es, todas las formas en las que se puede ordenar tal conjunto)
- Tenemos que $|\mathcal{E}_n|=n!$

Para cada $L\in\mathcal{E}_n$, asumimos lo siguiente: ^eb762c
- $Pr_n(L)=\frac{1}{n!}$, es decir, asumimos que todas las permutaciones tienen la misma probabilidad de ocurrir.
- $X_n(L)$ es el número de comparaciones realizadas por la llamada $Quicksort(L, 1, n)$

La complejidad de $Quicksort$ en el caso promedio está dada por $E(X_n)$

---
# Calculando el valor esperado de $X_n$
Sea $L\in\mathcal{E}_n$
Para cada $i,j\in\{1,...,n\}$ con $i\leq j$ defina la siguiente variable aleatoria:
$Y_{i,j}(L)$: número de veces que $i$ es comparado con $j$ en la llamada $Quicksort(L, 1, n)$.

Entonces tenemos lo siguiente:
$$X_n(L)=\sum\limits_{i=1}^{n}\sum\limits_{j=i}^{n}{Y_{i,j}(L)}$$
Dado que el valor esperado de una variable aleatoria es una función lineal, concluimos que:
$$E(X_n)=\sum^{n}_{i=1}\sum\limits_{j=i}^{n}{E(Y_{i,j})}$$

---
# Calculando el valor esperado de $Y_{i,j}$
Para calcular $E(X_n)$ basta entonces con calcular $E(Y_{i,j})$ para cada $i,j\in\{1,...,n\}$.

Para esto analizamos el proceso de $Partición$. Sea $p$ el pivote, $i$ y $j$ en la misma partición.
![[Pasted image 20230831104324.png]]
![[Pasted image 20230831104340.png]]
![[Pasted image 20230831104436.png]]
# El cálculo final
![[Pasted image 20230831105856.png]]

![[Pasted image 20230831104501.png]]
Por lo tanto:
$$2(n+1)\ln(n)-4n\leq E(X_n)\leq 2(n+1)(\ln(n)+1)-4n$$
y entonces $Quicksort$ es $\Theta(n\log(n))$ en su caso promedio.