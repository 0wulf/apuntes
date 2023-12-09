Respecto a minimización de autómatas dejamos varias preguntas abiertas:
1. ¿Cómo sabemos si el autómata del algoritmo es mínimo?
2. Dado $L$, ¿Existe un único autómata mínimo?
3. Dado un $\mathcal{A}$, ¿Es posible construir un autómata mínimo equivalente?
En esta clase demostraremos que:
- El autómata con el mínimo de estados es único
- El algoritmo de minimización siempre construye el autómata mínimo
---
## Estrategia de la demostración
1. Desde un DFA $\mathcal{A}$ definiremos una relación de equivalencia $(RE)\equiv_\mathcal{A}$ entre las palabras en $\Sigma^*$
2. Desde una $RE\equiv$ entre palabras, construiremos un DFA $\mathcal{A}_\equiv$ 
3. A partir de un lenguaje $L$, definiremos una $RE\equiv_L$
4. $\mathcal{A}_{\equiv_L}$ define el autómata con la menor cantidad de estados
5. $\mathcal{A}_{\equiv_L}$ es equivalente al resultado de nuestro algoritmo de minimización
donde $RE$ significa relación de equivalencia.
---
# Relaciones de Myhill-Nerode
Sea $L\subseteq\Sigma^*$ un lenguaje cualquiera.
Decimos que una relación de equivalencia $\equiv$ entre palabras de $\Sigma^*$ es una relación de Myhill-Nerode para $L$ si
1. $\equiv$ es una congruencia por la derecha:$$u\equiv v\text{ entonces }u\cdot w\equiv v\cdot w$$
2. $\equiv$ refina $L$: $$u\equiv v\text{ entonces }(u\in L \Leftrightarrow v\in L)$$
3. El número de clases de equivalencia de $\equiv$ es finita
---
## 1. Relación de equivalencia dada por un DFA
Sea $L\subseteq\Sigma^*$ un lenguaje regular  $\mathcal{A}=(Q,\Sigma,\delta,q_0,F)$ un DFA tal que $L=\mathcal{L}(\mathcal{A})$
Se define la relación de equivalencia $\equiv_\mathcal{A}$ entre palabras de $\Sigma^*$ como:
$$u\equiv_\mathcal{A}v\Leftrightarrow\hat\delta(q_0,u)=\hat\delta(q_0,v)$$
### ¿Es $\equiv_\mathcal{A}$ una relación de equivalencia?
- Reflexiva: $u\equiv_\mathcal{A}u$ para todo $u\in\Sigma^*$
- Simétrica: si $u\equiv_\mathcal{A}v$ entonces $v\equiv_\mathcal{A}u$
- Transitiva: si $u\equiv_\mathcal{A}v$ y $v\equiv_\mathcal{A}w$ entonces $u\equiv_\mathcal{A}w$
Para $w\in\Sigma^*$ se define su clase de equivalencia según $\equiv_\mathcal{A}$ como:$$[w]_{\equiv_\mathcal{A}}=\{u|u\equiv_\mathcal{A}w\}$$
### Es importante no confundir $\approx_\mathcal{A}$ sobre estados, con $\equiv_\mathcal{A}$ sobre palabras
![[Pasted image 20230911162947.png]]
### La relación de equivalencia $\equiv_\mathcal{A}$ es una relación de Myhill-Nerode para todo DFA $\mathcal{A}$
---
## 2. Construcción del DFA $\mathcal{A}_\equiv$
Dada una relación de Myhill-Nerode $\equiv$ para $L\subseteq\Sigma^*$, definimos el autómata:$$\mathcal{A}_\equiv=(Q_\equiv,\Sigma,\delta_\equiv,q_\equiv,F_\equiv)$$
- $Q_\equiv=\{[w]_\equiv|w\in\Sigma^*\}$
- $q_\equiv=[\varepsilon]_\equiv$
- $F_\equiv=\{[w]_\equiv|w\in L\}$
- $\delta_\equiv([w]_\equiv,a)=[wa]_\equiv$
#### Teorema
$$\mathcal{L}(\mathcal{A}_\equiv)=L$$

---
## $\mathcal{A}\rightarrow\equiv_\mathcal{A}$ y $\equiv\rightarrow\mathcal{A}_\equiv$ son procesos inversos
#### Teorema
1. Si $\mathcal{A}$ es un DFA que acepta $L$ y si construimos: $$\mathcal{A}\rightarrow\equiv_\mathcal{A}\rightarrow\mathcal{A}_{\equiv_\mathcal{A}}$$ entonces $\mathcal{A}$ es isomorfo ("equivalente") a $\mathcal{A}_{\equiv_\mathcal{A}}$
2. Si $\equiv$ es una relación de Myhill-Nerode para $L$  si construimos:$$\equiv\rightarrow\mathcal{A}_\equiv\rightarrow\equiv_{\mathcal{A}_\equiv}$$ entonces la relación $\equiv$ es equivalente a $\equiv_{\mathcal{A}_\equiv}$
---
# Teorema de Myhill-Nerode
## La relación $\equiv_L$ de un lenguaje $L$
Dado un lenguaje $L\subseteq\Sigma^*$, se define la relación de equivalencia $\equiv_L$ como
$$u\equiv_Lv\text{ ssi. } (u\cdot w\in L\Leftrightarrow v\cdot w\in L) \forall w\in\Sigma^*$$
### ¿Es $\equiv_L$ una relación de equivalencia?
- Reflexiva: $u\equiv_Lu$ para todo $u\in\Sigma^*$
- Simétrica: si $u\equiv_Lv$ entonces $v\equiv_Lu$
- Transitiva: si $u\equiv_Lv$ y $v\equiv_Lw$ entonces $u\equiv_Lw$

![[Pasted image 20230911165526.png]]

### Propiedades
1. $\equiv_L$ es una congruencia por la derecha: $$u\equiv_Lv\text{ entonces }u\cdot w\equiv_Lv\cdot w$$
2. $\equiv_L$ refina $L$: $$u\equiv_Lv\text{ entonces }(u\in L \Leftrightarrow v\in L)$$
3. Si $\equiv$ es una congruencia por la derecha y refina $L$ entonces $\equiv$ refina $\equiv_L$: $$u\equiv v\text{ entonces }u\equiv_Lv$$
$\equiv_L$ es la congruencia por la derecha más gruesa que refina a $L$.

---
## Teorema de Myhill-Nerode
Sea $L\subseteq\Sigma^*$. Las siguientes propiedades son equivalentes:
1. $L$ es regular
2. Existe una relación de Myhill-Nerode para $L$
3. La relación $\equiv_L$ tiene una cantidad finita de clases de equivalencia.
![[Pasted image 20230911170203.png]]
### Conclusiones a partir del teorema
1. $\equiv_L\rightarrow\mathcal{A}_{\equiv_L}$ produce un autómata con la menor cantidad de estados.
2. Todos los autómatas $\mathcal{A}$ tales que $\equiv_\mathcal{A}=\equiv_L$ son isomorfos.
3. El algoritmo de minimización produce un autómata isomorfo a $\mathcal{A}_{\equiv_L}$
![[Pasted image 20230911170420.png]]
