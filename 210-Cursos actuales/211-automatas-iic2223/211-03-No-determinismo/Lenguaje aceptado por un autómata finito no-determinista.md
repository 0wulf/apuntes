Sea un autómata NFA $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$
### Definiciones
- $\mathcal{A}$ acepta $w$ si **existe alguna** ejecución de $\mathcal{A}$ sobre $w$ que es de aceptación
- $\mathcal{A}$ rechaza $w$ si **todas** las ejecuciones de $\mathcal{A}$ sobre $w$ **no** son de aceptación.
- El lenguaje aceptado por $\mathcal{A}$ se define como
$$\mathcal{L}\mathcal(A)=\{w\in\Sigma^{*}|\mathcal{A}\text{ acepta }w\}$$