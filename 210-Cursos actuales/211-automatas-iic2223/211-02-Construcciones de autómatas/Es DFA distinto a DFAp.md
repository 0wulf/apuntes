# Proposición
Para todo autómata $\mathcal{A}$ con función parcial de transición, existe un autómata $\mathcal{A}'$ con función total de transición tal que:
$$\mathcal{L}(\mathcal{A})=\mathcal{L}(\mathcal{A}')$$
# Demostración
Sea $\mathcal{A}=(Q,\Sigma,\gamma,q_0,F)$ un autómata con función parcial de transición.
Sea $q_s$ un estado nuevo tal que $q_s{\not\in}Q$ conocido como estado sumidero.
Construimos un DFA $\mathcal{A}'=(Q\cup \{q_s\},\Sigma,\delta ',q_0,F)$ tal que
![[Pasted image 20230819121144.png]]
para todo $p\in Q\cup\{q_s\}$ y $a\in\Sigma$
![[Pasted image 20230819121304.png]]
![[Pasted image 20230819121312.png]]
![[Pasted image 20230819121319.png]]
