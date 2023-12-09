# Definición (Sintaxis)
$R$ es una expresión regular sobre $\Sigma$ si $R$ es igual a:
1. $a$ para alguna letra $a\in\Sigma$
2. $\varepsilon$
3. $\emptyset$
4. $(R_1+R_2)$ donde $R_1$ y $R_2$ son expresiones regulares
5. $(R_1\cdot R_2)$ donde $R_1$ y $R_2$ son expresiones regulares
6. $(R_1^*)$ donde $R_1$ es una expresión regular

Denotaremos como $ExpReg$ el conjunto de todas las expresiones regulares sobre $\Sigma$.

Los operadores unión $+$ y producto $\cdot$ son asociativos

---
# Orden de precedencia
1. Estrella $(\cdot)^*$
2. Concatenación $\cdot$
3. Unión $+$
---
# Definición (Semántica)
Para una expresión regular $R$ cualquiera, se define el lenguaje $\mathcal{L}(R)\subseteq\Sigma^*$ inductivamente como:
1. $\mathcal{L}(a)=\{a\}$ para toda letra $a\in\Sigma$
2. $\mathcal{L}(\varepsilon)=\{\varepsilon\}$
3. $\mathcal{L}(\emptyset)=\emptyset$
4. $\mathcal{L}(R_1+R_2)=\mathcal{L}(R_1)\cup\mathcal{L}(R_2)$ donde $R_1$ y $R_2$ son expresiones regulares
5. $\mathcal{L}(R_1\cdot R_2)=\mathcal{L}(R_1)\cdot\mathcal{L}(R_2)$ donde $R_1$ y $R_2$ son expresiones regulares
6. $\mathcal{L}(R_1^*)=\bigcup\limits_{k=0}^{\infty}{\mathcal{L}(R_1)^k}$ donde $R_1$ es una expresión regular

Esto quiere decir que cada expresión regular define un lenguaje

---
# Producto entre lenguajes
Para dos lenguajes $L_1,L_2\subseteq\Sigma^{*}$ se define el producto de $L_1$ y $L_2$:
$$
L_1\cdot L_2=\{w_1\cdot w_2|w_1\in L_1 \wedge w_2\in L_2\}
$$
---
# Potencia de un lenguaje
Para un lenguaje $L\subseteq\Sigma^*$, se define la potencia a la $n>0$:
$$
L^n=\{w_1\cdot ... \cdot w_n|\forall i\leq n, w_i\in L\}
$$
$$
L⁰=\{\emptyset\}
$$
---
# Equivalencia entre expresiones regulares
Una expresión regular $R_1$ se dice equivalente a $R_2$ ssi $$\mathcal{L}(R_1)\equiv\mathcal{L}(R_2)$$

---
# Abreviaciones de expresiones regulares
- $R⁺\equiv R\cdot R^*$
- $R^k\equiv R\cdot ... \cdot R$
- $R^?\equiv R+\varepsilon$
- $\Sigma\equiv a_1+...+a_n$
