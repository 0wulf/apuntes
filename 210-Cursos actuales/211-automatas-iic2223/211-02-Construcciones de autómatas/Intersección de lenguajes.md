Suponga que
$$\mathcal{A}=(Q,\Sigma,\delta,q_0,F)$$
$$\mathcal{A'}=(Q',\Sigma,\delta',q_0',F')$$
y considere la palabra $w\in\Sigma^*$
¿Cómo ejecutamos ambos autómatas sobre $w$ al mismo tiempo? 
# Producto de autómatas
Se define el autómata $\mathcal{A}\times\mathcal{A}'=(Q^{\times},\Sigma,\delta^{\times},q_0^{\times},F^{\times})$ tal que
- $Q^{\times}=Q\times Q'=\{(q,q')|q\in Q \wedge q'\in Q'\}$
- $\delta^{\times}((q,q'),a)=(\delta(q,a),\delta'(q',a))$
- $q_0^{\times}=(q_0,q_0')$
- $F^{\times}=F\times F'$
# Teorema
Para todo par de autómatas $\mathcal{A}$ y $\mathcal{A}'$ se tiene que:
$$
\mathcal{L}(\mathcal{A}\times\mathcal{A}')=\mathcal{L}(\mathcal{A})\cap\mathcal{L}(\mathcal{A}')
$$
