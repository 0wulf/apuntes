## Autómatas versus Algoritmos
#### ¿Qué tienen en común un autómata y un algoritmo?
1. Lectura de un input
2. Ejecución de pasos de acuerdo al input
3. Registro de información en variables/memoria
#### ¿Qué le falta a los autómatas?
1. El input puede leerse más de una vez $\checkmark$
2. Puede producirse un output $\checkmark$
3. Uso de estructuras de datos
4. La cantidad de memoria puede depender del input
---
# Gramáticas Libres de Contexto
## Definición
Una **gramática libre de contexto** (CFG) es una tupla
$$\mathcal{G}=(V,\Sigma,P,S)$$
donde
- $V$ es un conjunto finito de variables o no-terminales
- $\Sigma$ es un alfabeto finito o un conjunto de terminales, tal que $\Sigma \cap V = \emptyset$
- $P\subseteq V\times (V \cup \Sigma)^*$ es un subconjunto finito de producciones o reglas
- $S\in V$ es la variable inicial
#### E.g.
Considere la gramática $\mathcal{G}=(V,\Sigma,P,S)$ tal que:
- $V=\{X,Y\}$
- $\Sigma=\{a,b\}$
- $P=\{(X,Y),(X,ab),(X,aXb),(Y,\varepsilon)\}$
- $S=X$
![[Pasted image 20231012111618.png]]
---
## Notación para gramáticas libres de contexto
- Para las variables en una gramática usaremos letras mayúsculas $X, Y, Z, A, B, C$
- Para los terminales en una gramática usaremos letras minúsculas $a,b,c$
- Para las palabras en $(V\cup\Sigma)^*$ usaremos símbolos $\alpha,\beta,\gamma$
- Para una producción $(A,\alpha)\in P$ la escribimos como $A\rightarrow\alpha$
#### Simplificación
![[Pasted image 20231011100215.png]]

---
## Producciones
Vamos a usar la misma palabra (producciones) para las reglas como para estas producciones que definiremos ahora.
### Definición
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
Se define la relación $\Rightarrow \subseteq (V\cup\Sigma)^*\times(V\cup\Sigma)^*$ de **producción** entre palabras
$$\alpha\cdot X\cdot\beta\Rightarrow\alpha\cdot\gamma\cdot\beta \text{ ssi } (X\rightarrow\gamma)\in P$$
para todo $X\in V$ y $\alpha,\beta,\gamma\in(V\cup\Sigma)^*$
Luego, si $\alpha X\beta\Rightarrow\alpha\gamma\beta$ entonces decimos que
- $\alpha X\beta$ produce $\alpha\gamma\beta$ o
- $\alpha\gamma\beta$ es producible desde $\alpha X\beta$
## Derivaciones
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
Se define $\xRightarrow{*}$ como la clausura refleja y transitiva de $\Rightarrow$
- $\alpha\xRightarrow{*}\alpha$
- $\alpha\xRightarrow{*}\beta$ ssi existe $\gamma$ tal que $\alpha\xRightarrow{*}\gamma\wedge\gamma\Rightarrow\beta$
para todo $\alpha,\beta\in(V\cup\Sigma)^*$

Intuitivamente, dadas dos palabras $\alpha,\beta\in(V\cup\Sigma)^*$, decimos que $\alpha$ deriva $\beta$ $$\alpha\xRightarrow{*}\beta$$ si existen $\alpha_1,...,\alpha_n\in(V\cup\Sigma)^*$ tales que $$\alpha\Rightarrow\alpha_1\Rightarrow\alpha_2\Rightarrow...\Rightarrow\alpha_n\Rightarrow\beta$$

(aca las palabras pueden contener variables, abajo no)

---
## Lenguaje definido por una gramática
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
### Definición
El lenguaje de una gramática $\mathcal{G}$ se define como
$$\mathcal{L}(\mathcal{G})=\{w\in\Sigma^*|S\xRightarrow{*}{w}\}$$
Así, $\mathcal{L}(\mathcal{G})$ son todas las palabras en $\Sigma^*$ que se pueden derivar desde $S$.
![[Pasted image 20231011101307.png]]
#### E.g.
![[Pasted image 20231011101412.png]]
![[Pasted image 20231011101420.png]]

---
## Lenguajes libres de contexto
### Definición
Diremos que $L\subseteq\Sigma^*$ es un lenguaje libre de contexto ssi. existe una gramática libre de contexto $\mathcal{G}$ tal que
$$L=\mathcal{L}(\mathcal{G})$$
![[Pasted image 20231011102144.png]]

---
# Árboles y derivaciones
## Árboles ordenados y etiquetados
### Definiciones
El conjunto de **árboles ordenados y etiquetados** (o solo árboles) sobre etiquetas $\Sigma$ y $V$, se define recursivamente como
- $t:=a$ es un árbol para toso $a\in\Sigma$
- si $t_1,...,t_k$ son árboles, entonces $t:=X(t_1,...,t_k)$ es un árbol para todo $X\in V$

Para un árbol $t=X(t_1,...,t_k)$ cualquiera, se define
- $raiz(t)=X$
- $hijos(t)=t_1,...,t_k$
Si $t=a$, entonces decimos que $t$ es una hoja, y definimos $raiz(t)=a\wedge hijos(t)=\varepsilon$ 

---
## Árboles de derivación de una gramática
Dada una CFG $\mathcal{G}=(V,\Sigma,P,S)$ 
### Definiciones
1. Se define el conjunto de **árboles de derivación**, recursivamente, como:
	- Si $a\in\Sigma$, entonces $t=a$ es un árbol de derivación
	- Si $X\rightarrow X_1,...,X_k$ y $t_1,...,t_k$ son árboles de derivación con $raiz(t_i)=X_i$ para todo $i\leq k$ entonces $t=X(t_1,...,t_k)$ es un árbol de derivación

2. Decimos que $t$ es un **árbol de derivación de $\mathcal{G}$** si
	1. $t$ es un árbol de derivación y
	2. $raiz(t)=S$
> Los árboles de derivación de $\mathcal{G}$ son todos los árboles que parten desde $S$

![[Pasted image 20231011103823.png]]

---
## Árbol de derivación para una palabra
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG y $w\in\Sigma^*$
### Definiciones
1. Se define la función $yield()$ sobre árboles, recursivamente, como
	- Si $t=a\in\Sigma$ entonces $yield(t)=a$
	- Si $t$ no es una hoja y además $hijos(t)=t_1...t_k$, entonces	$$yield(t)=yield(t_1)\cdot...\cdot yield(t_k)$$
2. Decimos que $t$ es un **árbol de derivación de $\mathcal{G}$ para $w$** si
	1. $t$ es un árbol de derivación de $\mathcal{G}$ y
	2. $yield(t)=w$
> Las hojas de $t$ forman la palabra $w$
---
## Equivalencia entre árboles de derivación y derivaciones
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG y $w\in\Sigma^*$
### Proposición
$w\in\mathcal{L}(\mathcal{G})$ ssi existe un árbol de derivación de $\mathcal{G}$ para $w$

> Un árbol de derivación es la representación gráfica de una derivación
![[Pasted image 20231012113112.png]]
---
## Derivaciones por la izquierda y por la derecha
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
### Definiciones
- Definimos la **derivación por la izquierda** $\xRightarrow[lm]{}\subseteq(V\cup\Sigma)^*\times(V\cup\Sigma)^*$ como $$(w\cdot X\cdot\beta\xRightarrow[lm]{}{w\cdot\gamma\cdot\beta} )\Leftrightarrow (X\rightarrow\gamma\in P)$$ para todo $X\in V, w\in\Sigma^*$ y $\beta,\gamma\in(V\cup\Sigma)^*$
- Definimos la **derivación por la derecha** $\xRightarrow[rm]{}\subseteq(V\cup\Sigma)^*\times(V\cup\Sigma)^*$ como $$(\alpha\cdot X\cdot w\xRightarrow[rm]{}{\alpha\cdot\gamma\cdot w} )\Leftrightarrow (X\rightarrow\gamma\in P)$$ para todo $X\in V, w\in\Sigma^*$ y $\alpha,\gamma\in(V\cup\Sigma)^*$
- Se definen $\xRightarrow[lm]{*}$ y $\xRightarrow[rm]{*}$ como las clausuras refleja y transitiva de $\xRightarrow[lm]{}$ y $\xRightarrow[rm]{}$ respectivamente
> $\xRightarrow[lm]{}$ y $\xRightarrow[rm]{}$  solo reemplazan a la izquierda (leftmost) y derecha (rightmost)

![[Pasted image 20231012113924.png]]
### Proposición
Por cada árbol de derivación, existe una única derivación por la izquierda y una única derivación por la derecha
> Desde ahora podemos hablar de árbol de derivación y derivación (izquierda o derecha) indistintamente
---
# Lenguajes regulares versus Lenguajes libres de contexto
Ya demostramos que 
- $\{a^nb^n|n\geq0\}$ no es regular
- $\{a^nb^n|n\geq0\}$ es libre de contexto
Por lo tanto, Lenguajes Regulares $\neq$ Lenguajes Libres de Contexto
### Lenguajes Regulares $\subsetneq$ Lenguajes Libres de Contexto
#### Proposición
Para todo lenguaje regular $L$ existe una gramática libre de contexto $\mathcal{G}_\mathcal{A}$ tal que $$L=\mathcal{L}(\mathcal{G}_\mathcal{A})$$
#### Demostración
Dado un DFA $\mathcal{A}=(Q,\Sigma,\delta,q_0,F)$ defina la gramática $\mathcal{G}_\mathcal{A}=(Q,\Sigma,P_\mathcal{A},q_0)$ tal que:
- Si $\delta(p,a)=q$ entonces $p\rightarrow aq\in P_\mathcal{A}$
- Si $p\in F$ entonces $p\rightarrow\varepsilon\in P_\mathcal{A}$
Luego, $L(\mathcal{A})=L(\mathcal{G}_\mathcal{A})$
Demostración: pizarra
![[Pasted image 20231016101838.png]]
los ? significan que hay que justificar esos pasos de la derivación
no sé si ÉSTE pd es por demostrar o por definición