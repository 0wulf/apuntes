### ¿Qué lenguajes no son regulares?
Primero que todo, todo lenguaje finito es regular.
Tome por ejemplo el lenguaje $L=\{a^ib^i|i\geq 0\}$
¿Cómo demostramos que $L$ no es regular?
# Lema de Bombeo
Sea $L\subseteq\Sigma^*$. Si $L$ es regular, entonces se cumple el lema de bombeo:
### $(LB)$
- Existe un $N>0$ tal que
- Para toda palabra $x\cdot y \cdot z\in L$ con $|y|\geq N$
- Existen palabras $u\cdot v\cdot w=y$ con $v\not=\varepsilon$ tal que
- Para todo $i\geq 0$ se tiene que $x\cdot u\cdot v^i\cdot w \cdot z\in L$
## Contrapositivo del Lema de Bombeo
### $(¬LB)$
- Para todo $N>0$
- Existe una palabra $x\cdot y\cdot z\in L$ con $|y|\geq N$ tal que
- Para todo $u\cdot v\cdot w=y$ con $v\not=\varepsilon$
- Existe un $i\geq 0$ tal que $x\cdot u\cdot v^i\cdot w\cdot z\not\in L$
# Jugando contra un adversario
El adversario elige los valores que van dentro de los para todo (en $¬(LB)$)
Uno elige los valores que van en los existe
![[Pasted image 20230904100818.png]]
Aplique el juego en el ejemplo del inicio:
![[Pasted image 20230904100828.png]]
> $a^Nb^nb^{2m}b^l\varepsilon$ 
> $a^Nb^{N+m}$

"Dado un lenguaje $L\subseteq\Sigma^*$, si UNO tiene una estrategia ganadora en el juego $(¬LB)$ para toda estrategia posible del adversario, entonces $L$ NO es regular"