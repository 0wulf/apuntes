# Demostración
Para demostrar este teorema, mostraremos como construir un NFA a partir de un $\varepsilon$-NFA, removendo las $\varepsilon$-transiciones. Luego mostramos que esta construcción define el mismo lenguaje definido por el $\varepsilon$-NFA.
## Construcción
Dado un $\varepsilon$-NFA $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ se define el NFA
$$\mathcal{A}^{\not\in}=(Q,\Sigma,\Delta^{\not\in},I,F^{\not\in})$$
![[Pasted image 20230902184837.png]]
Por definición, si $(p,a,q)\in\Delta$ entonces $(p,a,q)\in\Delta^{\not\in}$ para todo $a\in\Sigma$
## Teorema 
Dado un $\varepsilon$-NFA $mathcal{A}=(Q,\Sigma,\Delta,I,F)$ se tiene que:$$\mathcal{L}\mathcal(A)=\mathcal{L}(\mathcal{A}^{\not\in})$$
![[Pasted image 20230902185359.png]]
![[Pasted image 20230902185421.png]]
![[Pasted image 20230902185443.png]]
