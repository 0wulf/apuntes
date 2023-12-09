# Desde Expresiones Regulares a Autómatas
Para cada $R\in\text{ExpReg}$, construiremos un $\varepsilon-$NFA $\mathcal{A}_R$ inductivamente
## Construcción inductiva
Para cada $R\in\text{ExpReg}$, construimos un autómata $\varepsilon-\text{NFA}$ $\mathcal{A}_R$
$$
\mathcal{A}_R=(Q,\Sigma,\Delta,\{q_0\},\{q_f\})
$$
tal que $\mathcal{L}(R)=\mathcal{L}(\mathcal{A}_R)$.
### Casos base
1. Si $R=a$ para alguna letra $a\in\Sigma$, entonces ![[Pasted image 20230830100830.png]]
2. Si $R=\varepsilon$, entonces ![[Pasted image 20230830100856.png]]
3. Si $R=\emptyset$, entonces ![[Pasted image 20230830100918.png]]
4. Si $R=(R_1+R_2)$ donde $R_1$ y $R_2$ son expresiones regulares, entonces
![[Pasted image 20230830100943.png]]
![[Pasted image 20230830101342.png]]
5. Si $R=(R_1\cdot R_2)$ donde $R_1$ y $R_2$ son expresiones regulares
![[Pasted image 20230830101430.png]]
![[Pasted image 20230830101437.png]]
6. Si $R=(R_1^*)$ donde $R_1$ es una expresión regular
![[Pasted image 20230830101523.png]]
![[Pasted image 20230830102546.png]]
### Teorema
Para toda $R\in\text{ExpReg}$, existe un $\varepsilon$-NFA $\mathcal{A}_R$ tal que:
$$\mathcal{L}(R)=\mathcal{L}(\mathcal{A}_R)$$
En otras palabras, $\text{ExpReg}\subseteq\varepsilon$-NFA

---
# Desde Autómatas a Expresiones Regulares
Dado un autómata finito no-determinista con un único estado inicial
$$\mathcal{A}=(Q,\Sigma,\Delta,q_0,F)$$
Para $X\subseteq Q$ y $p,q\in Q$, considere el conjunto:
$$\alpha_{p,q}^X\subseteq\Sigma^*$$
$w=a_1...a_n\in\alpha_{p,q}^X$ ssi existe una ejecución:
$$\rho:p_0\rightarrow^{a_1}...\rightarrow^{a_n}p_n$$
1. $(p_i,a_{i+1},p_{i+1})\in\Delta$ para todo $i\in[0,n-1]$
2. $p_0=p$
3. $p_n=q$
4. $p_i\in X$ para todo $i\in[1,n-1]$
> El conjunto de todas las palabras $w$ tal que existe un camino desde $p$ a $q$ etiquetado por $w$ y todos los estados en este camino están en $X$ con la posible excepción de $p$ y $q$.

### Lema
$$\mathcal{L}\mathcal(A)=\bigcup\limits_{q\in F}{\alpha_{q_0,q}^Q}$$
## Algoritmo de McNaughton-Yamada
1. Para cada $\alpha_{p,q}^X$, definir inductivamente una expresión regular $R_{p,q}^X$ como sigue: $$\mathcal{L}(R_{p,q}^X)=\alpha_{p,q}^X$$
2. Para $F=\{p_1,...,p_k\}$ definir la expresión regular: $$R_\mathcal{A}=R_{q_0,p_1}^Q+R_{q_0,p_2}^Q+...+R_{q_0,p_k}^Q$$
3. Demostrar que: $$\mathcal{L}\mathcal(A)=\mathcal{L}(R_\mathcal{A})$$
![[Pasted image 20230902191455.png]]
![[Pasted image 20230902191503.png]]
> Un compañero escribió:
> Básicamente
> Para la entrada [i,j] de la tabla dado que se agregó el estado q desde la anterior
> [i,j] del anterior + [i,q] del anterior ([q,q] del anterior)* [q,j] del anterior