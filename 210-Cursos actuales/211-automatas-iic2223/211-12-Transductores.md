## Autómatas como modelo de cómputo
#### ¿Qué tienen en común un autómata y un algoritmo?
1. Lectura de un input
2. Ejecución de pasos de acuerdo al input
3. Registro de información en variables/memoria
#### ¿Qué características tiene un algoritmo pero no un autómata?
1. Uso de estructuras de datos
2. La cantidad de memoria puede depender del input
3. El input puede leerse más de una vez
4. Puede producirse un output

> En esta clase agregaremos a los autómatas la capacidad de producir un output
---
# Transductores
![[Pasted image 20231011152013.png]]
## Definición
Un **transductor** es una tupla
$$\mathcal{T}=(Q,\Sigma,\Omega,\Delta,I,F)$$
- $Q$ es un conjunto finito de estados
- $\Sigma$ es el alfabeto de input
- $\Omega$ es el alfabeto de output
- $\Delta\subseteq Q\times(\Sigma\cup\{\varepsilon\})\times(\Omega\cup\{\varepsilon\})\times Q$ es la relación de transición
- $I\subseteq Q$ es un conjunto de estados iniciales
- $F\subseteq Q$ es el conjunto de estados finales
![[Pasted image 20231011152358.png]]
## Configuración de un transductor
Sea $\mathcal{T}=(Q,\Sigma,\Omega,\Delta,I,F)$ un transductor
### Definiciones
- Una tupla  $(q,u,v)\in Q\times\Sigma^*\times\Omega^*$ es una configuración de $\mathcal{T}$
- Una configuración $(q,u,\varepsilon)$ se dice inicial si $q\in I$
- Una configuración $(q,\varepsilon,v)$ se dice final si $q\in F$
> Intuitivamente, la configuración $(q,au,vb)$ representa que $\mathcal{T}$ está en el estado $q$ procesando la palabra $au$, leyendo la letra $a$, ha escrito la palabra $vb$ con el último símbolo escrito $b$.
## Ejecución de un transductor
Sea $\mathcal{T}=(Q,\Sigma,\Omega,\Delta,I,F)$ un transductor
### Definiciones
- Se define la relación $\vdash_\mathcal{T}$ de **siguiente-paso** entre configuraciones de $\mathcal{T}$ 
$$(p,u_1,v_1)\vdash_\mathcal{T}(q,u_2,v_2)$$
	si y solo si existe $(p,a,b,q)\in\Delta$ tal que $u_{1}=a\cdot u_{2}\wedge v_{2}=v_{1}\cdot b$ 
	
- Se define $\vdash_\mathcal{T}^*$ como la clausura refleja y transitiva de $\vdash_\mathcal{T}$:
	- Para toda configuración $(q,u,v)$:		$$(q,u,v)\vdash_\mathcal{T}^{*}(q,u,v)$$
	- Además, si $(q_1,u_1,v_1)\vdash_\mathcal{T}^{*}(q_2,u_2,v_2)\wedge(q_2,u_2,v_2)\vdash_\mathcal{T}^{*}(q_3,_3,_3)$ entonces
		$$(q_1,u_1,v_1)\vdash_\mathcal{T}^{*}(q_3,u_3,v_3)$$
![[Pasted image 20231011190053.png]]
## Función definida por un transductor
Sea $\mathcal{T}=(Q,\Sigma,\Omega,\Delta,I,F)$ un transductor y $u,v\in\Sigma^*$
### Definiciones
- $\mathcal{T}$ entrega $v$ con input $u$ si existe una configuración inicial $(q_0,u,\varepsilon)$ y una configuración final $(q_f,\varepsilon,v)$ tal que $$(q_0,u,\varepsilon)\vdash_\mathcal{T}^{*}(q_f,\varepsilon,v)$$
![[Pasted image 20231011191022.png]]
> Un transductor define una función de palabras a conjuntos de palabras
## Funciones versus Relaciones
![[Pasted image 20231011191249.png]]

---
# Transductores vs DFA
## Lenguaje de input y lenguaje de output
### Definiciones
Para una relación $R\subseteq\Sigma^*\times\Omega^*$ se define
- La proyección 1 de la relación $\pi_1(R)=\{u\in\Sigma^{*}|\exists v\in\Omega^*.(u,v)\in R\}$
- La proyección 2 de la relación $\pi_2(R)=\{v\in\Omega^{*}|\exists u\in\Sigma^*.(u,v)\in R\}$
![[Pasted image 20230927102129.png]]
### Teorema
![[Pasted image 20230927102612.png]]
![[Pasted image 20231011192818.png]]
> La demostración debería o podría ser la que aparezca en la prueba. si llega a salir en la prueba puedo decir el otro lado es idéntico? sí

---
# Operaciones sobre Transductores
## Operaciones de relaciones
### Teorema
Sea $\mathcal{T}_1$ y $\mathcal{T}_2$ dos transductores con $\Sigma$ y $\Omega$ alfabetos de input y de output.
Las siguientes son relaciones racionales:
![[Pasted image 20230927102900.png]]
### Teorema
Existen transductores $\mathcal{T}_1$ y $\mathcal{T}_2$ sobre $\Sigma$ y $\Omega$ tal que
![[Pasted image 20230927102959.png]]
**NO** es una relación racional.
![[Pasted image 20230927103023.png]]
Esta también podría ser demostración para la prueba
## Transductores para funciones de palabras a palabras
### Definición
Decimos que un transductor $\mathcal{T}$ define una función (parcial) si:
![[Pasted image 20230927103238.png]]
![[Pasted image 20230927103247.png]]
### Definición
Decimos que $\mathcal{T}=(Q,\Sigma,\Omega,\Delta,I,F)$ es **determinista** si cumple que:
![[Pasted image 20230927103431.png]]
![[Pasted image 20230927103453.png]]
