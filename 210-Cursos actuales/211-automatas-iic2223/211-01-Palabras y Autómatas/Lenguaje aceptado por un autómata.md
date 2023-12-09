Sea un autómata $\mathcal{A}=(Q,\Sigma,\delta,q_0,F)$ y $w\in\Sigma^*$ 
### Definiciones
* $\mathcal{A}$ **acepta** $w$ si la ejecución de $\mathcal{A}$ sobre $w$ es una ejecución de aceptación.
* $\mathcal{A}$ **rechaza** $w$ si la ejecución de $\mathcal{A}$ sobre $w$ NO es una ejecución de aceptación.
* El **lenguaje aceptado** o definido por $\mathcal{A}$ se define como
$$\mathcal{L}(\mathcal{A})=\{w\in\Sigma^*|\mathcal{A}\text{ acepta }w\}$$
* Un lenguaje $L\subseteq\Sigma^*$ se dice **regular** si y solo si **existe** un autómata finito determinista $\mathcal{A}$ tal que:
$$L=\mathcal{L}(\mathcal{A})$$

![[Pasted image 20230809103553.png]]
![[Pasted image 20230809103651.png]]
# [[Función de transición extendida]]