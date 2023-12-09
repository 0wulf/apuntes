# ¿Cómo minimizamos un autómata?
1. Eliminar estados inalcanzables
	- Fácil de realizar y no cambia el lenguaje del autómata finito
2. Colapsar estados "equivalentes"
	- ¿Cómo sabemos qué estados podemos colapsar?
e.g. 1:
![[Pasted image 20230911131957.png]]![[Pasted image 20230911132005.png]]![[Pasted image 20230911132035.png]]
e.g. 2:
![[Pasted image 20230911132132.png]]![[Pasted image 20230911132238.png]]

---
# Colapsar estados
## Función de Transición Extendida
Sea $\mathcal{A}=(Q,\Sigma,\delta,q_0,F)$ un DFA.
Se define la función de transición extendida 
$$\hat\delta(q,\varepsilon):Q\times\Sigma^*\rightarrow Q$$
inductivamente como:
$$\hat\delta(q,\varepsilon):=q$$
$$\hat\delta(q,w\cdot a):=\delta(\hat\delta(q,w),a)$$
---
## Recordatorio relaciones de equivalencia
Una relación $\approx_R$ sobre un conjunto $X$ se dice de **equivalencia** si
- Es reflexiva: $\forall p\in X. p\approx_R p$
- Es simétrica: $\forall p,q\in X.\text{ si }p\approx_Rq\text{ entonces }q\approx_R p$
- Es transitiva: $\forall p,q,r\in X.\text{ si }p\approx_R q\text{ y }q\approx_Rr,\text{ entonces }p\approx_Rr$

Para un elemento $p\in X$ se define su **clase de equivalencia** según $\approx_R$ como
$$[p]_{\approx_R}=\{q|q\approx_R p\}$$

Una función $f:X\rightarrow X$ se dice bien definida sobre $\approx_R$ si
$$p\approx_R q\text{ entonces }f(p)\approx_R f(q)$$

La relación $\approx_{\mathcal{A}}$ es una relación de equivalencia.

---
## ¿Cómo podemos colapsar dos estados?
Sea $\mathcal{A}=(Q,\sigma,\delta,q_0,F)$ un DFA y $p,q\in Q$ 
Decimos que $p$ y $q$ son **indistinguibles** $(p\approx_{\mathcal{A}}q)$ si:
$$p\approx_{\mathcal{A}}q \text{ ssi. }(\hat\delta(p,w)\in F \Leftrightarrow \hat\delta(q,w)\in F)\text{, para todo }w\in\Sigma^*$$
Si desde $p$ al leer $w$ llego a un estado final ssi desde $q$ al leer $w$ llego a un estado final.
### Propiedades
- La relación $\approx_\mathcal{A}$ es de equivalencia
	- Es reflexiva: $\forall p\in X. p\approx_\mathcal{A} p$
	- Es simétrica: $\forall p,q\in X.\text{ si }p\approx_\mathcal{A}q\text{ entonces }q\approx_\mathcal{A} p$
	- Es transitiva: $\forall p,q,r\in X.\text{ si }p\approx_\mathcal{A} q\text{ y }q\approx_\mathcal{A}r,\text{ entonces }p\approx_\mathcal{A}r$
- Cada estado $p\in Q$ está exactamente en una clase de equivalencia:$$[p]_{\approx_\mathcal{A}}=\{q|q\approx_\mathcal{A
}p\}$$
- Para todo $a\in\Sigma$ la función $\delta(\cdot, a):Q\rightarrow Q$ está bien definida sobre $\approx_\mathcal{A}$
$$p\approx_\mathcal{A}q\text{ entonces }\delta(p,a)\approx_\mathcal{A}\delta(q,a)$$
---
## El autómata cuociente
Para un DFA $\mathcal{A}=(Q,\Sigma,\delta,q_0,F)$ se define el DFA
$$(\mathcal{A}/\approx)=(Q_\approx,\Sigma,\delta_\approx,q_\approx,F_\approx)$$
- $Q_\approx=\{[p]_{\approx_\mathcal{A}}|p\in Q\}$
- $\delta_\approx([p]_{\approx_\mathcal{A}},a)=[\delta(p,a)]_{\approx_\mathcal{A}}$
- $q_\approx=[q_0]_{\approx_\mathcal{A}}$
- $F_\approx=\{[p]_{\approx_\mathcal{A}}|p\in F\}$ 
### Teorema
Para todo DFA $\mathcal{A}$ se cumple
$$\mathcal{L}(\mathcal{A})=\mathcal{L}(\mathcal{A}/\approx)$$
#### Demostración
![[Pasted image 20230911141047.png]]
![[Pasted image 20230911141054.png]]

----
# Algoritmo de minimización
Buscamos los pares que son distinguibles.
## Búsqueda de clase de estados distinguibles
1. Construya una tabla con los pares $\{p,q\}$ inicialmente sin marcar.
2. Marque $\{p,q\}$ si $p\in F$ y $q\not\in F$ o viceversa.
3. Repita este paso hasta que no hayan mas cambios
	- Si $\{p,q\}$ no están marcados y $\{\delta(p,a),\delta(q,a)\}$ están marcados para algún $a\in\Sigma$, entonces marque $\{p,q\}$.
4. Al terminar, $p\not\approx_\mathcal{A}q$ ssi. la entrada $\{p,q\}$ está marcada.
### e.g
![[Pasted image 20230911153546.png]]
![[Pasted image 20230911153556.png]]
![[Pasted image 20230911153628.png]]
![[Pasted image 20230911153801.png]]
![[Pasted image 20230911153811.png]]
![[Pasted image 20230911153821.png]]
![[Pasted image 20230911153832.png]]
![[Pasted image 20230911153856.png]]
![[Pasted image 20230911153917.png]]
