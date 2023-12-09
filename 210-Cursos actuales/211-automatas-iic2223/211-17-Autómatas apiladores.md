### Autómatas vs. Algoritmos
![[Pasted image 20231025094709.png]]
Agregaremos un stack a los autómatas, que nos permitirá definir lenguajes libres de contexto
Las CFG utilizan recursión. Acá utilizamos un stack para hacer lo mismo de manera iterativa.

---
# Autómatas Apiladores
![[Pasted image 20231025094903.png]]
## Definición
Un **autómata apilador** (PushDown Automata, PDA) es una estructura $$\mathcal{P}=(Q,\Sigma,\Gamma,\Delta,q_0,\bot,F)$$ donde
- $Q$ es un conjunto finito de estados
- $\Sigma$ es el alfabeto de input
- $q_{0}\in Q$ es el estado inicial
- $F$ es el conjunto de estados finales
- $\Gamma$ es el alfabeto de stack
- $\bot\in\Gamma$ es el símbolo inicial de stack
- $\Delta\subseteq (Q\times(\Sigma\cup\{\varepsilon\})\times\Gamma)\times(Q\times\Gamma^*)$ es una relación finita de transición

Intuitivamente, la transición $$((p,a,A),(q,B_1B_2...B_k))\in\Delta$$ significa que si el autómata apilador
- está en el estado $p$
- leyendo la letra $a$
- y en el tope del stack hay una $A$
entonces
- pasa al estado $q$
- y modifica el tope $A$ por $B_1...B_k$

Intuitivamente, la transición en vacío $$((p,\varepsilon,A),(q,B_1...B_k))\in\Delta$$ significa que el autómata apilador
- está en el estado $p$ y
- en el tope del stack hay una $A$
entonces
- pasa al estado $q$
- y modifica el tope $A$ por $B_1...B_k$
sin la lectura de una letra.

![[Pasted image 20231025100004.png]]
![[Pasted image 20231025100011.png]]
## Configuración de un autómata apilador
![[Pasted image 20231025100037.png]]
![[Pasted image 20231025100045.png]]
## Ejecución de un autómata apilador
![[Pasted image 20231025100115.png]]
El siguiente ejemplo define un lenguaje libre de contexto pero no un lenguaje regular
![[Pasted image 20231025100121.png]]
> Para que acepte necesitamos una transición que saque $\bot$ para saber que terminó la ejecución
> No podemos "leer $\varepsilon$ desde el stack"
## Lenguajes de un autómata apilador
![[Pasted image 20231025100512.png]]
![[Pasted image 20231025101013.png]]
## Ejemplo de autómatas apiladores
![[Pasted image 20231025101031.png]]
1. ![[Pasted image 20231025102319.png]]
2. ![[Pasted image 20231025103739.png]]
---
# Definición alternativa de autómata apilador
![[Pasted image 20231025103426.png]]
![[Pasted image 20231025103444.png]]
![[Pasted image 20231025103502.png]]
## Configuración de un autómata apilador alternativo
![[Pasted image 20231025103914.png]]
## Ejecución de un autómata apilador alternativo
![[Pasted image 20231025103947.png]]
## Lenguajes de un autómata apilador alternativo
![[Pasted image 20231025104005.png]]
![[Pasted image 20231025104042.png]]

---
## Equivalencia entre modelos
![[Pasted image 20231025104521.png]]
![[Pasted image 20231025104534.png]]
![[Pasted image 20231025104540.png]]
![[Pasted image 20231025104547.png]]
![[Pasted image 20231025104559.png]]

---
### Bibliografía
[[Automata and Computability.pdf]] Capítulo 23